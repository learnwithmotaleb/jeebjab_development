import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeebjab/helper/local_db/local_db.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/service/socket_service.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import '../model/get_message_model.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // ── Chat session info (set from navigation arguments) ──────────────────────
  RxString chatId = ''.obs;
  RxString receiverId = ''.obs;

  // ── Observable messages list ───────────────────────────────────────────────
  RxList<MessageModel> messages = <MessageModel>[].obs;
  RxBool isLoading = false.obs;

  final ApiClient _apiClient = ApiClient();
  final ImagePicker _picker = ImagePicker();
  String currentUserId = '';

  // ── Delivery / driver status ───────────────────────────────────────────────
  RxString deliveryStatus = 'pending'.obs; // pending, active, completed
  RxString driverName = 'Driver'.obs;
  RxString driverImage = AppImages.profileImage.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUser();
    loadChatData();
    _initSocket();
  }

  Future<void> _initSocket() async {
    await SocketApi.init();
    _listenToMessages();
  }

  // Per the Chat Socket.io API: the server echoes a sent message back on
  // the SAME event name it's sent on — 'send_message' — to both sender
  // and receiver, wrapped as {success, statusCode, message, data: {...}}.
  // 'new_message'/'receive_message' aren't part of that contract; kept
  // as a harmless fallback in case a differently-named event is also
  // emitted somewhere.
  void _listenToMessages() {
    SocketApi.on('send_message', _handleIncomingSocketMessage);
    SocketApi.on('new_message', _handleIncomingSocketMessage);
    SocketApi.on('receive_message', _handleIncomingSocketMessage);
    SocketApi.on('message_seen', _handleSeenReceipt);
    SocketApi.on('error_response', (data) {
      debugPrint("🔴 Chat socket error_response: $data");
    });
  }

  // The real message sits under `data` on the socket envelope
  // ({success, statusCode, message, data: {...}}) — reading fields off
  // the envelope itself (as this used to) meant `chatId` was always
  // null, so every incoming message failed the chat-match check and was
  // silently dropped. That's why a message only ever showed up after
  // leaving and reopening the chat (which reloads via the REST endpoint
  // instead). Unwrapped now, with a fallback to the raw payload in case
  // it ever arrives unwrapped.
  void _handleIncomingSocketMessage(dynamic data) {
    try {
      if (data is! Map) return;
      final envelope = Map<String, dynamic>.from(data);
      final payload = envelope['data'] is Map
          ? Map<String, dynamic>.from(envelope['data'])
          : envelope;

      final incomingChatId = payload['chatId']?.toString().trim() ?? '';
      if (incomingChatId != chatId.value.trim()) return;

      final message = MessageModel.fromJson(payload);
      if (messages.any((m) => m.id == message.id)) return;

      messages.insert(0, message);
      scrollToBottom();

      // We're live in this chat right now — tell the sender we've seen
      // it immediately instead of waiting for the next time it's opened.
      if (!message.isMine(currentUserId)) {
        _markMessagesSeen();
      }
    } catch (e) {
      debugPrint("⚠️ Failed to parse incoming socket message: $e | data=$data");
    }
  }

  // {chatId, seenBy} — fired to the ORIGINAL sender once the other side
  // has read the chat. Flips isRead on our own sent messages so the
  // read-receipt tick actually reflects reality instead of staying
  // permanently "sent".
  void _handleSeenReceipt(dynamic data) {
    try {
      if (data is! Map) return;
      final payload = Map<String, dynamic>.from(data);
      if ((payload['chatId']?.toString().trim() ?? '') != chatId.value.trim()) {
        return;
      }

      for (var i = 0; i < messages.length; i++) {
        final m = messages[i];
        if (m.isMine(currentUserId) && !m.isRead) {
          messages[i] = m.copyWith(isRead: true);
        }
      }
    } catch (e) {
      debugPrint("⚠️ Failed to parse message_seen payload: $e | data=$data");
    }
  }

  // Tells the server (and, in real time, the other participant) that we've
  // read this chat. Safe to call repeatedly — it's a no-op server-side
  // once nothing is left unread.
  void _markMessagesSeen() {
    if (chatId.value.isEmpty || receiverId.value.isEmpty) return;
    SocketApi.emit('message_seen', {
      'chatId': chatId.value,
      'senderId': receiverId.value,
    });
  }

  void _loadCurrentUser() {
    currentUserId = SharePrefsHelper.getUserId() ?? '';
  }

  // ── Load arguments passed from StatusDetailsController ───────────────────
  void loadChatData() {
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      chatId.value = args['chatId'] ?? '';
      receiverId.value = args['receiverId'] ?? '';
      deliveryStatus.value = args['status'] ?? 'pending';
      driverName.value = args['driverName'] ?? 'Driver';
      driverImage.value = args['driverImage'] ?? AppImages.profileImage;
    }

    loadMessages();
  }

  Future<void> loadMessages() async {
    if (chatId.value.isEmpty) return;

    try {
      isLoading.value = true;
      final response = await _apiClient.get(
        url: ApiUrl.getChatMessage(chatId.value),
        isToken: true,
      );

      if (response.statusCode == 200) {
        final result = GetMessageModel.fromJson(response.body);
        messages.assignAll(result.data);
        // We just opened/refreshed this chat — mark whatever's unread as
        // seen and let the other side know in real time.
        _markMessagesSeen();
      }
    } catch (e) {
      debugPrint("Failed to load messages: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Sends over the socket only — the message is added to the list once
  // the server echoes it back via 'send_message' (it fires to the sender
  // too, per the API), rather than inserted optimistically here. The
  // socket's own contract IS the source of truth for both sides; keeping
  // a separate local-only copy risked showing up twice once the echo
  // path started actually working.
  void sendMessage() {
    if (deliveryStatus.value == 'completed') {
      Get.snackbar(
        'Not Available',
        'You cannot send messages after the order is completed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber[700],
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    final text = messageController.text.trim();
    if (text.isEmpty) return;

    if (!SocketApi.isConnected) {
      Get.snackbar(
        'Not Connected',
        'Reconnecting… please try sending again in a moment.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber[700],
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    messageController.clear();

    SocketApi.emit('send_message', {
      'chatId': chatId.value,
      'receiverId': receiverId.value,
      'message': text,
      'messageType': 'text',
    });
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        await _uploadAndSendMedia(File(image.path));
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> _uploadAndSendMedia(File file) async {
    try {
      isLoading.value = true;
      final response = await _apiClient.multipart(
        url: ApiUrl.uploadMedia,
        fields: {},
        files: [MultipartFileData(key: 'chat_media', path: file.path)],
        isToken: true,
      );

      if (response.statusCode == 200) {
        final data = response.body['data'];
        final fileUrl = data['fileUrl'];
        final messageType = data['messageType'];

        if (!SocketApi.isConnected) {
          Get.snackbar(
            'Not Connected',
            'Uploaded, but not connected to send it — try again in a moment.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.amber[700],
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          return;
        }

        // Added to the list once the server echoes it back — see sendMessage().
        SocketApi.emit('send_message', {
          'chatId': chatId.value,
          'receiverId': receiverId.value,
          'message': '',
          'fileUrl': fileUrl,
          'messageType': messageType,
        });
      }
    } catch (e) {
      debugPrint("Error uploading media: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void scrollToBottom() {
    // When using reverse: true on ListView, we scroll to 0.0 to reach the bottom.
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void addFile() {
    // ✅ BLOCK FILE UPLOAD ONLY IF DELIVERED
    if (deliveryStatus.value == 'delivered') {
      Get.snackbar(
        'Not Available',
        'You cannot share files after delivery',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber[700],
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    // TODO: Implement file picker
    Get.snackbar(
      'Add File',
      'File picker functionality',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    SocketApi.off('send_message');
    SocketApi.off('new_message');
    SocketApi.off('receive_message');
    SocketApi.off('message_seen');
    SocketApi.off('error_response');
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}

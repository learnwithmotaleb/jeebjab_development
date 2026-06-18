import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/helper/local_db/local_db.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/service/socket_service.dart';

import '../model/chat_list_model.dart';

class ChatListController extends GetxController with WidgetsBindingObserver {
  final ApiClient _apiClient = ApiClient();

  final RxList<ChatModel> chatList = <ChatModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  String currentUserId = '';

  // ── Filtered list based on search ─────────────────────────────────────────
  List<ChatModel> get filteredChats {
    if (searchQuery.value.isEmpty) return chatList;
    return chatList.where((c) {
      final other = getOtherParticipant(c);
      final name = other?.name.toLowerCase() ?? '';
      final msg = c.lastMessageDetails?.message.toLowerCase() ?? '';
      return name.contains(searchQuery.value.toLowerCase()) ||
          msg.contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _loadCurrentUser();
    fetchChatList();
    _listenToSocketMessages();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      debugPrint('📋 ChatList: App resumed — refreshing chat list');
      fetchChatList();
    }
  }

  void _loadCurrentUser() {
    currentUserId = SharePrefsHelper.getUserId() ?? '';
  }

  // ── Listen to socket for instant last-message updates ─────────────────────
  void _listenToSocketMessages() {
    SocketApi.on('new_message', (data) {
      debugPrint('📋 ChatList: new_message received');
      _updateChatWithNewMessage(data);
    });

    SocketApi.on('receive_message', (data) {
      debugPrint('📋 ChatList: receive_message received');
      _updateChatWithNewMessage(data);
    });
  }

  void _updateChatWithNewMessage(dynamic data) {
    try {
      final msgData = data as Map<String, dynamic>;
      final chatId = msgData['chatId'] as String?;
      if (chatId == null) return;

      final index = chatList.indexWhere((c) => c.id == chatId);
      if (index != -1) {
        // Update the existing chat item with the new last message
        final updatedChat = chatList[index].copyWith(
          lastMessageDetails: LastMessageModel(
            id: msgData['_id'] ?? '',
            sender: msgData['sender'] is Map
                ? msgData['sender']['_id'] ?? ''
                : msgData['sender'] ?? '',
            receiver: msgData['receiver'] is Map
                ? msgData['receiver']['_id'] ?? ''
                : msgData['receiver'] ?? '',
            chatId: chatId,
            message: msgData['message'] ?? '',
            messageType: msgData['messageType'] ?? 'text',
            fileUrl: msgData['fileUrl'],
            isRead: msgData['isRead'] ?? false,
            createdAt: msgData['createdAt'] ?? DateTime.now().toIso8601String(),
            updatedAt: msgData['updatedAt'] ?? DateTime.now().toIso8601String(),
          ),
          unreadCount: chatList[index].unreadCount + 1,
        );

        // Move the updated chat to the top of the list
        chatList.removeAt(index);
        chatList.insert(0, updatedChat);
      } else {
        // Chat not in list yet, re-fetch the full list
        fetchChatList();
      }
    } catch (e) {
      debugPrint('📋 ChatList: Error updating from socket: $e');
    }
  }

  // ── Get the other participant (not current user) ───────────────────────────
  ParticipantModel? getOtherParticipant(ChatModel chat) {
    try {
      return chat.participantDetails.firstWhere((p) => p.id != currentUserId);
    } catch (_) {
      return chat.participantDetails.isNotEmpty
          ? chat.participantDetails.first
          : null;
    }
  }

  // ── Fetch chat list from API ───────────────────────────────────────────────
  Future<void> fetchChatList() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiClient.get(
        url: ApiUrl.getAllChatList,
        isToken: true,
      );

      if (response.statusCode == 200) {
        final result = ChatListModel.fromJson(
          response.body as Map<String, dynamic>,
        );
        chatList.assignAll(result.data);
      } else {
        errorMessage.value =
            response.body?['message'] ?? 'Failed to load chats';
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // ── Navigate to chat screen ────────────────────────────────────────────────
  void onChatTap(ChatModel chat) {
    markAsRead(chat.id);
    final other = getOtherParticipant(chat);

    // Build avatar URL if available
    String driverImage = '';
    if (other?.avatar != null && other!.avatar!.isNotEmpty) {
      driverImage = ApiUrl.buildImageUrl(other.avatar!);
    }

    Get.toNamed(
      RoutePath.chat,
      arguments: {
        'chatId': chat.id,
        'receiverId': other?.id ?? '',
        'driverName': other?.name ?? 'User',
        'driverImage': driverImage,
        'status': 'active', // chat list is always for active chats
      },
    )?.then((_) {
      // Re-fetch chat list when coming back from chat screen
      fetchChatList();
    });
  }

  void markAsRead(String chatId) {
    final index = chatList.indexWhere((c) => c.id == chatId);
    if (index != -1) {
      chatList[index] = chatList[index].copyWith(unreadCount: 0);
    }
  }

  void onSearch(String value) => searchQuery.value = value;

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    SocketApi.off('new_message');
    SocketApi.off('receive_message');
    super.onClose();
  }
}

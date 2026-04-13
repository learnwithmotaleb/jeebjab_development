import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Observable messages list
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  RxBool isLoading = false.obs;

  // ✅ ADD DELIVERY STATUS OBSERVABLES
  RxString deliveryStatus = 'pending'.obs; //pending,in_transit, delivered
  RxString driverName = 'Driver'.obs;
  RxString driverImage = AppImages.profileImage.obs;

  @override
  void onInit() {
    super.onInit();
    loadChatData();
  }

  // ✅ UPDATED: Combined loadMessages + status loading
  void loadChatData() {
    // Get status from arguments passed from NotificationDetailsScreen
    if (Get.arguments != null) {
      deliveryStatus.value = Get.arguments['status'] ?? 'pending';
      driverName.value = Get.arguments['driverName'] ?? 'Driver';
      driverImage.value = Get.arguments['driverImage'] ?? AppImages.profileImage;
    }

    // Load messages from API or demo data
    loadMessages();
  }

  void loadMessages() {
    // TODO: Load messages from API
    // For now, loading demo messages based on your screenshot
    messages.addAll([
      ChatMessage(
        text: "The Majority Have Suffered Alteration In Some Form By Injected Humour, Or Randomised Words Which Don't Look",
        isSender: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      ChatMessage(
        text: "By Injected Humour, Or Randomised Words Which Don't Look Words Which Don't Look",
        isSender: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
      ),
      ChatMessage(
        text: "The Majority Have Suffered Alteration In Some Form By Injected Humour",
        isSender: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      ChatMessage(
        text: "By Injected Humour, Or Randomised Words Which Don't Look",
        isSender: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
      ),
      ChatMessage(
        text: "The Majority Have Suffered Alteration In Some Form By Injected Humour",
        isSender: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        text: "The Majority Have Suffered Alteration In Some Form By Injected Humour",
        isSender: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
    ]);

    // Auto-scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  void sendMessage() {
    // ✅ BLOCK SENDING ONLY IF DELIVERED
    if (deliveryStatus.value == 'delivered') {
      Get.snackbar(
        'Not Available',
        'You cannot send messages after delivery',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber[700],
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    if (messageController.text.trim().isNotEmpty) {
      messages.add(
        ChatMessage(
          text: messageController.text.trim(),
          isSender: true,
          timestamp: DateTime.now(),
        ),
      );
      messageController.clear();

      scrollToBottom();

      // TODO: Send message to API
      // Simulate driver response
      _simulateDriverResponse();
    }
  }

  // ✅ ADD: Simulate driver response
  void _simulateDriverResponse() {
    Future.delayed(const Duration(seconds: 2), () {
      if (messages.isNotEmpty) {
        messages.add(
          ChatMessage(
            text: "Thank you for your message! I'll get back to you soon.",
            isSender: false,
            timestamp: DateTime.now(),
          ),
        );
        scrollToBottom();
      }
    });
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
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
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}

// Chat Message Model
class ChatMessage {
  final String text;
  final bool isSender;
  final DateTime timestamp;
  final String? imageUrl;

  ChatMessage({
    required this.text,
    required this.isSender,
    required this.timestamp,
    this.imageUrl,
  });
}
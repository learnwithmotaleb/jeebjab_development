import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Observable messages list
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
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
  }

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      messages.add(
        ChatMessage(
          text: messageController.text.trim(),
          isSender: true,
          timestamp: DateTime.now(),
        ),
      );
      messageController.clear();

      // Scroll to bottom
      Future.delayed(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });

      // TODO: Send message to API
    }
  }

  void addFile() {
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
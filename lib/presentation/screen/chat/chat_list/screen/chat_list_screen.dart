import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/chat_list_controller.dart';
import '../model/chat_list_model.dart';
import '../widget/chat_list_widget.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ChatListController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: 'Messages'),
      body: Column(
        children: [
          // ── Search bar ─────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              onChanged: ctrl.onSearch,
              decoration: InputDecoration(
                hintText: 'Search messages...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // ── List ───────────────────────────────────────────────────────────
          Expanded(
            child: Obx(() {
              // Loading
              if (ctrl.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // Error
              if (ctrl.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.wifi_off,
                        size: 48,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        ctrl.errorMessage.value,
                        style: const TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: ctrl.fetchChatList,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Empty
              if (ctrl.filteredChats.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 60,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        ctrl.searchQuery.value.isNotEmpty
                            ? 'No results for "${ctrl.searchQuery.value}"'
                            : 'No conversations yet',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              // Chat list
              return RefreshIndicator(
                onRefresh: ctrl.fetchChatList,
                color: AppColors.primaryColor,
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: ctrl.filteredChats.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    indent: 72,
                    endIndent: 16,
                    color: Colors.grey[200],
                  ),
                  itemBuilder: (_, i) {
                    final ChatModel chat = ctrl.filteredChats[i];
                    final other = ctrl.getOtherParticipant(chat);
                    return ChatListWidget(
                      chat: chat,
                      otherUser: other,
                      onTap: () => ctrl.onChatTap(chat),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
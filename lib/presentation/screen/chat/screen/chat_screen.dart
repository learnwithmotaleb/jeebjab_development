import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/presentation/screen/chat/controller/chat_controller.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';

import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../widget/chat_input_widget.dart';
import '../widget/chat_message_buble_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
    );
  }

  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: 100,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(AppImages.profileImage),
            ),
          ],
        ),
        title: const Text(
          "Abdul Motaleb",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Chat Messages List
          Expanded(
            child: Obx(() => ListView.builder(
              controller: controller.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return ChatMessageBubble(message: message);
              },
            )),
          ),

          // Bottom Input Bar
          const ChatInputBar(),
        ],
      ),
    );
  }
}
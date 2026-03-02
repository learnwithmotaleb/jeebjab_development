import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/presentation/screen/chat/controller/chat_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/widget/app_text_field.dart';

import '../../../../global/language/controller/language_controller.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find<ChatController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Text Input Field
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: controller.messageController,
                  decoration:  InputDecoration(
                    hintText: 'Type Something . . .',
                    fillColor:  Colors.grey[100],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => controller.sendMessage(),
                ),

              ),
            ),

            const SizedBox(width: 8),

            // Add File Button
            GestureDetector(
              onTap: controller.addFile,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.black87,
                  size: 24,
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Send Button
            // Send Button
            GestureDetector(
              onTap: controller.sendMessage,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Transform.flip(
                  flipX: Get.find<LanguageController>().isEnglish ? false : false,
                  child: Icon(
                    Icons.send_rounded,
                    color: AppColors.whiteColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
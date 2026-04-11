import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/chat/controller/chat_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../../../../global/language/controller/language_controller.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find<ChatController>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16), vertical: Dimensions.h(12)),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Text Input Field
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(4)),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(Dimensions.r(30)),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: controller.messageController,
                  style: TextStyle(fontSize: Dimensions.f(15), color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: 'Type Something...',
                    fillColor: Colors.transparent,
                    filled: true,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: Dimensions.f(14),
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w(16), vertical: Dimensions.h(12)),
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => controller.sendMessage(),
                ),
              ),
            ),

            SizedBox(width: Dimensions.w(12)),

            // Add File Button
            GestureDetector(
              onTap: controller.addFile,
              child: Container(
                width: Dimensions.w(48),
                height: Dimensions.w(48),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.black87,
                  size: Dimensions.f(24),
                ),
              ),
            ),

            SizedBox(width: Dimensions.w(12)),

            // Send Button
            GestureDetector(
              onTap: controller.sendMessage,
              child: Container(
                width: Dimensions.w(48),
                height: Dimensions.w(48),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.send_rounded,
                    color: AppColors.whiteColor,
                    size: Dimensions.f(20),
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
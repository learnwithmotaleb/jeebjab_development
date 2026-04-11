import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/chat/controller/chat_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isTablet = Dimensions.screenWidth > 600;
    double maxBubbleWidth = isTablet ? 500 : Dimensions.screenWidth * 0.75;

    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h(16)),
      child: Row(
        mainAxisAlignment: message.isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message.isSender) const Spacer(),

          // Message Container
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: maxBubbleWidth,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(16),
                vertical: Dimensions.h(12),
              ),
              decoration: BoxDecoration(
                color: message.isSender
                    ? AppColors.primaryColor
                    : Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.r(16)),
                  topRight: Radius.circular(Dimensions.r(16)),
                  bottomLeft: Radius.circular(message.isSender ? Dimensions.r(16) : Dimensions.r(4)),
                  bottomRight: Radius.circular(message.isSender ? Dimensions.r(4) : Dimensions.r(16)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: Dimensions.f(15),
                  color: message.isSender ? AppColors.whiteColor : Colors.black87,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          if (!message.isSender) const Spacer(),
        ],
      ),
    );
  }
}
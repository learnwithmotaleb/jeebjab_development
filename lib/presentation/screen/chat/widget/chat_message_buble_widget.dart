import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: message.isSender
                    ? AppColors.primaryColor
                    : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(message.isSender ? 16 : 4),
                  bottomRight: Radius.circular(message.isSender ? 4 : 16),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 14,
                  color: message.isSender ? AppColors.whiteColor : Colors.black87,
                  height: 1.4,
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
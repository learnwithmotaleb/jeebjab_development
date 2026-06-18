import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/helper/local_db/local_db.dart';
import 'package:jeebjab/presentation/screen/chat/controller/chat_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/service/api_url.dart';
import '../model/get_message_model.dart';

class ChatMessageBubble extends StatelessWidget {
  final MessageModel message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    final isSender = message.isMine(controller.currentUserId);
    bool isTablet = Dimensions.screenWidth > 600;
    double maxBubbleWidth = isTablet ? 500 : Dimensions.screenWidth * 0.75;

    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h(16)),
      child: Row(
        mainAxisAlignment: isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isSender) const Spacer(),

          // Message Container
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxBubbleWidth),
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(8),
                vertical: Dimensions.h(8),
              ),
              decoration: BoxDecoration(
                color: isSender ? AppColors.primaryColor : Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.r(16)),
                  topRight: Radius.circular(Dimensions.r(16)),
                  bottomLeft: Radius.circular(
                    isSender ? Dimensions.r(16) : Dimensions.r(4),
                  ),
                  bottomRight: Radius.circular(
                    isSender ? Dimensions.r(4) : Dimensions.r(16),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: isSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (message.isImage && message.fileUrl != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          ApiUrl.buildImageUrl(message.fileUrl!),
                          headers: {
                            'Authorization':
                                'Bearer ${SharePrefsHelper.getToken() ?? ""}',
                          },
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              height: 150,
                              child: Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                      : null,
                                  strokeWidth: 2,
                                  color: isSender
                                      ? Colors.white
                                      : AppColors.primaryColor,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                    )
                  else if (message.fileUrl != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.w(8)),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              message.messageType == 'video'
                                  ? Icons.video_file
                                  : Icons.insert_drive_file,
                              color: isSender
                                  ? Colors.white
                                  : AppColors.primaryColor,
                            ),
                            SizedBox(width: Dimensions.w(8)),
                            Text(
                              "Attachment",
                              style: TextStyle(
                                color: isSender ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (message.message.isNotEmpty)
                    Text(
                      message.message,
                      style: TextStyle(
                        fontSize: Dimensions.f(15),
                        color: isSender ? AppColors.whiteColor : Colors.black87,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  SizedBox(height: Dimensions.h(4)),
                  Text(
                    _formatTime(message.createdAt),
                    style: TextStyle(
                      fontSize: Dimensions.f(11),
                      color: isSender ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (!isSender) const Spacer(),
        ],
      ),
    );
  }

  String _formatTime(String isoString) {
    try {
      final dt = DateTime.parse(isoString).toLocal();
      int hour = dt.hour;
      final minute = dt.minute.toString().padLeft(2, '0');
      final ampm = hour >= 12 ? 'PM' : 'AM';
      hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$hour:$minute $ampm';
    } catch (e) {
      return '';
    }
  }
}

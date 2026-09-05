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
    final hasImage = message.isImage && message.fileUrl != null;

    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h(16)),
      child: Column(
        crossAxisAlignment: isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isSender) const Spacer(),

              // Message Container — just the content (image/attachment/
              // text). Time + read-tick live outside it, below.
              Flexible(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxBubbleWidth),
                  clipBehavior: Clip.antiAlias,
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
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: isSender
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      // ── Image — tap to view full-size. Letterboxed
                      // (BoxFit.contain) instead of cropped, so it shows
                      // up exactly as sent instead of an aggressive crop.
                      if (hasImage)
                        GestureDetector(
                          onTap: () => _openFullImage(
                            context,
                            ApiUrl.buildImageUrl(message.fileUrl!),
                          ),
                          child: Container(
                            width: maxBubbleWidth,
                            height: Dimensions.w(220),
                            color: Colors.black.withValues(alpha: 0.06),
                            child: Image.network(
                              ApiUrl.buildImageUrl(message.fileUrl!),
                              headers: {
                                'Authorization':
                                    'Bearer ${SharePrefsHelper.getToken() ?? ""}',
                              },
                              fit: BoxFit.contain,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value:
                                            loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                            : null,
                                        strokeWidth: 2,
                                        color: isSender
                                            ? Colors.white
                                            : AppColors.primaryColor,
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                          ),
                        ),

                      // ── Everything else gets the actual padding ───────
                      // Only when there's actually something to show —
                      // text, or a non-image attachment — never an empty
                      // padded box for a message with neither.
                      if (message.message.isNotEmpty ||
                          (!hasImage && message.fileUrl != null))
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w(10),
                            vertical: Dimensions.h(8),
                          ),
                          child: Column(
                            crossAxisAlignment: isSender
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!hasImage && message.fileUrl != null)
                                Container(
                                  padding: EdgeInsets.all(Dimensions.w(8)),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.05),
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
                                          color: isSender
                                              ? Colors.white
                                              : Colors.black87,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (message.message.isNotEmpty)
                                Text(
                                  message.message,
                                  style: TextStyle(
                                    fontSize: Dimensions.f(15),
                                    color: isSender
                                        ? AppColors.whiteColor
                                        : Colors.black87,
                                    height: 1.4,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              if (!isSender) const Spacer(),
            ],
          ),

          // ── Time + read-tick — outside the bubble entirely, as a small
          // caption on the same side as the bubble ─────────────────────
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.h(4),
              left: Dimensions.w(4),
              right: Dimensions.w(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(message.createdAt),
                  style: TextStyle(
                    fontSize: Dimensions.f(11),
                    color: Colors.grey[500],
                  ),
                ),
                // Read receipt — only meaningful on our own sent
                // messages: a single tick means sent, a double coloured
                // tick means the other side has read it.
                if (isSender) ...[
                  SizedBox(width: Dimensions.w(4)),
                  Icon(
                    message.isRead
                        ? Icons.done_all_rounded
                        : Icons.done_rounded,
                    size: Dimensions.f(14),
                    color: message.isRead
                        ? AppColors.primaryColor
                        : Colors.grey[500],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openFullImage(BuildContext context, String url) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black,
        pageBuilder: (_, __, ___) => _FullScreenImageView(url: url),
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

// ── Full-screen, pinch-to-zoom image viewer ─────────────────────────────────
class _FullScreenImageView extends StatelessWidget {
  final String url;

  const _FullScreenImageView({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.8,
          maxScale: 5,
          child: Image.network(
            url,
            headers: {
              'Authorization': 'Bearer ${SharePrefsHelper.getToken() ?? ""}',
            },
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, color: Colors.white54, size: 48),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jeebjab/presentation/screen/chat/chat_list/model/chat_list_model.dart';
import 'package:jeebjab/service/api_url.dart';

class ChatListWidget extends StatelessWidget {
  final ChatModel chat;
  final ParticipantModel? otherUser;
  final VoidCallback onTap;

  const ChatListWidget({
    super.key,
    required this.chat,
    required this.otherUser,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final name = otherUser?.name ?? 'Unknown';
    final avatar = otherUser?.avatar;
    final isOnline = otherUser?.isOnline ?? false;
    final lastMsg = _buildLastMessagePreview();
    final time = _formatTime(
      chat.lastMessageDetails?.createdAt ?? chat.updatedAt,
    );
    final unread = chat.unreadCount;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // ── Avatar + online dot
            Stack(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: avatar != null
                      ? NetworkImage(ApiUrl.buildImageUrl(avatar))
                      : null,
                  child: avatar == null
                      ? Text(
                          name.isNotEmpty ? name[0].toUpperCase() : '?',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                if (isOnline)
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // ── Name + last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      // file/image icon prefix
                      if (chat.lastMessageDetails?.messageType == 'image')
                        const Icon(Icons.image, size: 14, color: Colors.grey),
                      if (chat.lastMessageDetails?.messageType == 'file')
                        const Icon(
                          Icons.attach_file,
                          size: 14,
                          color: Colors.grey,
                        ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          lastMsg,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: unread > 0
                                ? Colors.black87
                                : Colors.grey[600],
                            fontSize: 13,
                            fontWeight: unread > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // ── Time + unread badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: unread > 0
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 5),
                unread > 0
                    ? Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          unread > 99 ? '99+' : '$unread',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _buildLastMessagePreview() {
    final msg = chat.lastMessageDetails;
    if (msg == null) return 'No messages yet';
    switch (msg.messageType) {
      case 'image':
        return '📷 Photo';
      case 'file':
        return '📎 File';
      case 'audio':
        return '🎵 Audio';
      default:
        return msg.message;
    }
  }

  String _formatTime(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      final now = DateTime.now();
      final diff = now.difference(dt);

      if (diff.inMinutes < 1) return 'Just now';
      if (diff.inHours < 1) return '${diff.inMinutes}m ago';
      if (diff.inDays < 1) {
        final h = dt.hour.toString().padLeft(2, '0');
        final m = dt.minute.toString().padLeft(2, '0');
        return '$h:$m';
      }
      if (diff.inDays == 1) return 'Yesterday';
      if (diff.inDays < 7) {
        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return days[dt.weekday - 1];
      }
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return '';
    }
  }
}

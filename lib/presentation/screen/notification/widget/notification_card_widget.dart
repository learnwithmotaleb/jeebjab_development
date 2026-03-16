import 'package:flutter/material.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class NotificationCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String message;
  final String timeAgo;
  final VoidCallback? onTap;

  const NotificationCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.message,
    required this.timeAgo,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      color: AppColors.whiteColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 56,
                      height: 56,
                      color: AppColors.greyColor.withOpacity(0.5),
                      child: const Icon(Icons.image, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),

              // Content Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(height: 2),

                    // Subtitle
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Message
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.blackColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Time Ago Section
              Text(
                timeAgo,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


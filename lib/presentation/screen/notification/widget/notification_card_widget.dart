import 'package:flutter/material.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';

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
      elevation: 0.4,
      color: AppColors.whiteColor,
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.w(16),
        vertical: Dimensions.h(8),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.r(16)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimensions.r(16)),
        child: Container(
          padding: EdgeInsets.all(Dimensions.w(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Hero(
                tag: 'notif_image_$imagePath${DateTime.now().millisecond}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.r(12)),
                  child: Image.asset(
                    imagePath,
                    width: Dimensions.w(64),
                    height: Dimensions.w(64),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: Dimensions.w(64),
                        height: Dimensions.w(64),
                        color: AppColors.greyColor.withOpacity(0.1),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.primaryColor.withOpacity(0.5),
                          size: Dimensions.w(32),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w(16)),

              // Content Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: Dimensions.f(17),
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(height: Dimensions.h(4)),

                    // Subtitle
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: Dimensions.f(14),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: Dimensions.h(8)),

                    // Message
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: Dimensions.f(14),
                        color: AppColors.blackColor.withOpacity(0.7),
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: Dimensions.w(12)),

              // Time Ago Section
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    timeAgo,
                    style: TextStyle(
                      fontSize: Dimensions.f(12),
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


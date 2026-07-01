import 'package:flutter/material.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';

class NotificationCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String message;
  final String timeAgo;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.message,
    required this.timeAgo,
    this.isRead = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      color: AppColors.whiteColor,
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.w(16),
        vertical: Dimensions.h(6),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.r(12)),
        side: BorderSide(color: AppColors.greyColor.withOpacity(0.1), width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimensions.r(12)),
        child: Container(
          padding: EdgeInsets.all(Dimensions.w(12)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Hero(
                tag: 'notif_image_$imagePath${DateTime.now().millisecond}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.r(10)),
                  child: imagePath.startsWith('http')
                      ? Image.network(
                          imagePath,
                          width: Dimensions.w(64),
                          height: Dimensions.w(64),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholderIcon(),
                        )
                      : imagePath.isNotEmpty
                      ? Image.asset(
                          imagePath,
                          width: Dimensions.w(64),
                          height: Dimensions.w(64),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholderIcon(),
                        )
                      : _buildPlaceholderIcon(),
                ),
              ),
              SizedBox(width: Dimensions.w(14)),

              // Content Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Time Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: Dimensions.f(16),
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.w(8)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              timeAgo,
                              style: TextStyle(
                                fontSize: Dimensions.f(12),
                                color: AppColors.blackColor.withOpacity(0.6),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (!isRead) ...[
                              SizedBox(height: Dimensions.h(4)),
                              Container(
                                width: Dimensions.w(8),
                                height: Dimensions.w(8),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),

                    // Subtitle (Optional)
                    if (subtitle.isNotEmpty) ...[
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: Dimensions.f(13),
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: Dimensions.h(4)),
                    ],

                    // Message
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: Dimensions.f(13),
                        color: AppColors.blackColor.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
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
  }
}

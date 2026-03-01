import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/custom_appbar.dart';
import '../controller/notification_controller.dart';
import '../widget/notification_card_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),

    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.notification.tr),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Text(
                  AppStrings.recent.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor
                  ),
                ),
              ),

              // Notification Cards
              NotificationCard(
                imagePath: AppImages.homeImage1,
                title: 'Move',
                subtitle: 'Bike',
                message: 'Someone Sent You A Request For Move',
                timeAgo: '1 Hour Ago',
                onTap: () {

                  Get.toNamed(RoutePath.notificationDetails);
                },
              ),

              NotificationCard(
                imagePath: AppImages.homeImage2,
                title: 'Move',
                subtitle: 'Bike',
                message: 'Advertiser Accepted Your Recycling Request',
                timeAgo: '1 Hour Ago',
                onTap: () {

                  Get.toNamed(RoutePath.notificationDetails);
                },
              ),

              NotificationCard(
                imagePath: AppImages.profileImage,
                title: 'Recycling',
                subtitle: 'Electronics',
                message: 'PickedUp Your Waste Items',
                timeAgo: '2 Hours Ago',
                onTap: () {

                  Get.toNamed(RoutePath.notificationDetails);
                },
              ),

              const SizedBox(height: 16),

              // Previous Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                 AppStrings.previous.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                ),
              ),

              NotificationCard(
                imagePath: AppImages.profileImage,
                title: 'Move',
                subtitle: 'Bike',
                message: 'Recycling Completed',
                timeAgo: '2 Days Ago',
                onTap: () {

                  Get.toNamed(RoutePath.notificationDetails);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }


}

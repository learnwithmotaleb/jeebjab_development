import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../../core/responsive_layout/dimensions.dart';
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
      tablet: _buildTablet(),

    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.notification.tr),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.h(10)),
            _buildSectionHeader(AppStrings.recent.tr),
            SizedBox(height: Dimensions.h(5)),

            // Notification Cards
            NotificationCard(
              imagePath: AppImages.homeImage1,
              title: 'Move',
              subtitle: 'Bike',
              message: 'Someone Sent You A Request For Move',
              timeAgo: '1 Hour Ago',
              onTap: () => Get.toNamed(RoutePath.statusDetails),
            ),

            NotificationCard(
              imagePath: AppImages.homeImage2,
              title: 'Move',
              subtitle: 'Bike',
              message: 'Advertiser Accepted Your Recycling Request',
              timeAgo: '1 Hour Ago',
              onTap: () => Get.toNamed(RoutePath.statusDetails),
            ),

            NotificationCard(
              imagePath: AppImages.profileImage,
              title: 'Recycling',
              subtitle: 'Electronics',
              message: 'PickedUp Your Waste Items',
              timeAgo: '2 Hours Ago',
              onTap: () => Get.toNamed(RoutePath.statusDetails),
            ),

            SizedBox(height: Dimensions.h(16)),

            // Previous Section
            _buildSectionHeader(AppStrings.previous.tr),
            SizedBox(height: Dimensions.h(5)),

            NotificationCard(
              imagePath: AppImages.profileImage,
              title: 'Move',
              subtitle: 'Bike',
              message: 'Recycling Completed',
              timeAgo: '2 Days Ago',
              onTap: () => Get.toNamed(RoutePath.statusDetails),
            ),
            
            SizedBox(height: Dimensions.h(20)),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.notification.tr),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w(24), vertical: Dimensions.h(20)),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _buildSectionHeader(AppStrings.recent.tr),
                   SizedBox(height: Dimensions.h(12)),

                  // Notification Cards
                  _buildNotificationList([
                    NotificationCard(
                      imagePath: AppImages.homeImage1,
                      title: 'Move',
                      subtitle: 'Bike',
                      message: 'Someone Sent You A Request For Move',
                      timeAgo: '1 Hour Ago',
                      onTap: () => Get.toNamed(RoutePath.statusDetails),
                    ),
                    NotificationCard(
                      imagePath: AppImages.homeImage2,
                      title: 'Move',
                      subtitle: 'Bike',
                      message: 'Advertiser Accepted Your Recycling Request',
                      timeAgo: '1 Hour Ago',
                      onTap: () => Get.toNamed(RoutePath.statusDetails),
                    ),
                    NotificationCard(
                      imagePath: AppImages.profileImage,
                      title: 'Recycling',
                      subtitle: 'Electronics',
                      message: 'PickedUp Your Waste Items',
                      timeAgo: '2 Hours Ago',
                      onTap: () => Get.toNamed(RoutePath.statusDetails),
                    ),
                  ]),

                  SizedBox(height: Dimensions.h(32)),

                  // Previous Section
                  _buildSectionHeader(AppStrings.previous.tr),
                  SizedBox(height: Dimensions.h(12)),

                  _buildNotificationList([
                    NotificationCard(
                      imagePath: AppImages.profileImage,
                      title: 'Move',
                      subtitle: 'Bike',
                      message: 'Recycling Completed',
                      timeAgo: '2 Days Ago',
                      onTap: () => Get.toNamed(RoutePath.statusDetails),
                    ),
                  ]),
                  
                  SizedBox(height: Dimensions.h(40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
      child: Text(
        title,
        style: TextStyle(
          fontSize: Dimensions.f(18),
          fontWeight: FontWeight.w700,
          color: AppColors.blackColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNotificationList(List<Widget> cards) {
    if (Dimensions.isTablet && Dimensions.screenWidth > 800) {
      // On very wide tablets, we could use a grid, but for notifications, 
      // a clean list within a constrained box is often more readable.
      // However, let's make it slightly more dynamic.
      return Column(
        children: cards,
      );
    }
    return Column(
      children: cards,
    );
  }


}

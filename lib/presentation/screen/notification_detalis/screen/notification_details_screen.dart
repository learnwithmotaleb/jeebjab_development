import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/notification_detalis/controller/notification_details_controller.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../helper/tost_message/show_snackbar.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/custom_alert.dart';

class NotificationDetailsScreen extends StatefulWidget {
  const NotificationDetailsScreen({super.key});

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState
    extends State<NotificationDetailsScreen> {
  final NotificationDetailsController controller =
  Get.put(NotificationDetailsController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  /// Tablet Layout
  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.details.tr),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(() => Column(
              children: [
                SizedBox(height: Dimensions.h(24)),
                
                // Item Information Card
                _buildItemCard(),

                SizedBox(height: Dimensions.h(20)),

                // Status and Action Buttons in a Row if possible or balanced vertical
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
                  child: Row(
                    children: [
                      Expanded(child: _buildStatusButton(margin: EdgeInsets.zero)),
                    ],
                  ),
                ),

                SizedBox(height: Dimensions.h(32)),

                // Content Row: Stepper and Additional Info
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stepper Section
                        Expanded(
                          flex: 3,
                          child: _buildStepperSection(margin: EdgeInsets.zero),
                        ),
                        
                        SizedBox(width: Dimensions.w(32)),

                        // Action Column
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (controller.status.value == "in_transit")
                                _buildLiveTrackingButton(margin: EdgeInsets.zero)
                              else if (controller.status.value == "delivered")
                                _buildRateServiceButton(margin: EdgeInsets.zero),
                              
                              if (controller.status.value == "pending") ...[
                                _buildActionButtons(margin: EdgeInsets.zero),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // Driver Card
                _buildDriverCard(),

                SizedBox(height: Dimensions.h(40)),
              ],
            )),
          ),
        ),
      ),
    );
  }

  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.details.tr),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(() => Column(
          children: [
            SizedBox(height: Dimensions.h(16)),
            // Item Information Card
            _buildItemCard(),

            SizedBox(height: Dimensions.h(16)),

            // Status Button
            _buildStatusButton(),

            SizedBox(height: Dimensions.h(24)),

            // Stepper Section
            _buildStepperSection(),

            SizedBox(height: Dimensions.h(24)),

            // Action Buttons (Live Tracking / Rate Service)
            if (controller.status.value == "in_transit")
              _buildLiveTrackingButton()
            else if (controller.status.value == "delivered")
              _buildRateServiceButton(),

            if (controller.status.value == "pending")
              _buildActionButtons(),

            SizedBox(height: Dimensions.h(24)),

            // Driver Card
            _buildDriverCard(),

            SizedBox(height: Dimensions.h(32)),
          ],
        )),
      ),
    );
  }

  // ── Item Information Card ─────────────────────────────────────────────────
  Widget _buildItemCard() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          RoutePath.pickUpDetails,
          arguments: {
            'itemType': controller.itemType.value,
            'itemSubtype': controller.itemSubtype.value,
            'itemDate': controller.itemDate.value,
            'price': 156,
            'status': controller.status.value,
            'pickupAddress': 'Abu Dhabi - 23052, Level 2, Door 6',
            'deliveryAddress': 'Abu Dhabi - 23052',
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
        padding: EdgeInsets.all(Dimensions.w(16)),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(Dimensions.r(16)),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            // Item Image
            Hero(
              tag: 'notif_image_${controller.imagePath.value}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.r(12)),
                child: Image.asset(
                  controller.imagePath.value,
                  width: Dimensions.w(90),
                  height: Dimensions.w(90),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: Dimensions.w(90),
                      height: Dimensions.w(90),
                      color: Colors.grey[200],
                      child: Icon(Icons.inventory_2_outlined, color: Colors.grey, size: Dimensions.w(40)),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: Dimensions.w(16)),

            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.itemType.value,
                    style: TextStyle(
                      fontSize: Dimensions.f(20),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: Dimensions.h(4)),
                  Text(
                    controller.itemSubtype.value,
                    style: TextStyle(fontSize: Dimensions.f(14), color: AppColors.blackColor.withOpacity(0.7)),
                  ),
                  SizedBox(height: Dimensions.h(8)),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: Dimensions.f(14), color: AppColors.primaryColor),
                      SizedBox(width: Dimensions.w(6)),
                      Text(
                        controller.itemDate.value,
                        style: TextStyle(fontSize: Dimensions.f(13), color: AppColors.blackColor),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h(8)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w(8), vertical: Dimensions.h(4)),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Dimensions.r(4)),
                    ),
                    child: Text(
                      "${AppStrings.trackingNumber.tr}: ${controller.trackingNumber.value}",
                      style: TextStyle(
                        fontSize: Dimensions.f(11),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Status Button ─────────────────────────────────────────────────────────
  Widget _buildStatusButton({EdgeInsetsGeometry? margin}) {
    String statusText = '';
    Color statusColor = Colors.grey;

    switch (controller.status.value) {
      case 'pending':
        statusText = AppStrings.pending.tr;
        statusColor = Colors.amber;
        break;
      case 'in_transit':
        statusText = AppStrings.estimatedDeliveryTime.tr;
        statusColor = Colors.blue;
        break;
      case 'delivered':
        statusText = AppStrings.delivered.tr;
        statusColor = Colors.green;
        break;
    }

    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
      padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        border: Border.all(color: statusColor.withOpacity(0.5), width: 1.5),
        borderRadius: BorderRadius.circular(Dimensions.r(12)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline_rounded, size: Dimensions.f(18), color: statusColor),
            SizedBox(width: Dimensions.w(8)),
            Text(
              statusText,
              style: TextStyle(
                fontSize: Dimensions.f(15),
                fontWeight: FontWeight.w700,
                color: statusColor.withOpacity(0.9),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Stepper Section ───────────────────────────────────────────────────────
  Widget _buildStepperSection({EdgeInsetsGeometry? margin}) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
      child: Column(
        children: [
          _buildStepItem(
            icon: Icons.assignment_turned_in_outlined,
            title: AppStrings.requestConfirmation.tr,
            subtitle: AppStrings.wePickUpYourProductSoon.tr,
            isCompleted: true,
            isLast: false,
          ),
          _buildStepItem(
            icon: Icons.local_shipping_outlined,
            title: AppStrings.pickup.tr,
            subtitle: AppStrings.parcelHasBeenPickedUp.tr,
            isCompleted: controller.status.value == 'in_transit' ||
                controller.status.value == 'delivered',
            isLast: false,
          ),
          _buildStepItem(
            icon: Icons.trending_up,
            title: AppStrings.inTransit.tr,
            subtitle: AppStrings.onTheWaySoonDelivered.tr,
            isCompleted: controller.status.value == 'in_transit' ||
                controller.status.value == 'delivered',
            isLast: false,
          ),
          _buildStepItem(
            icon: Icons.task_alt_rounded,
            title: AppStrings.delivered.tr,
            subtitle: AppStrings.parcelHasBeenShipped.tr,
            isCompleted: controller.status.value == 'delivered',
            isLast: true,
          ),
        ],
      ),
    );
  }

  // ── Individual Step Item ──────────────────────────────────────────────────
  Widget _buildStepItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon and Line
        Column(
          children: [
            Container(
              width: Dimensions.w(30),
              height: Dimensions.w(30),
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primaryColor : Colors.grey[200],
                shape: BoxShape.circle,
                boxShadow: isCompleted ? [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ] : [],
              ),
              child: Icon(icon, size: Dimensions.f(16), color: isCompleted ? Colors.white : Colors.grey[500]),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: Dimensions.h(50),
                color: isCompleted ? AppColors.primaryColor : Colors.grey[200],
              ),
          ],
        ),
        SizedBox(width: Dimensions.w(16)),

        // Text Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: Dimensions.h(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Dimensions.f(16),
                    fontWeight: FontWeight.w700,
                    color: isCompleted ? Colors.black : Colors.grey[500],
                  ),
                ),
                SizedBox(height: Dimensions.h(4)),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: Dimensions.f(13),
                    color: isCompleted ? Colors.grey[700] : Colors.grey[400],
                    height: 1.3,
                  ),
                ),
                if (!isLast) SizedBox(height: Dimensions.h(20)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Live Tracking Button ──────────────────────────────────────────────────
  Widget _buildLiveTrackingButton({EdgeInsetsGeometry? margin}) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.onLiveTrackingPressed,
        icon: Icon(Icons.location_on_rounded, size: Dimensions.f(20), color: Colors.white),
        label: Text(
          AppStrings.liveTracking.tr,
          style: TextStyle(
            fontSize: Dimensions.f(16),
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: Dimensions.h(16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r(12)),
          ),
          elevation: 4,
          shadowColor: AppColors.primaryColor.withOpacity(0.4),
        ),
      ),
    );
  }

  // ── Rate Service Button ───────────────────────────────────────────────────
  Widget _buildRateServiceButton({EdgeInsetsGeometry? margin}) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.onRateServicePressed,
        icon: Icon(Icons.star_outline_rounded, size: Dimensions.f(20), color: Colors.white),
        label: Text(
          AppStrings.rateYourService.tr,
          style: TextStyle(
            fontSize: Dimensions.f(16),
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber[700],
          padding: EdgeInsets.symmetric(vertical: Dimensions.h(16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r(12)),
          ),
          elevation: 4,
          shadowColor: Colors.amber.withOpacity(0.4),
        ),
      ),
    );
  }

  // ── Action Buttons (Delete & Reschedule) ──────────────────────────────────
  Widget _buildActionButtons({EdgeInsetsGeometry? margin}) {
    return Padding(
      padding: margin ?? EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                CustomAlertDialog.show(
                  context: context,
                  title: AppStrings.doYouWantToDelete.tr,
                  body: AppStrings.areYouSureToDelete.tr,
                  onYes: () {
                    AppSnackBar.success(AppStrings.deleteSuccessfully.tr);
                    Get.back();
                  },
                  onNo: () => Get.back(),
                );
              },
              icon: Icon(Icons.delete_outline_rounded, size: Dimensions.f(20), color: Colors.redAccent),
              label: Text(
                AppStrings.delete.tr,
                style: TextStyle(
                  fontSize: Dimensions.f(15),
                  fontWeight: FontWeight.w700,
                  color: Colors.redAccent,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
                side: BorderSide(color: Colors.redAccent.withOpacity(0.3), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.r(12)),
                ),
                backgroundColor: Colors.redAccent.withOpacity(0.05),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h(12)),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: controller.onReschedulePressed,
              icon: Icon(Icons.calendar_month_outlined, size: Dimensions.f(20), color: Colors.black87),
              label: Text(
                AppStrings.reschedule.tr,
                style: TextStyle(
                  fontSize: Dimensions.f(15),
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
                side: BorderSide(color: Colors.grey[400]!, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.r(12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Driver Card ───────────────────────────────────────────────────────────
  Widget _buildDriverCard() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutePath.reviewProfile);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
        padding: EdgeInsets.all(Dimensions.w(20)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.r(20)),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Driver Info Row
            Row(
              children: [
                // Driver Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.r(14)),
                  child: Image.asset(
                    controller.driverImage.value,
                    width: Dimensions.w(64),
                    height: Dimensions.w(64),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: Dimensions.w(64),
                        height: Dimensions.w(64),
                        color: Colors.grey[100],
                        child: Icon(Icons.person_outline_rounded, color: Colors.grey, size: Dimensions.w(30)),
                      );
                    },
                  ),
                ),
                SizedBox(width: Dimensions.w(16)),

                // Driver Name and Phone
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.driverName.value,
                        style: TextStyle(
                          fontSize: Dimensions.f(18),
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: Dimensions.h(4)),
                      Row(
                        children: [
                          Icon(Icons.phone_outlined, size: Dimensions.f(14), color: Colors.grey),
                          SizedBox(width: Dimensions.w(6)),
                          Text(
                            controller.driverPhone.value,
                            style: TextStyle(fontSize: Dimensions.f(13), color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Rating
                Container(
                  padding: EdgeInsets.all(Dimensions.w(10)),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(Dimensions.r(12)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        controller.driverRating.value.toString(),
                        style: TextStyle(
                          fontSize: Dimensions.f(22),
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star_rounded, size: Dimensions.f(14), color: Colors.amber[600]),
                          SizedBox(width: Dimensions.w(2)),
                          Text(
                            AppStrings.rating.tr,
                            style: TextStyle(
                              fontSize: Dimensions.f(11),
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: Dimensions.h(24)),

            // Action Buttons
            Row(
              children: [
                if(controller.status == 'delivered')
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: controller.onMessagePressed,
                      icon: Icon(Icons.chat_bubble_outline_rounded, size: Dimensions.f(18), color: Colors.white),
                      label: Text(
                        AppStrings.message.tr,
                        style: TextStyle(
                          fontSize: Dimensions.f(15),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimensions.r(12)),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),

                if (controller.status.value != 'delivered')
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: controller.onMessagePressed,
                      icon: Icon(Icons.chat_bubble_outline_rounded, size: Dimensions.f(18), color: Colors.white),
                      label: Text(
                        AppStrings.message.tr,
                        style: TextStyle(
                          fontSize: Dimensions.f(15),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimensions.r(12)),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),

                if (controller.showAcceptButton.value && controller.status.value != 'delivered') ...[
                  SizedBox(width: Dimensions.w(12)),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.onAcceptPressed(context);
                        controller.showAcceptButton.value = false;
                        controller.status.value = "in_transit";
                      },
                      icon: Icon(Icons.check_circle_outline_rounded, size: Dimensions.f(18), color: Colors.white),
                      label: Text(
                        AppStrings.accept.tr,
                        style: TextStyle(
                          fontSize: Dimensions.f(15),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimensions.r(12)),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
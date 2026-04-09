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
    return ResponsiveLayout(mobile: _buildMobile());
  }

  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.details.tr),
      body: SingleChildScrollView(
        child: Obx(() => Column(
          children: [
            // Item Information Card
            _buildItemCard(),

            const SizedBox(height: 16),

            // Status Button
            _buildStatusButton(),

            const SizedBox(height: 20),

            // Stepper Section
            _buildStepperSection(),

            const SizedBox(height: 20),

            // Action Buttons (Live Tracking / Rate Service)
            if (controller.status.value == "in_transit")
              _buildLiveTrackingButton()
            else if (controller.status.value == "delivered")
              _buildRateServiceButton(),

            const SizedBox(height: 16),

            // Delete and Reschedule Buttons (only for pending)
            if (controller.status.value == "pending")
              _buildActionButtons(),

            const SizedBox(height: 16),

            // Driver Card
            _buildDriverCard(),

            const SizedBox(height: 24),
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
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Item Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                controller.imagePath.value,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),

            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.itemType.value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.itemSubtype.value,
                    style: TextStyle(fontSize: 13, color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.itemDate.value,
                    style: TextStyle(fontSize: 12, color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.trackingNumber.tr,
                    style: TextStyle(fontSize: 11, color: AppColors.blackColor),
                  ),
                  Text(
                    controller.trackingNumber.value,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
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
  Widget _buildStatusButton() {
    String statusText = '';
    Color statusColor = Colors.grey;

    switch (controller.status.value) {
      case 'pending':
        statusText = AppStrings.pending.tr;
        statusColor = Colors.grey[300]!;
        break;
      case 'in_transit':
        statusText = AppStrings.estimatedDeliveryTime.tr;
        statusColor = Colors.grey[300]!;
        break;
      case 'delivered':
        statusText = AppStrings.delivered.tr;
        statusColor = Colors.grey[300]!;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        border: Border.all(color: statusColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          statusText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: controller.status.value == 'pending'
                ? AppColors.blackColor
                : Colors.black87,
          ),
        ),
      ),
    );
  }

  // ── Stepper Section ───────────────────────────────────────────────────────
  Widget _buildStepperSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildStepItem(
            icon: Icons.check_circle,
            title: AppStrings.requestConfirmation.tr,
            subtitle: AppStrings.wePickUpYourProductSoon.tr,
            isCompleted: true,
            isLast: false,
          ),
          _buildStepItem(
            icon: Icons.check_circle,
            title: AppStrings.pickup.tr,
            subtitle: AppStrings.parcelHasBeenPickedUp.tr,
            isCompleted: controller.status.value == 'in_transit' ||
                controller.status.value == 'delivered',
            isLast: false,
          ),
          _buildStepItem(
            icon: Icons.local_shipping,
            title: AppStrings.inTransit.tr,
            subtitle: AppStrings.onTheWaySoonDelivered.tr,
            isCompleted: controller.status.value == 'in_transit' ||
                controller.status.value == 'delivered',
            isLast: false,
          ),
          _buildStepItem(
            icon: Icons.done_all,
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
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color:
                isCompleted ? AppColors.primaryColor : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: Colors.white),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: isCompleted
                    ? AppColors.primaryColor
                    : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 12),

        // Text Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isCompleted ? Colors.black : Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                if (!isLast) const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Live Tracking Button ──────────────────────────────────────────────────
  Widget _buildLiveTrackingButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.onLiveTrackingPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Text(
          AppStrings.liveTracking.tr,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ── Rate Service Button ───────────────────────────────────────────────────
  Widget _buildRateServiceButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.onRateServicePressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Text(
          AppStrings.rateYourService.tr,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ── Action Buttons (Delete & Reschedule) ──────────────────────────────────
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
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
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: AppColors.greyColor, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                AppStrings.delete.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: controller.onReschedulePressed,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: Colors.grey[400]!, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                AppStrings.reschedule.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
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
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          children: [
            // Driver Info Row
            Row(
              children: [
                // Driver Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    controller.driverImage.value,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey[300],
                        child:
                        const Icon(Icons.person, color: Colors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // Driver Name and Phone
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.driverName.value,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        controller.driverPhone.value,
                        style:
                        TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                // Rating
                Column(
                  children: [
                    Text(
                      controller.driverRating.value.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.amber[600]),
                        const SizedBox(width: 2),
                        Text(
                          AppStrings.rating.tr,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: Dimensions.h(40)),

            // Action Buttons
            // Action Buttons
            Row(
              children: [
                // Show Message button only if status is not delivered
                if (controller.status.value != 'delivered')
                  Expanded(
                    child: OutlinedButton(
                      onPressed: controller.onMessagePressed,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: AppColors.primaryColor, width: 1.5),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        AppStrings.message.tr,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),

                // Show Accept button only if status is pending (or whatever condition you want)
                if (controller.showAcceptButton.value && controller.status.value != 'delivered') ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.onAcceptPressed(context);
                        controller.showAcceptButton.value = false; // hide after accepting
                        controller.status.value = "in_transit";
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        AppStrings.accept.tr,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),

            SizedBox(height: Dimensions.h(10)),
          ],
        ),
      ),
    );
  }
}
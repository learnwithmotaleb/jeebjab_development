import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../helper/tost_message/show_snackbar.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/custom_alert.dart';
import '../controller/status_details_controller.dart';
import '../widget/status_details_card.dart';

class StatusDetailsScreen extends StatefulWidget {
  const StatusDetailsScreen({super.key});

  @override
  State<StatusDetailsScreen> createState() => _StatusDetailsScreenState();
}

class _StatusDetailsScreenState extends State<StatusDetailsScreen> {
  final StatusDetailsController controller = Get.put(StatusDetailsController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile(), tablet: _buildTablet());
  }

  /// Tablet Layout
  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.details.tr),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.errorMessage.value.isNotEmpty) {
              return Center(child: Text(controller.errorMessage.value));
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: Dimensions.h(24)),

                  // Item Information Card
                  _buildItemCard(),

                  SizedBox(height: Dimensions.h(20)),

                  // Status and Action Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildStatusButton(margin: EdgeInsets.zero),
                        ),
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
                            child: _buildStepperSection(
                              margin: EdgeInsets.zero,
                            ),
                          ),

                          SizedBox(width: Dimensions.w(32)),

                          // Action Column
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (controller.status.value == "active")
                                  _buildLiveTrackingButton(
                                    margin: EdgeInsets.zero,
                                  )
                                else if (controller.status.value == "completed")
                                  _buildRateServiceButton(
                                    margin: EdgeInsets.zero,
                                  ),

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
                  if (controller.driverName.value.isNotEmpty ||
                      controller.showAcceptButton.value)
                    _buildDriverCard(),

                  SizedBox(height: Dimensions.h(40)),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.details.tr),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
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
              if (controller.status.value == "active")
                _buildLiveTrackingButton()
              else if (controller.status.value == "completed")
                _buildRateServiceButton(),

              if (controller.status.value == "pending") _buildActionButtons(),

              SizedBox(height: Dimensions.h(24)),

              // Driver Card
              if (controller.driverName.value.isNotEmpty ||
                  controller.showAcceptButton.value)
                _buildDriverCard(),

              SizedBox(height: Dimensions.h(32)),
            ],
          ),
        );
      }),
    );
  }

  // ── Item Information Card ─────────────────────────────────────────────────
  Widget _buildItemCard() {
    return GestureDetector(
      onTap: () {
        if (controller.postId.value.isNotEmpty) {
          Get.toNamed(
            RoutePath.postDetails,
            arguments: {'id': controller.postId.value},
          );
        }
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
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.r(12)),
              child: controller.imagePath.value.isNotEmpty
                  ? Image.network(
                      controller.imagePath.value,
                      width: Dimensions.w(90),
                      height: Dimensions.w(90),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildFallbackImage(),
                    )
                  : _buildFallbackImage(),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Dimensions.h(4)),
                  Text(
                    controller.itemSubtype.value,
                    style: TextStyle(
                      fontSize: Dimensions.f(14),
                      color: AppColors.blackColor.withOpacity(0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Dimensions.h(8)),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: Dimensions.f(14),
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: Dimensions.w(6)),
                      Text(
                        controller.itemDate.value,
                        style: TextStyle(
                          fontSize: Dimensions.f(13),
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h(8)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w(8),
                      vertical: Dimensions.h(4),
                    ),
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

  Widget _buildFallbackImage() {
    return Container(
      width: Dimensions.w(90),
      height: Dimensions.w(90),
      color: Colors.grey[200],
      child: Icon(
        Icons.inventory_2_outlined,
        color: Colors.grey,
        size: Dimensions.w(40),
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
      case 'active':
        statusText =
            "Estimated Delivery Time 2 Hour"; // Hardcoded as per UI screenshot
        statusColor = const Color(0xFF00CBA9);
        break;
      case 'completed':
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
            Icon(
              Icons.info_outline_rounded,
              size: Dimensions.f(18),
              color: statusColor,
            ),
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
            isCompleted:
                controller.status.value == 'active' ||
                controller.status.value == 'completed',
            isLast: false,
          ),
          _buildStepItem(
            icon: Icons.trending_up,
            title: AppStrings.inTransit.tr,
            subtitle: AppStrings.onTheWaySoonDelivered.tr,
            isCompleted:
                controller.status.value == 'active' ||
                controller.status.value == 'completed',
            isLast: false,
          ),
          _buildStepItem(
            icon: Icons.task_alt_rounded,
            title: AppStrings.delivered.tr,
            subtitle: AppStrings.parcelHasBeenShipped.tr,
            isCompleted: controller.status.value == 'completed',
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
        Column(
          children: [
            Container(
              width: Dimensions.w(24),
              height: Dimensions.w(24),
              decoration: BoxDecoration(
                color: isCompleted ? const Color(0xFF00CBA9) : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: Dimensions.f(12),
                color: isCompleted ? Colors.white : Colors.grey[500],
              ),
            ),
            if (!isLast)
              Container(
                width: 1.5,
                height: Dimensions.h(40),
                color: isCompleted ? const Color(0xFF00CBA9) : Colors.grey[200],
              ),
          ],
        ),
        SizedBox(width: Dimensions.w(16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: Dimensions.f(14),
                  fontWeight: FontWeight.w700,
                  color: isCompleted ? Colors.black : Colors.grey[500],
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: Dimensions.f(12),
                  color: isCompleted ? Colors.grey[600] : Colors.grey[400],
                ),
              ),
              if (!isLast) SizedBox(height: Dimensions.h(10)),
            ],
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
      child: ElevatedButton(
        onPressed: controller.onLiveTrackingPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00CBA9),
          padding: EdgeInsets.symmetric(vertical: Dimensions.h(16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r(12)),
          ),
        ),
        child: Text(
          AppStrings.liveTracking.tr,
          style: TextStyle(
            fontSize: Dimensions.f(16),
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ── Rate Service Button ───────────────────────────────────────────────────
  Widget _buildRateServiceButton({EdgeInsetsGeometry? margin}) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.onRateServicePressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber[700],
          padding: EdgeInsets.symmetric(vertical: Dimensions.h(16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r(12)),
          ),
        ),
        child: Text(
          AppStrings.rateYourService.tr,
          style: TextStyle(
            fontSize: Dimensions.f(16),
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ── Action Buttons (Delete & Reschedule) ──────────────────────────────────
  Widget _buildActionButtons({EdgeInsetsGeometry? margin}) {
    return Padding(
      padding: margin ?? EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: controller.onDeletePressed,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
                side: const BorderSide(color: Colors.redAccent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.r(12)),
                ),
              ),
              child: Text(
                AppStrings.delete.tr,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: Dimensions.w(12)),
          Expanded(
            child: OutlinedButton(
              onPressed: controller.onReschedulePressed,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.r(12)),
                ),
              ),
              child: Text(
                AppStrings.reschedule.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.status.value == 'pending') ...[
            Text(
              "Driver Offers",
              style: TextStyle(
                fontSize: Dimensions.f(18),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A2E),
              ),
            ),
            SizedBox(height: Dimensions.h(12)),
            if (controller.jobRequests.isEmpty)
              const Center(child: Text("No offers yet"))
            else
              ...controller.jobRequests.map((request) {
                final driver = request.driver;
                if (driver == null) return const SizedBox();
                return Column(
                  children: [
                    StatusDetailsCard(
                      name: driver.name ?? "Unknown",
                      phone: driver.phoneNumber?.toString() ?? "N/A",
                      imageUrl: driver.avatar != null
                          ? ApiUrl.buildImageUrl(driver.avatar.toString())
                          : "",
                      rating: (driver.rating ?? 0.0).toDouble(),
                      showAcceptButton: request.status == 'pending',
                      onMessage: () => controller.onMessagePressed(
                        receiverId: driver.id ?? '',
                      ),
                      onAccept: () => controller.onAcceptPressed(
                        context,
                        request.requestId ?? "",
                      ),
                    ),
                    SizedBox(height: Dimensions.h(12)),
                  ],
                );
              }),
          ],

          if (controller.status.value != 'pending' &&
              controller.driverName.value.isNotEmpty)
            StatusDetailsCard(
              name: controller.driverName.value,
              phone: controller.driverPhone.value,
              imageUrl: controller.driverImage.value,
              rating: controller.driverRating.value,
              showAcceptButton: controller.showAcceptButton.value,
              isMessageEnabled: controller.status.value != 'completed',
              onMessage: () => controller.onMessagePressed(),
              onAccept: () {},
            ),
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      width: Dimensions.w(50),
      height: Dimensions.w(50),
      color: Colors.grey[200],
      child: const Icon(Icons.person, color: Colors.grey),
    );
  }
}

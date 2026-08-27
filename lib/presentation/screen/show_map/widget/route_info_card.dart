import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../controller/route_map_controller.dart';

class RouteInfoCard extends StatelessWidget {
  final RouteMapController controller;

  const RouteInfoCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimensions.w(16)),
      padding: EdgeInsets.all(Dimensions.w(16)),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.r(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(() {
        final hasDropoff = controller.hasDropoff;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AddressRow(
              dotColor: const Color(0xFF34A853),
              label: 'Pick-Up',
              address: controller.pickupAddress.value,
            ),
            if (hasDropoff) ...[
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w(5)),
                child: Container(
                  width: 2,
                  height: Dimensions.h(16),
                  color: Colors.grey.shade300,
                ),
              ),
              _AddressRow(
                dotColor: const Color(0xFFEA4335),
                label: 'Drop-Off',
                address: controller.dropoffAddress.value,
              ),
              SizedBox(height: Dimensions.h(12)),
              const Divider(height: 1),
              SizedBox(height: Dimensions.h(12)),
              _DistanceDurationRow(
                distanceText: controller.distanceText.value,
                durationText: controller.durationText.value,
                isApproximate: controller.isApproximate.value,
              ),
            ],
            if (controller.myLocation.value != null) ...[
              SizedBox(height: Dimensions.h(12)),
              const Divider(height: 1),
              SizedBox(height: Dimensions.h(12)),
              Row(
                children: [
                  Icon(Icons.my_location_rounded,
                      size: Dimensions.w(16), color: Colors.blueAccent),
                  SizedBox(width: Dimensions.w(6)),
                  Text(
                    'From your location',
                    style: TextStyle(
                      fontSize: Dimensions.f(11),
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h(6)),
              controller.isLoadingMyLocation.value
                  ? SizedBox(
                      height: Dimensions.h(16),
                      width: Dimensions.h(16),
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : _DistanceDurationRow(
                      distanceText: controller.myLocationDistanceText.value,
                      durationText: controller.myLocationDurationText.value,
                      isApproximate: controller.myLocationIsApproximate.value,
                    ),
            ],
          ],
        );
      }),
    );
  }
}

class _DistanceDurationRow extends StatelessWidget {
  final String distanceText;
  final String durationText;
  final bool isApproximate;

  const _DistanceDurationRow({
    required this.distanceText,
    required this.durationText,
    required this.isApproximate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.route_outlined,
            size: Dimensions.w(18), color: AppColors.primaryColor),
        SizedBox(width: Dimensions.w(6)),
        Text(
          distanceText.isEmpty ? '—' : distanceText,
          style: TextStyle(
            fontSize: Dimensions.f(14),
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(width: Dimensions.w(20)),
        Icon(Icons.schedule_rounded,
            size: Dimensions.w(18), color: AppColors.primaryColor),
        SizedBox(width: Dimensions.w(6)),
        Text(
          durationText.isEmpty ? '—' : durationText,
          style: TextStyle(
            fontSize: Dimensions.f(14),
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        if (isApproximate) ...[
          SizedBox(width: Dimensions.w(8)),
          Text(
            '(approx.)',
            style: TextStyle(
              fontSize: Dimensions.f(11),
              color: AppColors.greyColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }
}

class _AddressRow extends StatelessWidget {
  final Color dotColor;
  final String label;
  final String address;

  const _AddressRow({
    required this.dotColor,
    required this.label,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: Dimensions.h(4)),
          child: Container(
            width: Dimensions.w(10),
            height: Dimensions.w(10),
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
        ),
        SizedBox(width: Dimensions.w(10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: Dimensions.f(11),
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                address.isEmpty ? '—' : address,
                style: TextStyle(
                  fontSize: Dimensions.f(13),
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

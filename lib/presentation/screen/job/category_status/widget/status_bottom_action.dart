import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../controller/category_status_controller.dart';

class StatusBottomActions extends StatelessWidget {
  const StatusBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryStatusController>();

    return Container(
      padding: EdgeInsets.fromLTRB(
        Dimensions.w(16),
        Dimensions.h(10),
        Dimensions.w(16),
        Dimensions.h(24),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: Obx(() {
        // ── Loading state ──────────────────────────────────────────────────
        if (controller.isLoading.value) {
          return SizedBox(
            height: Dimensions.h(52),
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          );
        }

        // ── API-driven toggle ──────────────────────────────────────────────
        // hasActiveRequest == true  → driver already sent request → show Cancel
        // hasActiveRequest == false → no active request           → show Send
        if (controller.hasActiveRequest.value) {
          return _CancelButton(onTap: controller.onCancelRequest);
        } else {
          return _TealButton(
            label: AppStrings.sendRequest.tr,
            onTap: controller.onSendRequest,
          );
        }
      }),
    );
  }
}

// ── Full teal button ──────────────────────────────────────────────────────────
class _TealButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _TealButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: Dimensions.h(16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r(30)),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.f(15),
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ── Red cancel text button ────────────────────────────────────────────────────
class _CancelButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CancelButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r(30)),
            side: BorderSide(color: AppColors.redColor.withValues(alpha: 0.3)),
          ),
        ),
        child: Text(
          AppStrings.cancelRequest.tr,
          style: TextStyle(
            fontSize: Dimensions.f(15),
            fontWeight: FontWeight.w700,
            color: AppColors.redColor,
          ),
        ),
      ),
    );
  }
}
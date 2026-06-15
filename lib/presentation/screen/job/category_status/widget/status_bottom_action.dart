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
        // Loading → spinner দেখাও, button disable
        if (controller.isLoading.value) {
          return SizedBox(
            height: Dimensions.h(52),
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          );
        }

        // hasActiveRequest true  → Cancel Request (outlined red)
        // hasActiveRequest false → Send Request (filled teal)
        return controller.hasActiveRequest.value
            ? _CancelButton(onTap: controller.onCancelRequest)
            : _SendButton(onTap: controller.onSendRequest);
      }),
    );
  }
}

// ── Send Request — filled teal ────────────────────────────────────────────────
class _SendButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SendButton({required this.onTap});

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
          AppStrings.sendRequest.tr,
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

// ── Cancel Request — outlined red ─────────────────────────────────────────────
class _CancelButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CancelButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: Dimensions.h(16)),
          side: BorderSide(color: AppColors.redColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r(30)),
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
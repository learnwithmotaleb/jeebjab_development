import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../controller/category_status_controller.dart';

class StatusBottomActions extends StatelessWidget {
  final PostCategory category;
  final RequestStatus status;
  final VoidCallback onSendRequest;
  final VoidCallback onCancelRequest;
  final VoidCallback? onAcceptPending;
  final VoidCallback onPickedUp;
  final VoidCallback onDelivery;
  final VoidCallback onOpenMap;

  const StatusBottomActions({
    super.key,
    required this.category,
    required this.status,
    required this.onSendRequest,
    required this.onCancelRequest,
    required this.onPickedUp,
    required this.onDelivery,
    required this.onOpenMap,
    this.onAcceptPending,
  });

  @override
  Widget build(BuildContext context) {
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
      child: _buildButtons(),
    );
  }

  Widget _buildButtons() {
    if (status == RequestStatus.sent || status == RequestStatus.pending) {
      // Cancel request – red text button
      return _CancelButton(onTap: onCancelRequest);
    } else {
      // Send request – teal filled button
      return _TealButton(label: AppStrings.sendRequest.tr, onTap: onSendRequest);
    }
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

// ── Two buttons side by side ──────────────────────────────────────────────────
class _TwoButtons extends StatelessWidget {
  final String leftLabel;
  final bool leftOutlined;
  final VoidCallback onLeftTap;
  final String rightLabel;
  final VoidCallback onRightTap;

  const _TwoButtons({
    required this.leftLabel,
    required this.onLeftTap,
    required this.rightLabel,
    required this.onRightTap,
    this.leftOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left button (outlined)
        Expanded(
          child: OutlinedButton(
            onPressed: onLeftTap,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
              side: BorderSide(color: AppColors.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.r(30)),
              ),
            ),
            child: Text(
              leftLabel,
              style: TextStyle(
                fontSize: Dimensions.f(14),
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),

        SizedBox(width: Dimensions.w(12)),

        // Right button (filled teal)
        Expanded(
          child: ElevatedButton(
            onPressed: onRightTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(vertical: Dimensions.h(14)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.r(30)),
              ),
              elevation: 0,
            ),
            child: Text(
              rightLabel,
              style: TextStyle(
                fontSize: Dimensions.f(14),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

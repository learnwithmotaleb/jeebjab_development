import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';

class AppAlerts {
  // ─────────────────────────────────────────────────────────────────────────
  // ✅ SUCCESS — auto-dismisses after 1.5s
  // Usage: AppAlerts.success(message: 'Profile updated successfully');
  // ─────────────────────────────────────────────────────────────────────────
  static void success({required String message}) {
    Get.dialog(
      _AlertWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CircleIcon(
              icon: Icons.check_rounded,
              color: AppColors.primaryColor,
            ),
            SizedBox(height: Dimensions.h(16)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.f(15),
                fontWeight: FontWeight.w600,
                color: AppColors.labelColor,
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (Get.isDialogOpen == true) Get.back();
    });
  }


  // ─────────────────────────────────────────────────────────────────────────
  static void error({required String message}) {
    Get.dialog(
      _AlertWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CircleIcon(
              icon: Icons.close_rounded,
              color: AppColors.redColor,
            ),
            SizedBox(height: Dimensions.h(16)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.f(15),
                fontWeight: FontWeight.w600,
                color: AppColors.labelColor,
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: true,
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen == true) Get.back();
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 🔔 CONFIRM — yes/no dialog
  // Usage:
  //   AppAlerts.confirm(
  //     title: 'Are you sure?',
  //     message: 'This action cannot be undone.',
  //     onConfirm: () { /* do something */ },
  //   );
  // ─────────────────────────────────────────────────────────────────────────
  static void confirm({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmLabel = 'Yes',
    String cancelLabel = 'No',
    VoidCallback? onCancel,
  }) {
    Get.dialog(
      _AlertWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CircleIcon(
              icon: Icons.help_outline_rounded,
              color: AppColors.primaryColor,
            ),
            SizedBox(height: Dimensions.h(14)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.f(16),
                fontWeight: FontWeight.w700,
                color: AppColors.labelColor,
              ),
            ),
            SizedBox(height: Dimensions.h(8)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.f(13),
                color: AppColors.greyColor,
              ),
            ),
            SizedBox(height: Dimensions.h(20)),
            Row(
              children: [
                // ── Cancel ─────────────────────────────────────────────
                Expanded(
                  child: _AlertButton(
                    label: cancelLabel,
                    isOutlined: true,
                    onTap: () {
                      Get.back();
                      onCancel?.call();
                    },
                  ),
                ),
                SizedBox(width: Dimensions.w(12)),
                // ── Confirm ────────────────────────────────────────────
                Expanded(
                  child: _AlertButton(
                    label: confirmLabel,
                    onTap: () {
                      Get.back();
                      onConfirm();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 🗑️ DELETE — red confirm dialog
  // Usage:
  //   AppAlerts.delete(
  //     message: 'Are you sure you want to delete this post?',
  //     onDelete: () { /* delete logic */ },
  //   );
  // ─────────────────────────────────────────────────────────────────────────
  static void delete({
    required String message,
    required VoidCallback onDelete,
    String title = 'Delete',
  }) {
    Get.dialog(
      _AlertWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CircleIcon(
              icon: Icons.delete_outline_rounded,
              color: AppColors.redColor,
            ),
            SizedBox(height: Dimensions.h(14)),
            Text(
              title,
              style: TextStyle(
                fontSize: Dimensions.f(16),
                fontWeight: FontWeight.w700,
                color: AppColors.labelColor,
              ),
            ),
            SizedBox(height: Dimensions.h(8)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.f(13),
                color: AppColors.greyColor,
              ),
            ),
            SizedBox(height: Dimensions.h(20)),
            Row(
              children: [
                Expanded(
                  child: _AlertButton(
                    label: 'Cancel',
                    isOutlined: true,
                    onTap: () => Get.back(),
                  ),
                ),
                SizedBox(width: Dimensions.w(12)),
                Expanded(
                  child: _AlertButton(
                    label: 'Delete',
                    color: AppColors.redColor,
                    onTap: () {
                      Get.back();
                      onDelete();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 🚪 LOGOUT — dedicated logout confirm dialog
  // Usage:
  //   AppAlerts.logout(onLogout: () { /* logout logic */ });
  // ─────────────────────────────────────────────────────────────────────────
  static void logout({required VoidCallback onLogout}) {
    Get.dialog(
      _AlertWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CircleIcon(
              icon: Icons.logout_rounded,
              color: AppColors.redColor,
            ),
            SizedBox(height: Dimensions.h(14)),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: Dimensions.f(16),
                fontWeight: FontWeight.w700,
                color: AppColors.labelColor,
              ),
            ),
            SizedBox(height: Dimensions.h(8)),
            Text(
              'Are you sure you want to logout\nfrom your account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.f(13),
                color: AppColors.greyColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: Dimensions.h(20)),
            Row(
              children: [
                Expanded(
                  child: _AlertButton(
                    label: 'Cancel',
                    isOutlined: true,
                    onTap: () => Get.back(),
                  ),
                ),
                SizedBox(width: Dimensions.w(12)),
                Expanded(
                  child: _AlertButton(
                    label: 'Logout',
                    color: AppColors.redColor,
                    onTap: () {
                      Get.back();
                      onLogout();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // ℹ️ INFO — informational dialog with single OK button
  // Usage: AppAlerts.info(title: 'Notice', message: 'Your session expired.');
  // ─────────────────────────────────────────────────────────────────────────
  static void info({
    required String title,
    required String message,
    String buttonLabel = 'OK',
    VoidCallback? onOk,
  }) {
    Get.dialog(
      _AlertWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CircleIcon(
              icon: Icons.info_outline_rounded,
              color: AppColors.primaryColor,
            ),
            SizedBox(height: Dimensions.h(14)),
            Text(
              title,
              style: TextStyle(
                fontSize: Dimensions.f(16),
                fontWeight: FontWeight.w700,
                color: AppColors.labelColor,
              ),
            ),
            SizedBox(height: Dimensions.h(8)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.f(13),
                color: AppColors.greyColor,
              ),
            ),
            SizedBox(height: Dimensions.h(20)),
            _AlertButton(
              label: buttonLabel,
              onTap: () {
                Get.back();
                onOk?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE HELPER WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _AlertWrapper extends StatelessWidget {
  final Widget child;

  const _AlertWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.r(20)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(24),
          vertical: Dimensions.h(28),
        ),
        child: child,
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _CircleIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.w(64),
      height: Dimensions.w(64),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2.5),
        color: color.withOpacity(0.07),
      ),
      child: Icon(icon, color: color, size: Dimensions.w(30)),
    );
  }
}

class _AlertButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isOutlined;
  final Color? color;

  const _AlertButton({
    required this.label,
    required this.onTap,
    this.isOutlined = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final btnColor = color ?? AppColors.primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimensions.h(44),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.white : btnColor,
          borderRadius: BorderRadius.circular(Dimensions.r(30)),
          border: Border.all(
            color: isOutlined ? const Color(0xFFDDDDDD) : btnColor,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.f(14),
            fontWeight: FontWeight.w700,
            color: isOutlined ? AppColors.labelColor : Colors.white,
          ),
        ),
      ),
    );
  }
}
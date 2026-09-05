import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_text_style/app_text_style.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../controller/no_internet_controller.dart';


class InternetWrapper extends StatelessWidget {
  final Widget child;

  const InternetWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<InternetController>();

    return Obx(() {
      return Stack(
        children: [
          child,

          // No Internet Overlay
          if (!controller.isConnected.value)
            Container(
              color: Colors.white,
              child:  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "No Internet Connection",
                      style: AppTextStyles.title.copyWith(
                        decoration: TextDecoration.none
                      )
                    ),
                    SizedBox(height: 8),
                    Text("Please check your internet",style: AppTextStyles.body.copyWith(
                        decoration: TextDecoration.none
                    )),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: controller.isChecking.value
                          ? null
                          : () => controller.retryConnection(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      icon: controller.isChecking.value
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.refresh),
                      label: Text(
                        controller.isChecking.value ? 'Checking...' : 'Retry',
                      ),
                    ),
                    if (controller.retryMessage.value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          controller.retryMessage.value,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body.copyWith(
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }
}

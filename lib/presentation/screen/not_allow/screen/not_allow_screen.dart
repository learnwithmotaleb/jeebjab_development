import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';

import '../controller/not_allow_controller.dart';

class NotAllowScreen extends StatefulWidget {
  const NotAllowScreen({super.key});

  @override
  State<NotAllowScreen> createState() => _NotAllowScreenState();
}

class _NotAllowScreenState extends State<NotAllowScreen> {
  final NotAllowController controller = Get.put(NotAllowController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h(16)),

                  // ── Title ───────────────────────────────────────────
                  Text(
                    'Not Allowed Wastes',
                    style: TextStyle(
                      fontSize: Dimensions.f(24),
                      fontWeight: FontWeight.w800,
                      color: AppColors.labelColor,
                    ),
                  ),

                  SizedBox(height: Dimensions.h(20)),

                  // ── 3 no-entry icons row ────────────────────────────
                  Row(
                    children: [
                      _NoEntryIcon(icon: Icons.fastfood_outlined),
                      SizedBox(width: Dimensions.w(12)),
                      _NoEntryIcon(icon: Icons.warning_amber_outlined),
                      SizedBox(width: Dimensions.w(12)),
                      _NoEntryIcon(icon: Icons.construction_outlined),
                    ],
                  ),

                  SizedBox(height: Dimensions.h(28)),

                  // ── Items list ──────────────────────────────────────
                  ...controller.items.map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.h(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: Dimensions.f(15),
                              fontWeight: FontWeight.w700,
                              color: AppColors.labelColor,
                            ),
                          ),
                          SizedBox(height: Dimensions.h(6)),
                          Text(
                            item.description,
                            style: TextStyle(
                              fontSize: Dimensions.f(13),
                              color: AppColors.greyColor,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(16)),
                ],
              ),
            ),
          ),

          // ── Continue button pinned bottom ───────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(16),
              Dimensions.h(8),
              Dimensions.w(16),
              Dimensions.h(24),
            ),
            child: AppButton(
              label: AppStrings.continueButton.tr,
              height: 65,
              onPressed: controller.onContinue,
            ),
          ),
          SizedBox(height: Dimensions.h(16)),

        ],
      ),
    );
  }
}

// ── No-Entry Circle Icon ──────────────────────────────────────────────────────
class _NoEntryIcon extends StatelessWidget {
  final IconData icon;

  const _NoEntryIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // ── Circle with icon ───────────────────────────────────────────
        Container(
          width: Dimensions.w(60),
          height: Dimensions.w(60),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red, width: 2.5),
            color: Colors.red.withOpacity(0.05),
          ),
          child: Icon(icon, size: Dimensions.w(28), color: Colors.red),
        ),
        // ── Diagonal line (no-entry slash) ─────────────────────────────
        Transform.rotate(
          angle: -0.7,
          child: Container(
            width: Dimensions.w(58),
            height: 2.5,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

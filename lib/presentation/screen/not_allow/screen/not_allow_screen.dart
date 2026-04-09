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
    return ResponsiveLayout(
        mobile: _buildMobile(),
        tablet: _buildTablet()
    );
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
                  AppStrings.notAllowedWastes.tr,
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
              height: 60,
              onPressed: controller.onContinue,
            ),
          ),
          SizedBox(height: Dimensions.h(16)),

        ],
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w(48),
                    vertical: Dimensions.h(32),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Title ───────────────────────────────────────────
                      Text(
                        AppStrings.notAllowedWastes.tr,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.labelColor,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // ── 3 no-entry icons row ────────────────────────────
                      Row(
                        children: [
                          _NoEntryIcon(icon: Icons.fastfood_outlined),
                          const SizedBox(width: 24),
                          _NoEntryIcon(icon: Icons.warning_amber_outlined),
                          const SizedBox(width: 24),
                          _NoEntryIcon(icon: Icons.construction_outlined),
                        ],
                      ),

                      const SizedBox(height: 48),

                      // ── Items list ──────────────────────────────────────
                      ...controller.items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.labelColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.greyColor,
                                  height: 1.7,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Continue button pinned bottom ───────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(
                  Dimensions.w(48),
                  Dimensions.h(16),
                  Dimensions.w(48),
                  Dimensions.h(40),
                ),
                child: AppButton(
                  label: AppStrings.continueButton.tr,
                  height: Dimensions.h(100),
                  onPressed: controller.onContinue,
                ),
              ),
              SizedBox(height: Dimensions.h(10)),
            ],
          ),
        ),
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
    final bool isTablet = Dimensions.isTablet;
    final double size = isTablet ? 80 : 60;

    return Stack(
      alignment: Alignment.center,
      children: [
        // ── Circle with icon ───────────────────────────────────────────
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red, width: isTablet ? 3.5 : 2.5),
            color: Colors.red.withOpacity(0.05),
          ),
          child: Icon(icon, size: isTablet ? 36 : 28, color: Colors.red),
        ),
        // ── Diagonal line (no-entry slash) ─────────────────────────────
        Transform.rotate(
          angle: -0.7,
          child: Container(
            width: size - 2,
            height: isTablet ? 3.5 : 2.5,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

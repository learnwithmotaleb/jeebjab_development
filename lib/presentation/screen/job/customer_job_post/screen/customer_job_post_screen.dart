import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/customer_job_post_controller.dart';
import '../widget/be_come_driver_banner_card.dart';

class CustomerJobPostScreen extends StatefulWidget {
  const CustomerJobPostScreen({super.key});

  @override
  State<CustomerJobPostScreen> createState() => _CustomerJobPostScreenState();
}

class _CustomerJobPostScreenState extends State<CustomerJobPostScreen> {
  final CustomerJobPostController controller =
  Get.put(CustomerJobPostController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(
        title: AppStrings.jobPost.tr,
        showBack: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(48),
          vertical: Dimensions.h(40),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Dimensions.h(20)),

                // ── Icon/Visual ──────────────────────────────────────
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(Dimensions.r(20)),
                  ),
                  child: Icon(
                    Icons.work_outline,
                    size: 50,
                    color: AppColors.primaryColor,
                  ),
                ),

                SizedBox(height: Dimensions.h(32)),

                // ── Title ────────────────────────────────────────────
                Text(
                  AppStrings.jobPost.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                // ── Subtitle ────────────────────────────────────────
                Text(
                  "Start earning with our platform today",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(height: Dimensions.h(48)),

                // ── Banner Card ─────────────────────────────────────
                BecomeDriverBannerCard(
                  onBecomeDriver: controller.onBecomeDriver,
                ),

                SizedBox(height: Dimensions.h(48)),

                // ── Optional: Benefits Section ───────────────────────
                Container(
                  padding: EdgeInsets.all(Dimensions.w(24)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.r(16)),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Why Join Us?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(height: Dimensions.h(20)),
                      _benefitItem(
                        icon: Icons.trending_up,
                        title: "Flexible Hours",
                        description: "Work when you want, set your own schedule",
                      ),
                      SizedBox(height: Dimensions.h(16)),
                      _benefitItem(
                        icon: Icons.attach_money,
                        title: "Competitive Pay",
                        description: "Get paid fairly for your work and delivery",
                      ),
                      SizedBox(height: Dimensions.h(16)),
                      _benefitItem(
                        icon: Icons.shield_outlined,
                        title: "Safe & Secure",
                        description: "Protected transactions and verified customers",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.jobPost.tr,
        showBack: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(16),
          vertical: Dimensions.h(16),
        ),
        child: BecomeDriverBannerCard(
          onBecomeDriver: controller.onBecomeDriver,
        ),
      ),
    );
  }

  // ── Helper Widget for Benefits ───────────────────────────────────────────
  Widget _benefitItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimensions.r(12)),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 24,
          ),
        ),
        SizedBox(width: Dimensions.w(16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: Dimensions.h(4)),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
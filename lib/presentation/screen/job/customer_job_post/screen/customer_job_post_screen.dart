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
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.whiteColor,

      // ── AppBar ─────────────────────────────────────────────────────
      appBar: CommonAppBar(title: AppStrings.jobPost.tr,showBack: false,),

      // ── Body ────────────────────────────────────────────────────────
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


}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../profile/widget/profile_menu_item_widget.dart';
import '../controller/account_controller.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // ✅ Use Get.put — not AccountController() directly
  final AccountController controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.accountSetting.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(Dimensions.r(5)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.r(10)),
              child: Column(
                children: List.generate(
                  controller.menuItems.length,
                      (index) => ProfileMenuItemWidget(
                    item: controller.menuItems[index],
                    showDivider: index < controller.menuItems.length - 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.accountSetting.tr),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(48),
          vertical: Dimensions.h(32),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.h(20)),

                // ── Icon/Visual ──────────────────────────────────────
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Dimensions.r(20)),
                    ),
                    child: Icon(
                      Icons.settings_outlined,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Title ────────────────────────────────────────────
                Center(
                  child: Text(
                    AppStrings.accountSetting.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                // ── Subtitle ────────────────────────────────────────
                Center(
                  child: Text(
                    "Manage your account preferences and security",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(48)),

                // ── Menu Items ───────────────────────────────────────
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(Dimensions.r(12)),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.r(12)),
                    child: Column(
                      children: List.generate(
                        controller.menuItems.length,
                            (index) => Column(
                          children: [
                            ProfileMenuItemWidget(
                              item: controller.menuItems[index],
                              showDivider:false,
                            ),
                            if (index < controller.menuItems.length - 1)
                              Divider(
                                height: 1,
                                color: Colors.grey.shade200,
                              ),
                          ],



                        ),
                      ),
                    ),
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
}
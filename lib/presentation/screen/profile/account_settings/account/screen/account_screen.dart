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
    return ResponsiveLayout(mobile: _buildMobile());
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
}
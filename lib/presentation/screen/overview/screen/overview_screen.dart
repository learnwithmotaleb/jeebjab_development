import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:jeebjab/presentation/screen/overview/widget/i_will_pay_section_widget.dart';

import '../../../../core/responsive_layout/dimensions.dart';
import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/custom_appbar.dart';
import '../controller/overview_controller.dart';
import '../widget/drop_address.dart';
import '../widget/overview_address_section.dart';
import '../widget/date_time_overview_bottom_section.dart';
import '../widget/overview_photos_section.dart';
import '../widget/overview_publish_section.dart';
import '../widget/overview_service_section.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {

  OverviewController controller = Get.put(OverviewController());


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
    );
  }
  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Overview"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: const [
                  OverviewPhotosSection(),
                  SizedBox(height: 12),
                  OverviewServiceSection(),
                  SizedBox(height: 12),
                  OverviewAddressSection(),
                  SizedBox(height: 12),
                  DropAddressSection(),
                  SizedBox(height: 12),
                  OverviewDatetimeBottomSection(),
                  SizedBox(height: 12),
                  OverviewIWillPayBottomSection(
                  ),
                ],
              ),
            ),
          ),
          const OverviewPublishSection(),
          SizedBox(height: 12)
        ],
      ),
    );
  }
}

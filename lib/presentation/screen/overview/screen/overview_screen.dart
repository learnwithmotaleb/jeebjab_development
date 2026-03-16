import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/presentation/screen/overview/widget/acknowledgement_section.dart';
import 'package:jeebjab/presentation/screen/overview/widget/i_will_pay_section_widget.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

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

  final OverviewController controller = Get.put(OverviewController());


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
    );
  }
  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CommonAppBar(title:AppStrings.overview.tr),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [  
                  const OverviewPhotosSection(),
                  const SizedBox(height: 12),
                  const OverviewServiceSection(),
                  const SizedBox(height: 12),
                  const OverviewAddressSection(),
                  const SizedBox(height: 12),
                  const DropAddressSection(),
                  const SizedBox(height: 12),
                  const OverviewDatetimeBottomSection(),

                  const SizedBox(height: 12),
                  const OverviewIWillPayBottomSection(),
                  const SizedBox(height: 12),

                  const AcknowledgementSection(),

                ],
              ),
            ),
          ),
          const OverviewPublishSection(),
          const SizedBox(height: 12)
        ],
      ),
    );
  }
}

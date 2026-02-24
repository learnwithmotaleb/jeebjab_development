import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../core/responsive_layout/dimensions.dart';
import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/custom_appbar.dart';
import '../../pickup_floor/widget/inline_label_field_widget.dart';
import '../../pickup_floor/widget/toggle_option_row_widget.dart';
import '../controller/drop_off_floor_controller.dart';

class DropOffFloorScreen extends StatefulWidget {
  const DropOffFloorScreen({super.key});

  @override
  State<DropOffFloorScreen> createState() => _DropOffFloorScreenState();
}

class _DropOffFloorScreenState extends State<DropOffFloorScreen> {
  DropOffFloorController controller = Get.put(DropOffFloorController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: "Drop Off Floor & Door Code"),
      body: Column(
        children: [
          // ── Scrollable Content ────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Dimensions.w(16)),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h(8)),

                  // ── Floor Field ─────────────────────────────────
                  InlineLabelField(
                    label: 'Floor',
                    controller: controller.floorController,
                    hint: '12',
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(height: Dimensions.h(10)),

                  // ── Door Code Field ─────────────────────────────
                  InlineLabelField(
                    label: 'Door Code',
                    controller: controller.doorCodeController,
                    hint: 'E36',
                    keyboardType: TextInputType.text,
                  ),

                  SizedBox(height: Dimensions.h(10)),

                  // ── Fits In Elevator toggle ─────────────────────
                  ToggleOptionRow(
                    label: 'Fits In The Elevator',
                    isSelected: controller.fitsInElevator.value,
                    onTap: controller.toggleElevator,
                  ),

                  SizedBox(height: Dimensions.h(10)),

                  // ── Other Info TextArea ─────────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius:
                      BorderRadius.circular(Dimensions.r(10)),
                      border: Border.all(color: const Color(0xFFE8E8E8)),
                    ),
                    child: TextField(
                      controller: controller.otherInfoController,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: Dimensions.f(14),
                        color: AppColors.labelColor,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Write Other Info',
                        hintStyle: TextStyle(
                          fontSize: Dimensions.f(14),
                          color: AppColors.hintColor,
                        ),
                        contentPadding: EdgeInsets.all(Dimensions.w(14)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(24)),
                ],
              )),
            ),
          ),

          // ── Continue Button pinned bottom ─────────────────────────────
          Padding(
              padding: EdgeInsets.fromLTRB(
                Dimensions.w(16),
                Dimensions.h(8),
                Dimensions.w(16),
                Dimensions.h(24),
              ),
              child: AppButton(
                height: 65,
                label: AppStrings.continueButton.tr,
                onPressed: controller.onContinue,

              )



          ),
          SizedBox(height: Dimensions.h(24)),

        ],
      ),
    );
  }
}

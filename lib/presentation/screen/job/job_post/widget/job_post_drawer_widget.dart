import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/widget/app_button.dart';

import '../../../../../utils/static_strings/static_strings.dart';

class JobPostDrawer extends StatefulWidget {
  const JobPostDrawer({super.key});

  @override
  State<JobPostDrawer> createState() => _JobPostDrawerState();
}

class _JobPostDrawerState extends State<JobPostDrawer> {
  // ── Sort By ───────────────────────────────────────────────────────────────
  String _selectedSort = AppStrings.nearest.tr;

  // ── Time ──────────────────────────────────────────────────────────────────
  String _selectedTime = 'Regular';

  // ── Pick-Up Placement ─────────────────────────────────────────────────────
  String _selectedPickup = 'Inside The House/Apartment';
  bool _pickupNoMeet = false;
  bool _pickupCanHelp = false;

  // ── Drop-Off Placement ────────────────────────────────────────────────────
  String _selectedDropoff = 'Inside';
  bool _dropoffNoMeet = false;
  bool _dropoffCanHelp = false;

  // ── Ad Type ───────────────────────────────────────────────────────────────
  bool _delivery = true;
  bool _recycling = true;
  bool _buyForMe = false;
  bool _giveAway = false;

  // ── Distance ──────────────────────────────────────────────────────────────
  double _distance = 90;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: Dimensions.screenWidth * (Dimensions.isTablet ? 0.4 : 0.88),
      child: SafeArea(
        child: Column(
          children: [
            // ── Header ────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(16),
                vertical: Dimensions.h(14),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 18, color: Colors.black),
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.filter.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Dimensions.f(17),
                        fontWeight: FontWeight.w700,
                        color: AppColors.labelColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close_rounded,
                        size: 20, color: Colors.black),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFF0F0F0)),

            // ── Scrollable Content ────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimensions.h(16)),

                    // ── Sort By ─────────────────────────────────────────
                    _SectionCard(
                      title: AppStrings.sortBy.tr,
                      child: Column(
                        children: [AppStrings.nearest.tr, AppStrings.newest.tr].map((opt) {
                          return _RadioRow(
                            label: opt,
                            selected: _selectedSort == opt,
                            onTap: () =>
                                setState(() => _selectedSort = opt),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: Dimensions.h(12)),

                    // ── Time ───────────────────────────────────────────
                    _SectionCard(
                      title: AppStrings.time.tr,
                      child: Column(
                        children: ['Regular', 'Priority'].map((opt) {
                          return _RadioRow(
                            label: opt,
                            selected: _selectedTime == opt,
                            onTap: () =>
                                setState(() => _selectedTime = opt),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: Dimensions.h(12)),

                    // ── Pick-Up Placement ──────────────────────────────
                    _SectionCard(
                      title: AppStrings.pickUpPlacement.tr,
                      child: Column(
                        children: [
                          ...[
                            AppStrings.insideHouseApartment.tr,
                            AppStrings.outsideHouseApartment.tr,
                          ].map((opt) => _RadioRow(
                            label: opt,
                            selected: _selectedPickup == opt,
                            onTap: () => setState(
                                    () => _selectedPickup = opt),
                          )),
                          SizedBox(height: Dimensions.h(4)),
                          _ToggleRow(
                            label:   AppStrings.noMeet.tr,

                            value: _pickupNoMeet,
                            onToggle: (v) =>
                                setState(() => _pickupNoMeet = v),
                          ),
                          _ToggleRow(
                            label: AppStrings.canHelp.tr,
                            value: _pickupCanHelp,
                            onToggle: (v) =>
                                setState(() => _pickupCanHelp = v),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Dimensions.h(12)),

                    // ── Drop-Off Placement ─────────────────────────────
                    _SectionCard(
                      title: AppStrings.dropOffPlacement.tr,
                      child: Column(
                        children: [
                          ...[AppStrings.inside.tr, AppStrings.outside.tr].map((opt) => _RadioRow(
                            label: opt,
                            selected: _selectedDropoff == opt,
                            onTap: () => setState(
                                    () => _selectedDropoff = opt),
                          )),
                          SizedBox(height: Dimensions.h(4)),
                          _ToggleRow(
                            label: AppStrings.noMeet.tr,
                            value: _dropoffNoMeet,
                            onToggle: (v) =>
                                setState(() => _dropoffNoMeet = v),
                          ),
                          _ToggleRow(
                            label: AppStrings.canHelp.tr,
                            value: _dropoffCanHelp,
                            onToggle: (v) =>
                                setState(() => _dropoffCanHelp = v),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Dimensions.h(12)),

                    // ── Ad Type ────────────────────────────────────────
                    _SectionCard(
                      title: AppStrings.adType.tr,
                      child: Column(
                        children: [
                          _ToggleRow(
                            label: AppStrings.move.tr,
                            value: _delivery,
                            onToggle: (v) =>
                                setState(() => _delivery = v),
                          ),
                          _ToggleRow(
                            label: AppStrings.recycling.tr,
                            value: _recycling,
                            onToggle: (v) =>
                                setState(() => _recycling = v),
                          ),
                          _ToggleRow(
                            label: AppStrings.buyForMe.tr,
                            value: _buyForMe,
                            onToggle: (v) =>
                                setState(() => _buyForMe = v),
                          ),
                          _ToggleRow(
                            label: AppStrings.giveAway.tr,
                            value: _giveAway,
                            onToggle: (v) =>
                                setState(() => _giveAway = v),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Dimensions.h(12)),

                    // ── Distance ───────────────────────────────────────
                    _SectionCard(
                      title: AppStrings.distance.tr,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                _distance.toInt().toString(),
                                style: TextStyle(
                                  fontSize: Dimensions.f(13),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.labelColor,
                                ),
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: AppColors.primaryColor,
                              inactiveTrackColor: const Color(0xFFE0E0E0),
                              thumbColor: AppColors.primaryColor,
                              overlayColor:
                              AppColors.primaryColor.withOpacity(0.15),
                              trackHeight: 4,
                            ),
                            child: Slider(
                              value: _distance,
                              min: 0,
                              max: 120,
                              divisions: 24,
                              onChanged: (v) =>
                                  setState(() => _distance = v),
                            ),
                          ),
                          // Labels
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.w(4)),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: ['10', '15', '20', '30', '50', '80', '100', '120']
                                  .map(
                                    (l) => Text(
                                  l,
                                  style: TextStyle(
                                    fontSize: Dimensions.f(10),
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Dimensions.h(24)),
                  ],
                ),
              ),
            ),

            // ── Apply Button ──────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                Dimensions.w(16),
                Dimensions.h(8),
                Dimensions.w(16),
                Dimensions.h(20),
              ),
              
              child:AppButton(label:   AppStrings.apply.tr,
                height: Dimensions.h(56),
                onPressed: () => Get.back(),)
            ),
            SizedBox(height: Dimensions.h(24)),


          ],
        ),
      ),
    );
  }
}

// ─── Section Card ─────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Dimensions.f(13),
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: Dimensions.h(8)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w(14),
            vertical: Dimensions.h(8),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.r(10)),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          child: child,
        ),
      ],
    );
  }
}

// ─── Radio Row ────────────────────────────────────────────────────────────────
class _RadioRow extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RadioRow({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h(5)),
        child: Row(
          children: [
            Container(
              width: Dimensions.w(18),
              height: Dimensions.w(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? AppColors.primaryColor
                      : const Color(0xFFCCCCCC),
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                child: Container(
                  width: Dimensions.w(9),
                  height: Dimensions.w(9),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                ),
              )
                  : null,
            ),
            SizedBox(width: Dimensions.w(10)),
            Text(
              label,
              style: TextStyle(
                fontSize: Dimensions.f(13),
                color: AppColors.labelColor,
                fontWeight:
                selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Toggle Row ───────────────────────────────────────────────────────────────
class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onToggle;

  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: Dimensions.f(13),
              color: AppColors.labelColor,
            ),
          ),
          Row(
            children: [
              Text(
                value ? 'On' : 'Off',
                style: TextStyle(
                  fontSize: Dimensions.f(11),
                  color:
                  value ? AppColors.primaryColor : AppColors.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: Dimensions.w(6)),
              GestureDetector(
                onTap: () => onToggle(!value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: Dimensions.w(38),
                  height: Dimensions.w(20),
                  padding: EdgeInsets.all(Dimensions.w(2)),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(Dimensions.r(20)),
                    color: value
                        ? AppColors.primaryColor
                        : const Color(0xFFDDDDDD),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment: value
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: Dimensions.w(16),
                      height: Dimensions.w(16),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
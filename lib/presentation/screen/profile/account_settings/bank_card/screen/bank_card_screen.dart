import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/bank_card_controller.dart';
import '../widget/bank_card_item_widget.dart';

class BankCardScreen extends StatefulWidget {
  const BankCardScreen({super.key});

  @override
  State<BankCardScreen> createState() => _BankCardScreenState();
}

class _BankCardScreenState extends State<BankCardScreen> {
  final BankCardController controller = Get.put(BankCardController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.bankCard.tr),
      body: Obx(() => SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(16),
          vertical: Dimensions.h(16),
        ),
        child: Column(
          children: [
            // ── Card List ─────────────────────────────────────────
            ...controller.cards.map(
                  (card) => Padding(
                padding: EdgeInsets.only(bottom: Dimensions.h(12)),
                child: BankCardItemWidget(
                  card: card,
                  onEdit: () => controller.onEditCard(card),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
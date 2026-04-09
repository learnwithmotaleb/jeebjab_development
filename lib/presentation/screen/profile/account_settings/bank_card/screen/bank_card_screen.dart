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
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
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
            //── Card List ─────────────────────────────────────────
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

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.bankCard.tr),
      body: Obx(
            () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w(48),
            vertical: Dimensions.h(32),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
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
                        Icons.credit_card_outlined,
                        size: 50,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(40)),

                  // ── Title ────────────────────────────────────────────
                  Center(
                    child: Text(
                      AppStrings.bankCard.tr,
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
                      "Manage your bank cards and payment methods",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(48)),

                  // ── Card Grid Layout (2 Columns) ───────────────────
                  controller.cards.isEmpty
                      ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.h(40),
                      ),
                      child: Text(
                        "No bank cards added yet",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  )
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.6,
                      crossAxisSpacing: Dimensions.w(24),
                      mainAxisSpacing: Dimensions.h(24),
                    ),
                    itemCount: controller.cards.length,
                    itemBuilder: (context, index) {
                      final card = controller.cards[index];
                      return BankCardItemWidget(
                        card: card,
                        onEdit: () => controller.onEditCard(card),
                      );
                    },
                  ),

                  SizedBox(height: Dimensions.h(40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
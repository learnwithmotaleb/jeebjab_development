import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../core/enums/post_category_type.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../helper/local_db/local_db.dart';
import '../../../../widget/app_bottom_sheet.dart';
import '../post_category_model/post_category_model.dart';
import '../widget/catagory_info_sheet_widget.dart';

class CreatePostController extends GetxController {
  // ── Selected Category ─────────────────────────────────────────────────────
  final Rx<PostCategoryModel?> selectedCategory =
  Rx<PostCategoryModel?>(null);

  // ── Categories List ───────────────────────────────────────────────────────
  final List<PostCategoryModel> categories = [
    PostCategoryModel(
      type: PostCategoryType.move,
      title: 'Move',
      subtitle: 'Delivers Package From One Place To Another Place',
    ),
    PostCategoryModel(
      type: PostCategoryType.recycling,
      title: 'Recycling',
      subtitle: 'Used Or Discarded Materials Transforming Them Into New',
    ),
    PostCategoryModel(
      type: PostCategoryType.buyForMe,
      title: 'Buy For Me',
      subtitle: 'Used Or Discarded Materials Transforming Them Into New',
      isEnabled: false,
    ),
    PostCategoryModel(
      type: PostCategoryType.giveAway,
      title: 'Give Away',
      subtitle: 'Used Or Discarded Materials Transforming Them Into New',
      isEnabled: false,
    ),
  ];

  // ── Init: Load Saved Category ─────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _loadSavedCategory();
  }

  void _loadSavedCategory() {
    final savedType = SharePrefsHelper.getPostCategory();
    if (savedType == null) return;

    selectedCategory.value =
        categories.firstWhereOrNull((e) => e.type == savedType);
  }

  // ── Select Category ───────────────────────────────────────────────────────
  Future<void> selectCategory(PostCategoryModel category) async {
    if (!category.isEnabled) return;

    selectedCategory.value = category;

    // 🔥 Save only enum (clean)
    await SharePrefsHelper.savePostCategory(category.type);

    _showCategorySheet(category);
  }

  // ── Bottom Sheet ──────────────────────────────────────────────────────────
  void _showCategorySheet(PostCategoryModel category) {
    AppBottomSheet(
      child: CategoryInfoSheet(
        categoryKey: category.type.name,
        onContinue: () {
          Get.back();
          _navigateByCategory(category.type);
        },
      ),
    );
  }

  // ── Navigate Based on Category ───────────────────────────────────────────
  void _navigateByCategory(PostCategoryType type) {
    switch (type) {
      case PostCategoryType.move:
        Get.toNamed(RoutePath.captureImage);
        break;

      case PostCategoryType.recycling:
        Get.toNamed(RoutePath.captureImage);
        break;

      case PostCategoryType.buyForMe:
        Get.toNamed(RoutePath.captureImage);
        break;

      case PostCategoryType.giveAway:
        Get.toNamed(RoutePath.captureImage);
        break;
    }
  }

  // ── Check Selected ────────────────────────────────────────────────────────
  bool isSelected(PostCategoryModel category) {
    return selectedCategory.value?.type == category.type;
  }
}
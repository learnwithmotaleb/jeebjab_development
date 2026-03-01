import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import '../../../../utils/static_strings/static_strings.dart';

class PlacementOption {
  final String label;
  final String icon; // icon name reference

  PlacementOption({required this.label, required this.icon});
}

class PlacementPickupController extends GetxController {
  // ── Single choice (only one) ──────────────────────────────────────────────
  final RxString selectedPlacement = ''.obs;

  // ── Multi choice (both allowed) ───────────────────────────────────────────
  final RxSet<String> selectedAdditional = <String>{}.obs;

  // ── Placement options (choose only one) ───────────────────────────────────
  final List<PlacementOption> placementOptions = [
    PlacementOption(label: AppStrings.insideHouse, icon: 'house'),
    PlacementOption(label: AppStrings.outsideHouse, icon: 'outside'),
  ];

  // ── Additional options (choose both) ─────────────────────────────────────
  final List<PlacementOption> additionalOptions = [
    PlacementOption(label: AppStrings.needToMeet, icon: 'meet'),
    PlacementOption(label: AppStrings.canHelpCarry, icon: 'carry'),
  ];

  // ── Select placement (single) ─────────────────────────────────────────────
  void selectPlacement(String label) {
    selectedPlacement.value = label;
  }

  // ── Toggle additional (multi) ─────────────────────────────────────────────
  void toggleAdditional(String label) {
    if (selectedAdditional.contains(label)) {
      selectedAdditional.remove(label);
    } else {
      selectedAdditional.add(label);
    }
  }

  bool isPlacementSelected(String label) => selectedPlacement.value == label;
  bool isAdditionalSelected(String label) => selectedAdditional.contains(label);

  bool get isValid => selectedPlacement.value.isNotEmpty;

  void onContinue() {
    if (!isValid) return; // optional: prevent continue if no selection
    Get.toNamed(RoutePath.pickupFloor);
  }
}
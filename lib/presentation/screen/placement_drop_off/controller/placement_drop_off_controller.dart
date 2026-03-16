import 'package:get/get.dart';

import '../../../../core/routes/route_path.dart';
import '../../placement_pickup/controller/placement_pickup_controller.dart';

class PlacementDropOffController extends GetxController{
  // ── Single choice (only one) ──────────────────────────────────────────────
  final RxString selectedPlacement = ''.obs;

  // ── Multi choice (both allowed) ───────────────────────────────────────────
  final RxSet<String> selectedAdditional = <String>{}.obs;

  // ── Placement options (choose only one) ───────────────────────────────────
  final List<PlacementOption> placementOptions = [
    PlacementOption(label: 'Inside The House/Apartment', icon: 'house'),
    PlacementOption(label: 'Outside The House/Apartment', icon: 'outside'),
  ];

  // ── Additional options (choose both) ─────────────────────────────────────
  final List<PlacementOption> additionalOptions = [
    PlacementOption(label: 'Need To Meet', icon: 'meet'),
    PlacementOption(label: 'Can Help Carry At Pick-Up', icon: 'carry'),
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
    // if (!isValid) return;
    // // TODO: Navigate to next step
    Get.toNamed(RoutePath.dropOffFloor);
  }


}
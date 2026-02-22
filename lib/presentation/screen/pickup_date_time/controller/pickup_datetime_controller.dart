import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

enum PickupType { regular, priority, custom }

class TimeSlot {
  final String label; // e.g. "00:00-01:00"
  final bool isSelected;

  TimeSlot({required this.label, this.isSelected = false});

  TimeSlot copyWith({bool? isSelected}) =>
      TimeSlot(label: label, isSelected: isSelected ?? this.isSelected);
}

class PickupDatetimeController extends GetxController {
  // ── Selected option ───────────────────────────────────────────────────────
  final Rx<PickupType> selectedType = PickupType.regular.obs;

  // ── Custom time expanded ──────────────────────────────────────────────────
  final RxBool isCustomExpanded = false.obs;

  // ── Selected time slot ────────────────────────────────────────────────────
  final RxString selectedSlot = ''.obs; // e.g. "today_00:00-01:00"

  // ── Time slots ────────────────────────────────────────────────────────────
  final List<String> timeSlots = [
    '00:00-01:00',
    '01:00-02:00',
    '02:00-03:00',
    '03:00-04:00',
    '04:00-05:00',
    '05:00-06:00',
    '07:00-08:00',
  ];

  void selectType(PickupType type) {
    selectedType.value = type;
    if (type == PickupType.custom) {
      isCustomExpanded.value = !isCustomExpanded.value;
    } else {
      isCustomExpanded.value = false;
      selectedSlot.value = '';
    }
  }

  void selectSlot(String day, String slot) {
    selectedSlot.value = '${day}_$slot';
  }

  bool isSlotSelected(String day, String slot) {
    return selectedSlot.value == '${day}_$slot';
  }

  bool get isValid {
    if (selectedType.value == PickupType.regular) return true;
    if (selectedType.value == PickupType.priority) return true;
    if (selectedType.value == PickupType.custom) {
      return selectedSlot.value.isNotEmpty;
    }
    return false;
  }

  void onContinue() {
    // if (!isValid) return;
    // // TODO: navigate to next step

    Get.toNamed(RoutePath.pickupAddress);
  }
}
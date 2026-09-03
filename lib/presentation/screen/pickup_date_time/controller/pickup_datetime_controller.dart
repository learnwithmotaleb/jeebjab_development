import 'dart:convert';

import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import '../../../../helper/tost_message/show_snackbar.dart';

enum PickupType { regular, priority, scheduled, anytime }

class TimeSlot {
  final String label; // e.g. "00:00-01:00"
  final bool isSelected;

  TimeSlot({required this.label, this.isSelected = false});

  TimeSlot copyWith({bool? isSelected}) =>
      TimeSlot(label: label, isSelected: isSelected ?? this.isSelected);
}

class PickupDatetimeController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // ── Reschedule mode: reached from Status Details' "Reschedule" button on
  // an existing pending post, rather than the create-post wizard. Distinct
  // from the wizard's own `isEdit` argument (editing this step before
  // publishing, no id/API call involved).
  String? postId;
  bool get isRescheduleMode => postId != null && postId!.isNotEmpty;
  final RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    postId = Get.arguments?['postId']?.toString();
  }

  // ── Selected option ───────────────────────────────────────────────────────
  final Rx<PickupType> selectedType = PickupType.regular.obs;

  // ── Custom time expanded ──────────────────────────────────────────────────
  final RxBool isCustomExpanded = false.obs;

  // ── Selected time slot ────────────────────────────────────────────────────
  final RxString selectedSlot = ''.obs; // e.g. "today_00:00-01:00"

  // ── Time slots ────────────────────────────────────────────────────────────
  final List<String> timeSlots = [
    '01:00-01:30',
    '01:30-02:00',
    '02:00-02:30',
    '02:30-03:00',
    '03:00-03:30',
    '03:30-04:00',
    '04:00-04:30',
    '04:30-05:00',
  ];

  void selectType(PickupType type) {
    selectedType.value = type;
    if (type == PickupType.scheduled) {
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
    if (selectedType.value == PickupType.scheduled) {
      return selectedSlot.value.isNotEmpty;
    }
    return false;
  }

  void onContinue() {
    if (selectedType.value == PickupType.scheduled && selectedSlot.value.isEmpty) {
      AppSnackBar.fail("Please select a time slot for scheduled pickup.", title: "Required");
      return;
    }

    if (isRescheduleMode) {
      onUpdateSchedule();
      return;
    }

    final bool isEditMode = Get.arguments?['isEdit'] ?? false;

    if (isEditMode) {
      Get.back();
    } else {
      Get.toNamed(RoutePath.pickupAddress);
    }
  }

  // Reschedule mode — PATCH /post/:id with just the new dateTimeSlot,
  // partial update per the API contract (only fields you want to change).
  Future<void> onUpdateSchedule() async {
    if (postId == null || postId!.isEmpty || isSaving.value) return;

    isSaving.value = true;
    try {
      final Map<String, dynamic> dateTimeSlot = {
        "slotType": selectedType.value.name,
        "scheduledDate": selectedType.value == PickupType.scheduled
            ? selectedSlot.value.split('_').first // 'today' or 'tomorrow'
            : null,
        "scheduledTime": selectedType.value == PickupType.scheduled
            ? selectedSlot.value.split('_').last // e.g. '01:00-01:30'
            : null,
      };

      final response = await _apiClient.patchMultipart(
        url: ApiUrl.updateJobPostDetails(postId!),
        fields: {
          'data': jsonEncode({"dateTimeSlot": dateTimeSlot}),
        },
        files: const [],
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Navigate back before the snackbar — see AppSnackBar's own note
        // on why firing them together races Get.back() on GetX's overlay
        // stack and can swallow the toast.
        Get.back(result: true);
        AppSnackBar.success(
          response.body['message'] ?? AppStrings.postUpdatedSuccessfully.tr,
        );
      } else {
        AppSnackBar.fail(
          response.body['message'] ?? AppStrings.failedToUpdatePost.tr,
        );
      }
    } catch (e) {
      AppSnackBar.fail("An error occurred: $e");
    } finally {
      isSaving.value = false;
    }
  }

  void onSaveAndPublish() {
    if (selectedType.value == PickupType.scheduled && selectedSlot.value.isEmpty) {
      AppSnackBar.fail("Please select a time slot for scheduled pickup.", title: "Required");
      return;
    }
    Get.back(result: true);
  }
}
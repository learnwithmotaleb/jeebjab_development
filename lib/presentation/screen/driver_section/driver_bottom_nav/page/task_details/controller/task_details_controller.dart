import 'package:get/get.dart';

import '../../../../../../../core/enums/task.dart';
import '../../../../../../../core/routes/route_path.dart';
import '../../../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../../../service/api_service.dart';
import '../../../../../../../service/api_url.dart';
import '../../../../../../../utils/static_strings/static_strings.dart';
import '../../../../../../../widget/app_share.dart';

/// One row of the real-time status timeline (see `timeline` on
/// GET /driver/tasks/:id and PATCH /driver/tasks/:id/status). Steps not
/// reached yet are still shown, greyed out, using a generic subtitle.
class TimelineStepDisplay {
  final int step;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final String? timestamp;

  TimelineStepDisplay({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    this.timestamp,
  });
}

class TaskDetailsController extends GetxController{

  final ApiClient _apiClient = ApiClient();

  // ── State ─────────────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // ── Item Info ─────────────────────────────────────────────────────────────
  RxString itemType = "".obs;
  RxString itemSubtype = "".obs;
  RxString publishedTime = "".obs;
  RxDouble itemPrice = 0.0.obs;

  // ── Meta ──────────────────────────────────────────────────────────────────
  RxString size = "".obs;
  RxString preferredPickupTime = "".obs;

  // ── Carousel Images ───────────────────────────────────────────────────────
  RxList<String> images = <String>[].obs;

  // ── Pick-Up Info ──────────────────────────────────────────────────────────
  RxString pickupAddress = "".obs;
  RxList<String> pickupFeatures = <String>[].obs;
  double? pickupLat;
  double? pickupLng;

  // ── Delivery Info ─────────────────────────────────────────────────────────
  RxString deliveryAddress = "".obs;
  RxList<String> deliveryFeatures = <String>[].obs;
  double? dropoffLat;
  double? dropoffLng;

  // ── Advertiser Info ───────────────────────────────────────────────────────
  RxString advertiserName = "".obs;
  RxDouble advertiserRating = 0.0.obs;
  RxString advertiserImage = "".obs;

  // ── Real-time Status (pending → active → picked_up → in_transit →
  // completed) ─────────────────────────────────────────────────────────────
  Rx<TaskStatus?> taskStatus = Rx<TaskStatus?>(null);
  RxList<TimelineStepDisplay> timelineSteps = <TimelineStepDisplay>[].obs;

  bool get isCancelled => taskStatus.value == TaskStatus.cancelled;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  String? _taskId;

  void _loadArguments() {
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      final String? id = args['id'];

      // If we have some data passed from the previous screen, show it while loading
      itemType.value = args['itemType'] ?? "";
      itemSubtype.value = args['itemSubtype'] ?? "";
      itemPrice.value = (args['price'] ?? 0).toDouble();

      if (id != null) {
        _taskId = id;
        fetchPostDetails(id);
      }
    }
  }

  /// Re-fetches this task so the status/timeline reflect the latest state —
  /// used for pull-to-refresh on the details screen.
  Future<void> refreshTaskDetails() async {
    if (_taskId != null) await fetchPostDetails(_taskId!);
  }

  Future<void> fetchPostDetails(String id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiClient.get(url: ApiUrl.getTaskDetails(id), isToken: true);

      if (response.statusCode == 200) {
        final data = response.body['data'];
        _mapPostData(data);
      } else {
        errorMessage.value = response.statusText ?? "Failed to load post details";
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }

  void _mapPostData(Map<String, dynamic> data) {
    itemType.value = data['title'] ?? "";

    // For subtype/category, use wasteType if recycling, else use type
    if (data['type'] == 'recycling' && data['wasteType'] != null && (data['wasteType'] as List).isNotEmpty) {
      itemSubtype.value = (data['wasteType'] as List).join(', ');
    } else {
      itemSubtype.value = data['type']?.toString().capitalizeFirst ?? "";
    }

    itemPrice.value = (data['price'] ?? 0).toDouble();
    size.value = data['size']?.toString().capitalizeFirst ?? "";

    // Date/Time
    final dt = data['dateTimeSlot'];
    if (dt != null) {
      final scheduledDate = dt['scheduledDate'] ?? "";
      final scheduledTime = dt['scheduledTime'] ?? "";
      preferredPickupTime.value = scheduledDate != "" ? "$scheduledDate, $scheduledTime" : dt['slotType'] ?? "";
    }

    // Images
    if (data['photos'] != null) {
      images.value = (data['photos'] as List).map((path) => ApiUrl.buildImageUrl(path.toString())).toList();
    }

    // Pickup
    final pickup = data['pickup'];
    if (pickup != null) {
      pickupAddress.value = pickup['address']?['text'] ?? "";
      pickupFeatures.value = _buildFeatures(pickup['placement']);
      final coords = pickup['address']?['coordinates'];
      pickupLat = (coords?['lat'] as num?)?.toDouble();
      pickupLng = (coords?['lng'] as num?)?.toDouble();
    }

    // Delivery
    final dropoff = data['dropoff'];
    if (dropoff != null) {
      deliveryAddress.value = dropoff['address']?['text'] ?? "";
      deliveryFeatures.value = _buildFeatures(dropoff['placement']);
      final coords = dropoff['address']?['coordinates'];
      dropoffLat = (coords?['lat'] as num?)?.toDouble();
      dropoffLng = (coords?['lng'] as num?)?.toDouble();
    } else {
      deliveryAddress.value = "";
      deliveryFeatures.value = [];
      dropoffLat = null;
      dropoffLng = null;
    }

    // Advertiser
    final user = data['user'];
    if (user != null) {
      advertiserName.value = user['name'] ?? "";
      advertiserRating.value = (user['ratingAsAdvertiser'] ?? 0).toDouble();
      if (user['avatar'] != null) {
        advertiserImage.value = ApiUrl.buildImageUrl(user['avatar'].toString());
      }
    }

    // Published time (relative) - for now just show formatted createdAt
    if (data['createdAt'] != null) {
      publishedTime.value = data['createdAt'].toString().substring(0, 10);
    }

    // Status + real-time timeline
    taskStatus.value = taskStatusFromString(data['status']?.toString());
    timelineSteps.value = _buildTimelineSteps(data['timeline'] as List?);
  }

  // Canonical 4-step flow the backend's `timeline` array fills in as the
  // task progresses (see PATCH /driver/tasks/:id/status) — steps not
  // reached yet just show as upcoming/pending with a generic subtitle.
  List<TimelineStepDisplay> _buildTimelineSteps(List<dynamic>? rawTimeline) {
    final defaults = [
      (1, AppStrings.requestConfirmation.tr, AppStrings.wePickUpYourProductSoon.tr),
      (2, AppStrings.pickup.tr, AppStrings.parcelHasBeenPickedUp.tr),
      (3, AppStrings.inTransit.tr, AppStrings.onTheWaySoonDelivered.tr),
      (4, AppStrings.delivered.tr, AppStrings.parcelHasBeenShipped.tr),
    ];

    final byStep = <int, Map<String, dynamic>>{};
    for (final entry in rawTimeline ?? const []) {
      if (entry is Map) {
        final step = (entry['step'] as num?)?.toInt();
        if (step != null) byStep[step] = Map<String, dynamic>.from(entry);
      }
    }

    return defaults.map((d) {
      final (step, defaultTitle, defaultSubtitle) = d;
      final actual = byStep[step];
      return TimelineStepDisplay(
        step: step,
        title: defaultTitle,
        subtitle: actual?['note']?.toString() ?? defaultSubtitle,
        isCompleted: actual != null,
        timestamp: actual?['timestamp']?.toString(),
      );
    }).toList();
  }

  List<String> _buildFeatures(Map<String, dynamic>? placement) {
    if (placement == null) return [];
    List<String> list = [];
    if (placement['placement'] == 'inside') list.add(AppStrings.insideTheHouse.tr);
    if (placement['needToMeet'] == true) list.add(AppStrings.needToMeet.tr);
    if (placement['canHelpCarry'] == true) list.add(AppStrings.canHelpCarryAtDropOff.tr);
    if (placement['fitsInElevator'] == true) list.add(AppStrings.fitsInTheElevator.tr);
    return list;
  }

  void onOpenPickupMap() => _openRouteMap();

  void onOpenDeliveryMap() => _openRouteMap();

  void _openRouteMap() {
    if (pickupLat == null || pickupLng == null) {
      AppSnackBar.info("This job doesn't have a pickup location to show yet.");
      return;
    }
    // Recycling posts only have a pickup — no drop-off at all — so only
    // include it when it's actually there.
    Get.toNamed(RoutePath.routeMap, arguments: {
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'pickupAddress': pickupAddress.value,
      if (dropoffLat != null && dropoffLng != null) ...{
        'dropoffLat': dropoffLat,
        'dropoffLng': dropoffLng,
        'dropoffAddress': deliveryAddress.value,
      },
    });
  }

  void onShare() {
    AppShare.shareApp();
  }

  void onReportAd() {
    // TODO: Report ad
  }



}
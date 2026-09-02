import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/widget/app_confirmation_alert.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';

import '../../../../helper/tost_message/show_snackbar.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_alert.dart';
import '../model/UserPostDetailsModel.dart';

class StatusDetailsController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // ── State ─────────────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // ── Item Info ─────────────────────────────────────────────────────────────
  RxString postId = "".obs;
  RxString itemType = "".obs;
  RxString itemSubtype = "".obs;
  RxString itemDate = "".obs;
  RxString trackingNumber = "".obs;
  RxString imagePath = "".obs;
  RxString status = "pending".obs; // "pending", "active", "completed"

  // ── Route (for the "Open Map" / "Live Tracking" route view) ───────────────
  RxString pickupAddress = "".obs;
  RxString dropoffAddress = "".obs;
  double? pickupLat;
  double? pickupLng;
  double? dropoffLat;
  double? dropoffLng;

  // ── Driver Info ───────────────────────────────────────────────────────────
  RxString driverName = "".obs;
  RxString driverPhone = "".obs;
  RxString driverImage = "".obs;
  RxDouble driverRating = 0.0.obs;
  RxBool showAcceptButton = false.obs;
  RxString driverId = "".obs; // driver's _id used as receiverId for chat

  // Optional: List of offers/bids for pending status
  RxList<JobRequests> jobRequests = <JobRequests>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      final String? id = args['id'];

      // Temporary mapping from arguments to show something while loading
      postId.value = id ?? "";
      itemType.value = args['itemType'] ?? "";
      itemSubtype.value = args['itemSubtype'] ?? "";
      status.value = args['status'] ?? "pending";

      if (id != null) {
        fetchStatusDetails(id);
      }
    }
  }

  Future<void> fetchStatusDetails(String id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiClient.get(
        url: ApiUrl.getPostDetails(id),
        isToken: true,
      );

      if (response.statusCode == 200) {
        final data = response.body['data'];
        _mapPostData(data);
      } else {
        errorMessage.value =
            response.statusText ?? "Failed to load status details";
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }

  void _mapPostData(Map<String, dynamic> data) {
    postId.value = data['_id'] ?? "";
    itemType.value = data['title'] ?? "";

    if (data['type'] == 'recycling' &&
        data['wasteType'] != null &&
        (data['wasteType'] as List).isNotEmpty) {
      itemSubtype.value = (data['wasteType'] as List).join(', ');
    } else {
      itemSubtype.value = data['type']?.toString().capitalizeFirst ?? "";
    }

    // jobId is the real backend reference number; older posts (created
    // before it existed) don't have one, so fall back to a truncated _id.
    final jobId = data['jobId']?.toString();
    trackingNumber.value = (jobId != null && jobId.isNotEmpty)
        ? jobId
        : (data['_id']?.toString().substring(0, 10).toUpperCase() ?? "");
    status.value = data['status'] ?? "pending";

    // Date
    final dt = data['dateTimeSlot'];
    if (dt != null) {
      itemDate.value =
          dt['scheduledDate'] ??
          data['createdAt']?.toString().substring(0, 10) ??
          "";
    } else {
      itemDate.value = data['createdAt']?.toString().substring(0, 10) ?? "";
    }

    // Image
    if (data['photos'] != null && (data['photos'] as List).isNotEmpty) {
      imagePath.value = ApiUrl.buildImageUrl(data['photos'][0].toString());
    }

    // Pickup / drop-off (for the route map)
    final pickup = data['pickup'];
    if (pickup != null) {
      pickupAddress.value = pickup['address']?['text'] ?? "";
      final coords = pickup['address']?['coordinates'];
      pickupLat = (coords?['lat'] as num?)?.toDouble();
      pickupLng = (coords?['lng'] as num?)?.toDouble();
    }
    final dropoff = data['dropoff'];
    if (dropoff != null) {
      dropoffAddress.value = dropoff['address']?['text'] ?? "";
      final coords = dropoff['address']?['coordinates'];
      dropoffLat = (coords?['lat'] as num?)?.toDouble();
      dropoffLng = (coords?['lng'] as num?)?.toDouble();
    } else {
      dropoffAddress.value = "";
      dropoffLat = null;
      dropoffLng = null;
    }

    // Driver
    final assignedDriver = data['assignedDriver'];
    if (assignedDriver != null) {
      driverId.value = assignedDriver['_id'] ?? "";
      driverName.value = assignedDriver['name'] ?? "";
      // phoneNumber can be null from API
      driverPhone.value = assignedDriver['phoneNumber']?.toString() ?? "";

      // Avatar
      if (assignedDriver['avatar'] != null) {
        driverImage.value = ApiUrl.buildImageUrl(
          assignedDriver['avatar'].toString(),
        );
      } else {
        driverImage.value = "";
      }

      // Rating: active status has it under driverProfile.averageRating
      // pending jobRequest driver has it directly as rating
      final driverProfile = assignedDriver['driverProfile'];
      if (driverProfile != null && driverProfile['averageRating'] != null) {
        driverRating.value = (driverProfile['averageRating'] as num).toDouble();
      } else {
        driverRating.value = (assignedDriver['rating'] ?? 0.0).toDouble();
      }

      showAcceptButton.value = false;
    } else {
      driverId.value = "";
      showAcceptButton.value = status.value == 'pending';
    }

    // Job Requests
    if (data['jobRequests'] != null) {
      jobRequests.value = (data['jobRequests'] as List)
          .map((e) => JobRequests.fromJson(e))
          .toList();
    } else {
      jobRequests.clear();
    }
  }

  void onLiveTrackingPressed() {
    if (pickupLat == null || pickupLng == null) {
      AppSnackBar.info("This job doesn't have a pickup location to show yet.");
      return;
    }
    // Recycling posts only have a pickup — no drop-off at all — so only
    // include it when it's actually there.
    Get.toNamed(
      RoutePath.routeMap,
      arguments: {
        'pickupLat': pickupLat,
        'pickupLng': pickupLng,
        'pickupAddress': pickupAddress.value,
        if (dropoffLat != null && dropoffLng != null) ...{
          'dropoffLat': dropoffLat,
          'dropoffLng': dropoffLng,
          'dropoffAddress': dropoffAddress.value,
        },
      },
    );
  }

  void onRateServicePressed() {
    AppAlerts.deliveryReview(
      onSubmit: (rating, feedback) async {
        try {
          isLoading.value = true;
          final response = await _apiClient.post(
            url: ApiUrl.userPostReview,
            body: {
              "postId": postId.value,
              "rating": rating.toInt().toString(),
              "comment": feedback,
            },
            isToken: true,
          );

          if (response.statusCode == 201 || response.statusCode == 200) {
            AppSnackBar.success(
              response.body['message'] ?? "Thank you for your feedback!",
            );
          } else {
            AppSnackBar.fail(
              response.body['message'] ?? "Failed to submit review",
            );
          }
        } catch (e) {
          AppSnackBar.fail("An error occurred: $e");
        } finally {
          isLoading.value = false;
        }
      },
    );
  }

  void onDeletePressed() {
    AppAlerts.deleteAd(
      onYes: () async {
        if (postId.value.isEmpty) return;
        try {
          isLoading.value = true;
          final response = await _apiClient.patch(
            url: ApiUrl.cancelJobPost(postId.value),
            isToken: true,
          );
          if (response.statusCode == 200 || response.statusCode == 201) {
            // Navigate back *before* the snackbar — Get.snackbar and
            // Get.back() both drive GetX's overlay/route stack, and firing
            // them together races the snackbar's own transition, silently
            // swallowing the pop. The snackbar still shows fine on
            // whichever screen we land back on.
            Get.back(); // the post is gone — leave its status details
            AppSnackBar.success(
              response.body['message'] ?? "Post cancelled successfully",
            );
          } else {
            AppSnackBar.fail(
              response.body['message'] ?? "Failed to cancel post",
            );
          }
        } catch (e) {
          AppSnackBar.fail("An error occurred: $e");
        } finally {
          isLoading.value = false;
        }
      },
    );
  }

  void onReschedulePressed() {
    Get.toNamed(RoutePath.pickupDateTime);
  }

  /// Call POST /chat/post-chat with the given [receiverId].
  /// If [receiverId] is omitted, falls back to [driverId].
  Future<void> onMessagePressed({String? receiverId}) async {
    if (status.value == 'completed') {
      AppSnackBar.info("Chat is disabled for completed orders.");
      return;
    }

    final targetReceiverId = receiverId ?? driverId.value;
    if (targetReceiverId.isEmpty) {
      AppSnackBar.fail("Driver information not found.");
      return;
    }

    try {
      isLoading.value = true;
      final response = await _apiClient.post(
        url: ApiUrl.chatPost,
        body: {"receiverId": targetReceiverId},
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final chatData = response.body['data'];
        final chatId = chatData['_id'] ?? '';
        Get.toNamed(
          RoutePath.chat,
          arguments: {
            'chatId': chatId,
            'receiverId': targetReceiverId,
            'driverName': driverName.value,
            'driverImage': driverImage.value,
            'status': status.value,
          },
        );
      } else {
        AppSnackBar.fail(
          response.body['message'] ?? "Failed to initiate chat.",
        );
      }
    } catch (e) {
      AppSnackBar.fail("An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onAcceptPressed(BuildContext context, String requestId) async {
    try {
      isLoading.value = true;
      final response = await _apiClient.patch(
        url: ApiUrl.acceptRequest(postId.value, requestId),
        isToken: true,
      );
      if (response.statusCode == 200) {
        AppSuccessAlert.show(
          context: context,
          message: response.body['message'] ?? "Request Successfully Accepted",
        );
        // After acceptance, status might change to active
        status.value = "active";
        showAcceptButton.value = false;
        // Refresh details to get the assigned driver info
        fetchStatusDetails(postId.value);
      } else {
        AppSnackBar.fail(
          response.body['message'] ?? "Failed to accept request",
        );
      }
    } catch (e) {
      AppSnackBar.fail("An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

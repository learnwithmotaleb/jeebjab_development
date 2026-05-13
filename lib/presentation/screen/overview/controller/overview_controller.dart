import 'dart:io';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:jeebjab/presentation/screen/capture_info/controller/capture_info_controller.dart';
import 'package:jeebjab/presentation/screen/create_post/controller/create_post_controller.dart';
import 'package:jeebjab/presentation/screen/drop_off_floor/controller/drop_off_floor_controller.dart';
import 'package:jeebjab/presentation/screen/i_will_pay/controller/i_will_pay_controller.dart';
import 'package:jeebjab/presentation/screen/pickup_address/controller/pickup_address_controller.dart';
import 'package:jeebjab/presentation/screen/pickup_date_time/controller/pickup_datetime_controller.dart';
import 'package:jeebjab/presentation/screen/pickup_floor/controller/pickup_floor_controller.dart';
import 'package:jeebjab/presentation/screen/placement_drop_off/controller/placement_drop_off_controller.dart';
import 'package:jeebjab/presentation/screen/placement_pickup/controller/placement_pickup_controller.dart';
import 'package:jeebjab/presentation/screen/set_drop_off_address/controller/set_drop_of_address_controller.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../helper/tost_message/show_snackbar.dart';
import '../../add_card/controller/add_card_controller.dart';
import '../../west_type/controller/west_type_controller.dart';

class OverviewController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<File> capturedImages = <File>[].obs;

  // ── Service Info ──────────────────────────────────────────────────────────
  RxString serviceType = AppStrings.move.obs;
  RxString serviceTitle = "Move Bike To Another City".obs;
  RxString description = AppStrings.empty.obs;
  RxString sizeOfProduct = AppStrings.medium.obs;

  // ── Pickup Info ───────────────────────────────────────────────────────────
  RxString pickupAddress = "Dubai Downtown".obs;
  RxString pickupPlacement = AppStrings.insideMeetCanHelp.obs;
  RxString pickupFloor = "6 / A 95".obs;

  // ── Drop Info ─────────────────────────────────────────────────────────────
  RxString dropAddress = "Dubai Downtown".obs;
  RxString dropPlacement = AppStrings.outsideNoMeet.obs;
  RxString dropFloor = "6 / A 95".obs;

  // ── Date & Price ──────────────────────────────────────────────────────────
  RxString dateTime = AppStrings.anytime.obs;
  RxString wasteType = AppStrings.empty.obs;
  RxString wasteCount = "0 Types".obs;
  RxString paymentCard = AppStrings.empty.obs;
  RxString price = "450 SAR".obs;

  // ── Acknowledgement (Main Checkbox) ───────────────────────────────────────
  RxBool acknowledgePickup = false.obs;

  // ── Init ──────────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    try {
      final createPostCtrl = Get.find<CreatePostController>();
      final captureInfoCtrl = Get.find<CaptureInfoController>();
      final dateTimeCtrl = Get.find<PickupDatetimeController>();
      final pickupAddrCtrl = Get.find<PickupAddressController>();
      final placementPickupCtrl = Get.find<PlacementPickupController>();
      final pickupFloorCtrl = Get.find<PickupFloorController>();
      final iWillPayCtrl = Get.find<IWillPayController>();
      
      final wasteTypeCtrl = Get.isRegistered<WestTypeController>() ? Get.find<WestTypeController>() : null;
      final addCardCtrl = Get.isRegistered<AddCardController>() ? Get.find<AddCardController>() : null;
      
      final dropAddrCtrl = Get.isRegistered<SetDropOfAddressController>() ? Get.find<SetDropOfAddressController>() : null;
      final placementDropCtrl = Get.isRegistered<PlacementDropOffController>() ? Get.find<PlacementDropOffController>() : null;
      final dropFloorCtrl = Get.isRegistered<DropOffFloorController>() ? Get.find<DropOffFloorController>() : null;

      // Load Images
      capturedImages.assignAll(captureInfoCtrl.capturedImages);

      serviceType.value = createPostCtrl.selectedCategory.value?.title ?? AppStrings.move;
      serviceTitle.value = captureInfoCtrl.nameController.text;
      description.value = captureInfoCtrl.descriptionController.text.isEmpty ? AppStrings.empty : captureInfoCtrl.descriptionController.text;
      sizeOfProduct.value = captureInfoCtrl.selectedSize.value;

      pickupAddress.value = pickupAddrCtrl.addressController.text;
      pickupPlacement.value = "${placementPickupCtrl.selectedPlacement.value}, ${placementPickupCtrl.selectedAdditional.join(', ')}";
      pickupFloor.value = "${pickupFloorCtrl.floorController.text} / ${pickupFloorCtrl.doorCodeController.text}";

      if (dropAddrCtrl != null) {
        dropAddress.value = dropAddrCtrl.addressController.text;
      } else {
        dropAddress.value = AppStrings.empty;
      }
      
      if (placementDropCtrl != null) {
        dropPlacement.value = "${placementDropCtrl.selectedPlacement.value}, ${placementDropCtrl.selectedAdditional.join(', ')}";
      } else {
        dropPlacement.value = AppStrings.empty;
      }
      
      if (dropFloorCtrl != null) {
        dropFloor.value = "${dropFloorCtrl.floorController.text} / ${dropFloorCtrl.doorCodeController.text}";
      } else {
        dropFloor.value = AppStrings.empty;
      }

      if (dateTimeCtrl.selectedType.value == PickupType.anytime) {
        dateTime.value = AppStrings.anytime.tr;
      } else {
        dateTime.value = dateTimeCtrl.selectedType.value.name.capitalizeFirst!;
      }
      
      if (dateTimeCtrl.selectedSlot.value.isNotEmpty) {
        dateTime.value += " (${dateTimeCtrl.selectedSlot.value})";
      }

      if (wasteTypeCtrl != null) {
        wasteType.value = wasteTypeCtrl.selectedItems.join(', ');
        wasteCount.value = "${wasteTypeCtrl.selectedItems.length} ${AppStrings.types.tr}";
      }
      if (wasteType.value.isEmpty) {
        wasteType.value = AppStrings.empty.tr;
        wasteCount.value = "0 ${AppStrings.types.tr}";
      }

      if (addCardCtrl != null) {
        paymentCard.value = addCardCtrl.cardNumberController.text;
      }
      if (paymentCard.value.isEmpty) {
        paymentCard.value = AppStrings.empty;
      }
      
      price.value = "${iWillPayCtrl.price.value} ${AppStrings.currency}";
    } catch (e) {
      log.e("Error loading overview data: $e");
    }
  }

  // ── Publish حالت ──────────────────────────────────────────────────────────
  /// ✅ Current logic (based on your UI)
  bool get canPublish => acknowledgePickup.value && !isLoading.value;

  // ── Toggle Method (Clean Code) ────────────────────────────────────────────
  void toggleAcknowledge(bool value) {
    acknowledgePickup.value = value;
  }

  // ── Publish Post Logic ────────────────────────────────────────────────────
  Future<void> publishPost() async {
    if (!canPublish) {
      if (!acknowledgePickup.value) {
        AppSnackBar.fail(
            "Please acknowledge the terms before publishing.",
            title: "Required");
      }
      return;
    }

    try {
      isLoading.value = true;

      // ── Find All Controllers ──────────────────────────────────────────────
      // Note: We use Get.find and assume they are still in memory
      final createPostCtrl = Get.find<CreatePostController>();
      final captureInfoCtrl = Get.find<CaptureInfoController>();
      final dateTimeCtrl = Get.find<PickupDatetimeController>();
      final pickupAddrCtrl = Get.find<PickupAddressController>();
      final placementPickupCtrl = Get.find<PlacementPickupController>();
      final pickupFloorCtrl = Get.find<PickupFloorController>();
      final iWillPayCtrl = Get.find<IWillPayController>();
      
      final wasteTypeCtrl = Get.isRegistered<WestTypeController>() ? Get.find<WestTypeController>() : null;
      
      final dropAddrCtrl = Get.isRegistered<SetDropOfAddressController>() ? Get.find<SetDropOfAddressController>() : null;
      final placementDropCtrl = Get.isRegistered<PlacementDropOffController>() ? Get.find<PlacementDropOffController>() : null;
      final dropFloorCtrl = Get.isRegistered<DropOffFloorController>() ? Get.find<DropOffFloorController>() : null;

      // ── Prepare Data Map ──────────────────────────────────────────────────
      final Map<String, dynamic> postData = {
        "type": createPostCtrl.selectedCategory.value?.type.name ?? "move",
        "title": captureInfoCtrl.nameController.text,
        "description": captureInfoCtrl.descriptionController.text,
        "size": captureInfoCtrl.selectedSize.value.toLowerCase(),
        "wasteType": wasteTypeCtrl?.selectedItems.join(', ') ?? "",
        "pickup": {
          "address": {
            "text": pickupAddrCtrl.addressController.text,
            "coordinates": {"lat": 25.1972, "lng": 55.2744} // Placeholder: Should be from Map
          },
          "placement": {
            "placement": placementPickupCtrl.selectedPlacement.value
                    .toLowerCase()
                    .contains("inside")
                ? "inside"
                : "outside",
            "needToMeet": placementPickupCtrl.selectedAdditional
                .contains(AppStrings.needToMeet),
            "canHelpCarry": placementPickupCtrl.selectedAdditional
                .contains(AppStrings.canHelpCarry),
            "floor": pickupFloorCtrl.floorController.text,
            "doorCode": pickupFloorCtrl.doorCodeController.text,
            "fitsInElevator": pickupFloorCtrl.fitsInElevator.value,
            "otherInfo": pickupFloorCtrl.otherInfoController.text,
          }
        },
        "dropoff": dropAddrCtrl == null ? null : {
          "address": {
            "text": dropAddrCtrl.addressController.text,
            "coordinates": {"lat": 24.4539, "lng": 54.3773} // Placeholder: Should be from Map
          },
          "placement": {
            "placement": placementDropCtrl?.selectedPlacement.value
                    .toLowerCase()
                    .contains("inside") ?? false
                ? "inside"
                : "outside",
            "needToMeet": placementDropCtrl?.selectedAdditional
                .contains(AppStrings.needToMeet) ?? false,
            "canHelpCarry": placementDropCtrl?.selectedAdditional
                .contains(AppStrings.canHelpCarry) ?? false,
            "floor": dropFloorCtrl?.floorController.text ?? "",
            "doorCode": dropFloorCtrl?.doorCodeController.text ?? "",
            "fitsInElevator": dropFloorCtrl?.fitsInElevator.value ?? false,
            "otherInfo": dropFloorCtrl?.otherInfoController.text ?? "",
          }
        },
        "dateTimeSlot": {
          "slotType": dateTimeCtrl.selectedType.value.name, // 'regular', 'priority', or 'scheduled'
          // Backend expects the literal string 'today' or 'tomorrow', not a formatted date
          "scheduledDate": dateTimeCtrl.selectedType.value == PickupType.scheduled
              ? dateTimeCtrl.selectedSlot.value.split('_').first // extracts 'today' or 'tomorrow'
              : null,
          "scheduledTime": dateTimeCtrl.selectedType.value == PickupType.scheduled
              ? dateTimeCtrl.selectedSlot.value.split('_').last  // extracts e.g. '01:00-01:30'
              : null,
        },
        "price": iWillPayCtrl.price.value,
        "campaignCode": null,
        "acknowledged": acknowledgePickup.value
      };

      // ── Prepare Images ────────────────────────────────────────────────────
      final List<MultipartFileData> imageFiles = captureInfoCtrl.capturedImages
          .map((file) => MultipartFileData(key: 'post_image', path: file.path))
          .toList();

      // ── API Call ──────────────────────────────────────────────────────────
      final apiClient = ApiClient();
      final response = await apiClient.postMultipart(
        url: ApiUrl.createPost,
        fields: {"data": jsonEncode(postData)},
        files: imageFiles,
        isToken: true,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        AppSnackBar.success(
          "Post created successfully",
          title: "Success",
        );
        Get.offAllNamed(RoutePath.bottomNav, arguments: 3);
      } else {
        String errorMsg = "Something went wrong";
        if (response.body is Map) {
          if (response.body['message'] != null) {
            errorMsg = response.body['message'];
          } else if (response.body['errorMessages'] != null && response.body['errorMessages'] is List && response.body['errorMessages'].isNotEmpty) {
            errorMsg = response.body['errorMessages'][0]['message'] ?? errorMsg;
          }
        }
        AppSnackBar.fail(
          errorMsg,
          title: "Error",
        );
      }
    } catch (e) {
      log.e("Error publishing post: $e");
      AppSnackBar.fail(
        "Failed to publish post: $e",
        title: "Error",
      );
    } finally {
      isLoading.value = false;
    }
  }
}

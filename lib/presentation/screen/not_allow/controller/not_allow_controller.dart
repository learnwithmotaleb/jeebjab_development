import 'package:get/get.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class NotAllowedItem {
  final String title;
  final String description;

  NotAllowedItem({required this.title, required this.description});
}

class NotAllowController extends GetxController {
  final List<NotAllowedItem> items = [
    NotAllowedItem(
      title: AppStrings.foodWaste.tr,
      description:
      'It is not allowed to advertise for help with food waste disposal, as it cannot be handled by private individuals.',
    ),
    NotAllowedItem(
      title: AppStrings.asbestos.tr,
      description:
      'It is not allowed to advertise for help with asbestos in JiebJab. Asbestos is very hazardous to health and is not suitable to be handled by private individuals.',
    ),
    NotAllowedItem(
      title: AppStrings.otherHazardousWaste.tr,
      description:
      'It is not allowed to advertise hazardous waste other than that which is selectable in the app. The reason for this is to avoid exposing the private individuals that helps you through the app harmful substances.',
    ),
    NotAllowedItem(
      title: AppStrings.constructionWaste.tr,
      description:
      'It is not allowed to advertise a mix of construction and demolition waste.',
    ),
  ];

  void onContinue() {
    Get.back();
    // TODO: Get.toNamed(RoutePath.next);
  }
}
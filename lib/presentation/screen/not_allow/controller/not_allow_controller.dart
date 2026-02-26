import 'package:get/get.dart';

class NotAllowedItem {
  final String title;
  final String description;

  NotAllowedItem({required this.title, required this.description});
}

class NotAllowController extends GetxController {
  final List<NotAllowedItem> items = [
    NotAllowedItem(
      title: 'Food Waste',
      description:
      'It is not allowed to advertise for help with food waste disposal, as it cannot be handled by private individuals.',
    ),
    NotAllowedItem(
      title: 'Asbestos',
      description:
      'It is not allowed to advertise for help with asbestos in JiebJab. Asbestos is very hazardous to health and is not suitable to be handled by private individuals.',
    ),
    NotAllowedItem(
      title: 'Other Hazardous Waste',
      description:
      'It is not allowed to advertise hazardous waste other than that which is selectable in the app. The reason for this is to avoid exposing the private individuals that helps you through the app harmful substances.',
    ),
    NotAllowedItem(
      title: 'Construction Waste',
      description:
      'It is not allowed to advertise a mix of construction and demolition waste.',
    ),
  ];

  void onContinue() {
    Get.back();
    // TODO: Get.toNamed(RoutePath.next);
  }
}
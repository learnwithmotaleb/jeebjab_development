import 'package:get/get.dart';

enum DriverType { none, independent, company }

class BecomeDriverController extends GetxController {
  final Rx<DriverType> selectedType = DriverType.none.obs;

  void selectType(DriverType type) {
    // tap same → deselect, tap different → select
    if (selectedType.value == type) {
      selectedType.value = DriverType.none;
    } else {
      selectedType.value = type;
    }
  }

  bool get isValid => selectedType.value != DriverType.none;

  void onContinue() {
    if (!isValid) return;
    if (selectedType.value == DriverType.independent) {
      // TODO: Get.toNamed(RoutePath.independentDriverForm);
    } else {
      // TODO: Get.toNamed(RoutePath.companyDriverForm);
    }
  }
}
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

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

  String get selectedTypeString {
    switch (selectedType.value) {
      case DriverType.independent:
        return "independent";
      case DriverType.company:
        return "company";
      default:
        return "";
    }
  }

  void onContinue() {
    // if (!isValid) return;
    // if (selectedType.value == DriverType.independent) {
    //  Get.toNamed(RoutePath.vehicleType);
    // } else {
    //   Get.toNamed(RoutePath.selectCompany);
    //
    // }

    Get.toNamed(RoutePath.driverBottomNav);
  }
}
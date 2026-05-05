import 'package:get/get.dart';
import '../../../../../utils/static_strings/static_strings.dart';

class ChooseVehicleTypeController extends GetxController {
  final List<String> options = [
    AppStrings.car,
    AppStrings.van,
    AppStrings.pickup,
    AppStrings.truck,
  ];

  final RxInt selectedIndex = 0.obs;

  void selectOption(int index) {
    selectedIndex.value = index;
  }

  String get selectedVehicleType => options[selectedIndex.value];
}
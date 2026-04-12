import 'package:get/get.dart';

class DriverBottomNavController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is int) {
      selectedIndex.value = Get.arguments;
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
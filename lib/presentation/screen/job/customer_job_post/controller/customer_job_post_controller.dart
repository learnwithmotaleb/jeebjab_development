import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

class CustomerJobPostController extends GetxController {
  void onBecomeDriver() {
    Get.toNamed(RoutePath.becomeDriver);
  }
}
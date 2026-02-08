import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

import '../../../../helper/role_controller/role_controller.dart';

enum UserRole { customer, driver }

class SelectRoleController extends GetxController {
  var selectedRole = UserRole.customer.obs;

  final _role = RoleController();


  Future<void> selectCustomer() async {
    selectedRole.value = UserRole.customer;
    await _role.setCustomer().then((value){
      print("Role Customer Set successfully");
      Get.toNamed(RoutePath.signup);
    });
  }

  void selectDriver()async{
    selectedRole.value = UserRole.driver;
    await _role.setDriver().then((value){
      print("Role Driver Set successfully");
      Get.toNamed(RoutePath.signup);
    });

  }
}

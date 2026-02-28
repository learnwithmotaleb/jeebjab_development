import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../core/enums/app_role.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../helper/local_db/local_db.dart';

class SelectRoleController extends GetxController {

  var selectedRole = Rx<AppRole?>(null);

  Future<void> selectRole(AppRole role) async {

    selectedRole.value = role;

    await SharePrefsHelper.saveRole(role);

    print("Role ${role.name} saved");

    Get.toNamed(RoutePath.signup);
  }
}
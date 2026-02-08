import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/presentation/screen/auth/Customer_Verification/controller/customer_verification_controller.dart';
import 'package:jeebjab/presentation/screen/auth/compelete_varification/controller/complete_varification_controller.dart';
import 'package:jeebjab/presentation/screen/auth/compelete_varification/screen/complete_varification_screen.dart';
import 'package:jeebjab/presentation/screen/auth/signup/controller/signup_controller.dart';
import 'package:jeebjab/presentation/screen/auth/signup/screen/signup_screen.dart';
import 'package:jeebjab/presentation/screen/role/controller/select_role_controller.dart';

import '../../presentation/screen/auth/Customer_Verification/screen/customer_verification_screen.dart';
import '../../presentation/screen/auth/login/controller/login_controller.dart';
import '../../presentation/screen/auth/login/screen/login_screen.dart';
import '../../presentation/screen/role/screen/select_role_screen.dart';
import '../../presentation/screen/splash/controller/splash_controller.dart';
import '../../presentation/screen/splash/screen/splash_screen.dart';




class AppRouter {
  static final List<GetPage<dynamic>> pages = [

    GetPage(
      name: RoutePath.splash,
      page: () => const SplashScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),

    GetPage(
      name: RoutePath.login,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),

   GetPage(
      name: RoutePath.selectRole,
      page: () => const SelectRoleScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(SelectRoleController());
      }),
    ),

   GetPage(
      name: RoutePath.signup,
      page: () => const SignupScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(SignupController());
      }),
    ),


   GetPage(
      name: RoutePath.customerVerification,
      page: () => const CustomerVerificationScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(CustomerVerificationController());
      }),
    ),

   GetPage(
      name: RoutePath.completeVarification,
      page: () => const CompleteVarificationScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(CompleteVarificationController());
      }),
    ),





  ];
}

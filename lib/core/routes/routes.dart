import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/presentation/screen/auth/Customer_Verification/controller/customer_verification_controller.dart';
import 'package:jeebjab/presentation/screen/auth/company_driver_auth/driver_verification/screen/driver_verification_screen.dart';
import 'package:jeebjab/presentation/screen/auth/company_driver_auth/select_company/screen/select_company_screen.dart';
import 'package:jeebjab/presentation/screen/auth/company_driver_auth/signup_driver/controller/driver_signup_controller.dart';
import 'package:jeebjab/presentation/screen/auth/company_driver_auth/signup_driver/screen/driver_signup_screen.dart';
import 'package:jeebjab/presentation/screen/auth/forget/screen/forget_screen.dart';
import 'package:jeebjab/presentation/screen/auth/license_number/screen/license_number_screen.dart';
import 'package:jeebjab/presentation/screen/auth/reset_password/controller/reset_password_controller.dart';
import 'package:jeebjab/presentation/screen/auth/reset_password/screen/reset_password_screen.dart';
import 'package:jeebjab/presentation/screen/auth/signup/controller/signup_controller.dart';
import 'package:jeebjab/presentation/screen/auth/signup/screen/signup_screen.dart';
import 'package:jeebjab/presentation/screen/auth/upload_document/controller/upload_document_controller.dart';
import 'package:jeebjab/presentation/screen/auth/upload_document/screen/upload_document_screen.dart';
import 'package:jeebjab/presentation/screen/auth/vehicle_information/controller/vehicle_information_controller.dart';
import 'package:jeebjab/presentation/screen/auth/vehicle_information/screen/vehicle_information_screen.dart';
import 'package:jeebjab/presentation/screen/home/controller/home_controller.dart';
import 'package:jeebjab/presentation/screen/home/screen/home_screen.dart';
import 'package:jeebjab/presentation/screen/role/controller/select_role_controller.dart';
import 'package:jeebjab/presentation/screen/welcome_screen/controller/welcome_controller.dart';
import 'package:jeebjab/presentation/screen/welcome_screen/screen/welcome_screen.dart';

import '../../presentation/screen/auth/Customer_Verification/screen/customer_verification_screen.dart';
import '../../presentation/screen/auth/choose_vehicle_type/controller/choose_vehicle_type_controller.dart';
import '../../presentation/screen/auth/choose_vehicle_type/screen/choose_vehicle_type_screen.dart';
import '../../presentation/screen/auth/company_driver_auth/driver_verification/controller/driver_verification_controller.dart';
import '../../presentation/screen/auth/company_driver_auth/select_company/controller/select_company_controller.dart';
import '../../presentation/screen/auth/complete_verification/controller/complete_varification_controller.dart';
import '../../presentation/screen/auth/complete_verification/screen/complete_varification_screen.dart';
import '../../presentation/screen/auth/forget/controller/forget_controller.dart';
import '../../presentation/screen/auth/license_number/controller/license_number_controller.dart';
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


   GetPage(
      name: RoutePath.vehicleType,
      page: () => const ChooseVehicleTypeScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ChooseVehicleTypeController());
      }),
    ),


   GetPage(
      name: RoutePath.vehicleInformation,
      page: () => const VehicleInformationScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(VehicleInformationController());
      }),
    ),



   GetPage(
      name: RoutePath.licenseNumber,
      page: () => const LicenseNumberScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(LicenseNumberController());
      }),
    ),

   GetPage(
      name: RoutePath.uploadDocument,
      page: () => const UploadDocumentScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(UploadDocumentController());
      }),
    ),



   GetPage(
      name: RoutePath.driverSignup,
      page: () => const DriverSignupScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(DriverSignupController());
      }),
    ),

   GetPage(
      name: RoutePath.driverVerification,
      page: () => const DriverVerificationScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(DriverVerificationController());
      }),
    ),


   GetPage(
      name: RoutePath.selectCompany,
      page: () => const SelectCompanyScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(SelectCompanyController());
      }),
    ),



   GetPage(
      name: RoutePath.forget,
      page: () => const ForgetScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ForgetController());
      }),
    ),




   GetPage(
      name: RoutePath.reset,
      page: () => const ResetPasswordScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ResetPasswordController());
      }),
    ),



   GetPage(
      name: RoutePath.welcome,
      page: () => const WelcomeScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(WelcomeController());
      }),
    ),




   GetPage(
      name: RoutePath.home,
      page: () => const HomeScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),





  ];
}

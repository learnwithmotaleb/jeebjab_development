import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/presentation/screen/add_card/controller/add_card_controller.dart';
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
import 'package:jeebjab/presentation/screen/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:jeebjab/presentation/screen/bottom_nav/page/my_post/controller/my_post_controller.dart';
import 'package:jeebjab/presentation/screen/bottom_nav/page/my_post/screen/my_post_screen.dart';
import 'package:jeebjab/presentation/screen/bottom_nav/screen/bottom_nav_screen.dart';
import 'package:jeebjab/presentation/screen/capture_image/controller/capture_image_controller.dart';
import 'package:jeebjab/presentation/screen/capture_image/screen/capture_image_screen.dart';
import 'package:jeebjab/presentation/screen/capture_info/controller/capture_info_controller.dart';
import 'package:jeebjab/presentation/screen/capture_info/screen/capture_info_screen.dart';
import 'package:jeebjab/presentation/screen/chat/controller/chat_controller.dart';
import 'package:jeebjab/presentation/screen/chat/screen/chat_screen.dart';
import 'package:jeebjab/presentation/screen/create_post/controller/create_post_controller.dart';
import 'package:jeebjab/presentation/screen/create_post/screen/create_post_screen.dart';
import 'package:jeebjab/presentation/screen/drop_off_floor/screen/drop_off_floor_screen.dart';
import 'package:jeebjab/presentation/screen/i_will_pay/controller/i_will_pay_controller.dart';
import 'package:jeebjab/presentation/screen/i_will_pay/screen/i_will_pay_screen.dart';
import 'package:jeebjab/presentation/screen/job/category_status/controller/category_status_controller.dart';
import 'package:jeebjab/presentation/screen/job/category_status/screen/category_status_screen.dart';
import 'package:jeebjab/presentation/screen/job/job_post/controller/job_post_controller.dart';
import 'package:jeebjab/presentation/screen/job/job_post/screen/job_post_screen.dart';
import 'package:jeebjab/presentation/screen/not_allow/controller/not_allow_controller.dart';
import 'package:jeebjab/presentation/screen/not_allow/screen/not_allow_screen.dart';

import 'package:jeebjab/presentation/screen/notification/controller/notification_controller.dart';
import 'package:jeebjab/presentation/screen/notification/screen/notification_screen.dart';
import 'package:jeebjab/presentation/screen/notification_detalis/controller/notification_details_controller.dart';
import 'package:jeebjab/presentation/screen/notification_detalis/screen/notification_details_screen.dart';
import 'package:jeebjab/presentation/screen/overview/controller/overview_controller.dart';
import 'package:jeebjab/presentation/screen/overview/screen/overview_screen.dart';
import 'package:jeebjab/presentation/screen/pickup_address/controller/pickup_address_controller.dart';
import 'package:jeebjab/presentation/screen/pickup_date_time/controller/pickup_datetime_controller.dart';
import 'package:jeebjab/presentation/screen/pickup_date_time/screen/pickup_datetime_screen.dart';
import 'package:jeebjab/presentation/screen/pickup_details/controller/pickup_details_controller.dart';
import 'package:jeebjab/presentation/screen/pickup_details/screen/pickup_details_screen.dart';
import 'package:jeebjab/presentation/screen/pickup_floor/controller/pickup_floor_controller.dart';
import 'package:jeebjab/presentation/screen/pickup_floor/screen/pickup_floor_screen.dart';
import 'package:jeebjab/presentation/screen/placement_drop_off/controller/placement_drop_off_controller.dart';
import 'package:jeebjab/presentation/screen/placement_drop_off/screen/placement_drop_off_screen.dart';
import 'package:jeebjab/presentation/screen/placement_pickup/controller/placement_pickup_controller.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/account/controller/account_controller.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/bank_card/controller/bank_card_controller.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/bank_card/screen/bank_card_screen.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/change_password/controller/change_password_controller.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/change_password/screen/change_password_screen.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/driver_profile/controller/driver_profile_controller.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/driver_profile/screen/driver_profile_screen.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/edit_driver_profile/controller/edit_driver_profile_controller.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/edit_driver_profile/screen/edit_driver_profile_screen.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/edit_profile/controller/edit_profile_controller.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/edit_profile/screen/edit_profile_screen.dart';
import 'package:jeebjab/presentation/screen/profile/contact_&_support/controller/contact_and_support_controller.dart';
import 'package:jeebjab/presentation/screen/profile/contact_&_support/screen/contact_and_support_screen.dart';
import 'package:jeebjab/presentation/screen/profile/language/controller/language_controller.dart';
import 'package:jeebjab/presentation/screen/profile/language/screen/language_screen.dart';
import 'package:jeebjab/presentation/screen/profile/privacy_&_policy/controller/privacy_and_policy_controller.dart';
import 'package:jeebjab/presentation/screen/profile/privacy_&_policy/screen/privacy_and_policy_screen.dart';
import 'package:jeebjab/presentation/screen/profile/profile/controller/profile_controller.dart';
import 'package:jeebjab/presentation/screen/profile/profile/screen/profile_screen.dart';
import 'package:jeebjab/presentation/screen/profile/terms_&_condition/controller/terms_and_condition_controller.dart';
import 'package:jeebjab/presentation/screen/profile/terms_&_condition/screen/terms_and_condition_screen.dart';
import 'package:jeebjab/presentation/screen/read_more/controller/read_more_post_controller.dart';
import 'package:jeebjab/presentation/screen/read_more/screen/read_more_post_screen.dart';
import 'package:jeebjab/presentation/screen/review_list/controller/reviews_list_controller.dart';
import 'package:jeebjab/presentation/screen/review_list/screen/reviews_list_screen.dart';
import 'package:jeebjab/presentation/screen/review_profile/controller/review_profile_controller.dart';
import 'package:jeebjab/presentation/screen/review_profile/screen/review_profile_screen.dart';
import 'package:jeebjab/presentation/screen/role/controller/select_role_controller.dart';
import 'package:jeebjab/presentation/screen/set_drop_off_address/controller/set_drop_of_address_controller.dart';
import 'package:jeebjab/presentation/screen/set_drop_off_address/screen/set_drop_of_address_screen.dart';
import 'package:jeebjab/presentation/screen/show_map/controller/show_map_controller.dart';
import 'package:jeebjab/presentation/screen/show_map/screen/show_map_screen.dart';
import 'package:jeebjab/presentation/screen/welcome_screen/controller/welcome_controller.dart';
import 'package:jeebjab/presentation/screen/welcome_screen/screen/welcome_screen.dart';
import 'package:jeebjab/presentation/screen/west_type/controller/west_type_controller.dart';
import 'package:jeebjab/presentation/screen/west_type/screen/west_type_screen.dart';

import '../../presentation/screen/add_card/screen/add_card_screen.dart';
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
import '../../presentation/screen/bottom_nav/page/home/controller/home_controller.dart';
import '../../presentation/screen/bottom_nav/page/home/screen/home_screen.dart';
import '../../presentation/screen/drop_off_floor/controller/drop_off_floor_controller.dart';
import '../../presentation/screen/pickup_address/screen/pickup_address_screen.dart';
import '../../presentation/screen/placement_pickup/screen/placement_pickup_screen.dart';
import '../../presentation/screen/profile/account_settings/account/screen/account_screen.dart';
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



   GetPage(
      name: RoutePath.readMore,
      page: () => const ReadMoreScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ReadMoreController());
      }),
    ),

   GetPage(
      name: RoutePath.notification,
      page: () => const NotificationScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(NotificationController());
      }),
    ),



   GetPage(
      name: RoutePath.notificationDetails,
      page: () =>  NotificationDetailsScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(NotificationDetailsController());
      }),
    ),



   GetPage(
      name: RoutePath.chat,
      page: () =>  ChatScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ChatController());
      }),
    ),

   GetPage(
      name: RoutePath.showMap,
      page: () =>  ShowMapScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ShowMapController());
      }),
    ),



   GetPage(
      name: RoutePath.bottomNav,
      page: () =>  BottomNavScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(BottomNavController());
      }),
    ),

   GetPage(
      name: RoutePath.myPost,
      page: () =>  MyPostScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(MyPostController());
      }),
    ),

    GetPage(
      name: RoutePath.pickUpDetails,
      page: () =>  PickupDetailsScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(PickupDetailsController());
      }),
    ),

    GetPage(
      name: RoutePath.reviewProfile,
      page: () =>  ReviewProfileScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ReviewProfileController());
      }),
    ),

    GetPage(
      name: RoutePath.reviewList,
      page: () =>  ReviewsListScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ReviewsListController());
      }),
    ),


    GetPage(
      name: RoutePath.createPost,
      page: () =>  CreatePostScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(CreatePostController());
      }),
    ),



    GetPage(
      name: RoutePath.captureImage,
      page: () =>  CaptureImageScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(CaptureImageController());
      }),
    ),


    GetPage(
      name: RoutePath.captureInfo,
      page: () =>  CaptureInfoScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(CaptureInfoController());
      }),
    ),


    GetPage(
      name: RoutePath.pickupDateTime,
      page: () =>  PickupDatetimeScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(PickupDatetimeController());
      }),
    ),


    GetPage(
      name: RoutePath.pickupAddress,
      page: () =>  PickupAddressScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(PickupAddressController());
      }),
    ),


    GetPage(
      name: RoutePath.placementPickup,
      page: () =>  PlacementPickupScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(PlacementPickupController());
      }),
    ),


    GetPage(
      name: RoutePath.pickupFloor,
      page: () =>  PickupFloorScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(PickupFloorController());
      }),
    ),


    GetPage(
      name: RoutePath.setDropOffAddress,
      page: () =>  SetDropOfAddressScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(SetDropOfAddressController());
      }),
    ),


    GetPage(
      name: RoutePath.placementDropOff,
      page: () =>  PlacementDropOffScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(PlacementDropOffController());
      }),
    ),

    GetPage(
      name: RoutePath.dropOffFloor,
      page: () =>  DropOffFloorScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(DropOffFloorController());
      }),
    ),


    GetPage(
      name: RoutePath.iWillPay,
      page: () =>  IWillPayScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(IWillPayController());
      }),
    ),


    GetPage(
      name: RoutePath.overview,
      page: () =>  OverviewScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(OverviewController());
      }),
    ),


    GetPage(
      name: RoutePath.addCard,
      page: () =>  AddCardScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(AddCardController());
      }),
    ),

    GetPage(
      name: RoutePath.profile,
      page: () =>  ProfileScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ProfileController());
      }),
    ),


    GetPage(
      name: RoutePath.account,
      page: () =>  AccountScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(AccountController());
      }),
    ),

    GetPage(
      name: RoutePath.editProfile,
      page: () =>  EditProfileScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(EditProfileController());
      }),
    ),

    GetPage(
      name: RoutePath.changePassword,
      page: () =>  ChangePasswordScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ChangePasswordController());
      }),
    ),


    GetPage(
      name: RoutePath.driverProfile,
      page: () =>  DriverProfileScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(DriverProfileController());
      }),
    ),


    GetPage(
      name: RoutePath.editDriverProfile,
      page: () =>  EditDriverProfileScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(EditDriverProfileController());
      }),
    ),

    GetPage(
      name: RoutePath.bankCard,
      page: () =>  BankCardScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(BankCardController());
      }),
    ),


    GetPage(
      name: RoutePath.contactAndSupport,
      page: () =>  ContactAndSupportScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ContactAndSupportController());
      }),
    ),


    GetPage(
      name: RoutePath.termAndCondition,
      page: () =>  TermsAndConditionScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(TermsAndConditionController());
      }),
    ),
    GetPage(
      name: RoutePath.policyAndPrivacy,
      page: () =>  PrivacyAndPolicyScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(PrivacyAndPolicyController());
      }),
    ),

    GetPage(
      name: RoutePath.profileLanguage,
      page: () =>  ProfileLanguageScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(ProfileLanguageController());
      }),
    ),


    GetPage(
      name: RoutePath.jobPost,
      page: () =>  JobPostScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(JobPostController());
      }),
    ),



    GetPage(
      name: RoutePath.categoryStatus,
      page: () =>  CategoryStatusScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(CategoryStatusController());
      }),
    ),



    GetPage(
      name: RoutePath.westType,
      page: () =>  WestTypeScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(WestTypeController());
      }),
    ),



    GetPage(
      name: RoutePath.notAllowWest,
      page: () =>  NotAllowScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        Get.put(NotAllowController());
      }),
    ),






  ];
}

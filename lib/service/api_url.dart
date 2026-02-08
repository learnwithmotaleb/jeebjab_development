class ApiUrl {
  //static const mainDomain = "https://7bn5s1dw-3333.inc1.devtunnels.ms";
  //static const mainDomain = "https://6dxv0gtk-3333.inc1.devtunnels.ms";
  //static const mainDomain = "https://6dxv0gtk-3333.inc1.devtunnels.ms";
  //static const mainDomain = "https://health-vault-mobile-application.vercel.app";
  static const mainDomain = "https://8r91dfjh-3333.inc1.devtunnels.ms";
  // static const mainDomain = "https://health-vault-mobile-application.vercel.app";
  static final baseUrl = '$mainDomain/api/v1';


  static String buildImageUrl(String relativePath) {
    // Replace backslashes with forward slashes
    final path = relativePath.replaceAll(r'\', '/');
    return "$mainDomain/$path";
  }



  /// ============================ Auth ==============================
  static String userLogin = "$baseUrl/auth/login";
  static String userRegister = "$baseUrl/user/register";
  static String changePassword = "$baseUrl/auth/change-password";
  static String verifyEmailOtp = "$baseUrl/auth/verify-email-otp";
  static String forgetPassword = "$baseUrl/auth/forgot-password";
  static String verifyOtp = "$baseUrl/auth/verify-otp";
  static String resetPassword = "$baseUrl/auth/reset-password";

  static const refreshToken = "/auth/refresh-token";
  static const getMeProvider = "/user/getMe";
  static const getMeAdmin = "/auth/admin/me";

  //===========================user profile=========================
  static String updateMyProfile = "$baseUrl/user/updateMe";
  static String getUserProfile = "$baseUrl/user/getMeNormalUser";



  ///===============Reminder=======================
  static String createReminder = "$baseUrl/reminder/create-reminder";
  static String myReminder = "$baseUrl/reminder/my-reminders";
  static String updateReminder(String id) => "$baseUrl/reminder/update-reminder/$id";
  static String deleteReminder(String id) => "$baseUrl/reminder/delete-reminder/$id";



  //=========================Provider Type==================
  static String providerType = "$baseUrl/provider-types";
  static String adminCreateService(String label) => "$baseUrl/service/admin-service/$label";

  //===========================All Provider =================
  static String getAllProvider = "$baseUrl/provider/all-providers";
  static String getProviderById(String providerTypeID) => "$baseUrl/provider/all-providers?providerTypeId=$providerTypeID";
  static String getSingleProviderById(String profileID) => "$baseUrl/provider/$profileID";








  //=========================Appointments==================
  static String myAppointment = "$baseUrl/appointment/my-appointments";
  static String createAppointment = "$baseUrl/appointment/create-appointment";



  //========================Insurance===================
  static String getInsuranceSelf = "$baseUrl/insurance/SELF";
  static String getInsuranceFamily = "$baseUrl/insurance/FAMILY";
  static String postInsurance = "$baseUrl/insurance/create";
  static String updateInsuranceMySelf(String id) => "$baseUrl/insurance/$id";
  static String updateInsuranceFamily(String id) => "$baseUrl/insurance/$id";
  static String deleteInsurance(String id) => "$baseUrl/insurance/$id";


  //========================HealthLog===================
  static String getHealthLogSelf = "$baseUrl/healthLog/SELF";
  static String getHealthLogFamily = "$baseUrl/healthLog/FAMILY";
  static String postHealthLog = "$baseUrl/healthLog/create";
  static String updateHealthLogMySelf(String id) => "$baseUrl/healthLog/$id";
  static String updateHealthLogFamily(String id) => "$baseUrl/healthLog/$id";
  static String deleteHealthLog(String id) => "$baseUrl/healthLog/$id";






  //======================== Document===================
  static String fetchDocumentSelf= "$baseUrl/medicalDocument/update-document";
  static String fetchDocumentFamily= "$baseUrl/medicalDocument/update-document";


  static String addDocumentSelf= "$baseUrl/medicalDocument/create-document";
  //form-data
  //medical_mySelf_image

  static String addDocumentFamily= "$baseUrl/medicalDocument/create-document";
  //form-data
  //medical_family_image

  static String removeDocumentSelf= "$baseUrl/medicalDocument/update-document";
  //body
  // {
  //   "deleteMedical_mySelf_image": [     "uploads\\images\\medical_mySelf_image\\1769668946501-play_store_512.png",
  //             "uploads\\images\\medical_mySelf_image\\1769669186771-play_store_512.png",
  //             "uploads\\images\\medical_mySelf_image\\1769669208881-play_store_512.png"],


  static String removeDocumentFamily= "$baseUrl/medicalDocument/update-document";
  //body
  // "deleteMedical_family_image":[          "uploads\\images\\medical_family_image\\1770437350552-verified.png",
  //             "uploads\\images\\medical_family_image\\1770437429045-verified.png",
  //             "uploads\\images\\medical_family_image\\1770437446490-verified.png"]
  // }



  //===========================Notification ===============================
  static String getAllNotification =  "$baseUrl/notification/get-notifications";
  static String removeNotification(String id) =>  "$baseUrl/notification/delete-notification/$id";


  //===========================Favourite  ===============================
  static String createFavorite(String id) =>  "$baseUrl/favorite/$id";
  static String removeFavorite(String id) =>  "$baseUrl/favorite/$id";
  static String getAllFavorite =  "$baseUrl/favorite/my-favorites";


  //======================Terms and condition ===========================
  static String getTermsAndCondition =  "$baseUrl/manage-Web/get-terms-conditions";
  static String getFag =  "$baseUrl/manage-Web/get-faq";
  static String privacyPolicy =  "$baseUrl/manage-Web/get-privacy-policy";




  //===========================Article===============================
  static String getAllArticle =  "$baseUrl/article";

  static String getSingeArticle(String id) =>  "$baseUrl/article/$id";



  //========================================Provider profile =====================
  static String getProviderProfile =  "$baseUrl/user/getMe";



  //========================================Provider profile =====================
  static String providerAppointment =  "$baseUrl/appointment/provider-appointments";

  static String providerAppointmentDetails(String id) => "$baseUrl/appointment/provider-appointments/$id";








  //========================================Provider profile =====================
  static String createAvailabilityDay =  "$baseUrl/availability-day/create-availability-day";
  static String createAvailabilitySlot =  "$baseUrl/availability-slot/create-availability-slot";
  static String getProviderAvailability(String profileId) => "$baseUrl/availability-day/provider-availability/$profileId";
  static String deleteProviderAvailability = "$baseUrl/availability-slot/delete-availability-slot";



  //======================Service=================
  static String createService =  "$baseUrl/service/create-service";
  static String myCreateService =  "$baseUrl/service/my-created-service";
  static String serviceUpdate(String id) => "$baseUrl/service/update-service/$id";
  static String serviceDelete(String id) => "$baseUrl/service/delete-service/$id";













}

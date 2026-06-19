// lib/core/network/api_url.dart

class ApiUrl {
  ApiUrl._();

  // ── Domain ───────────────────────────────────────────────
  // 🔧 Switch domain here only — everything else updates automatically
  // static const String _mainDomain = "http://10.10.20.52:5001";
  // static const String _mainDomain = "http://10.10.20.52:5001";
  // static const String _mainDomain = "http://51.21.196.205";
  // static const String _mainDomain = "http://10.10.20.52:5002";
  static const String _mainDomain = "http://10.10.20.52:5002";
  // static const String _mainDomain = "http://10.10.20.52:5002";

  static final String baseUrl = _mainDomain;

  static String buildImageUrl(String relativePath) {
    String path = relativePath.replaceAll(r'\', '/');
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    return '$_mainDomain/$path';
  }

  // ════════════════════════════════════════════════════════
  //  AUTH
  // ════════════════════════════════════════════════════════
  static final String login = '$baseUrl/auth/login';
  static final String register = '$baseUrl/auth/register';
  static final String accountActive = '$baseUrl/auth/activate-account';
  static final String accountActiveCodeResend =
      '$baseUrl/auth/activation-code-resend';
  static final String forgotPassword = '$baseUrl/auth/forgot-password';
  static final String forgetPasswordOtpVerify =
      '$baseUrl/auth/forget-pass-otp-verify';
  static final String resetPassword = '$baseUrl/auth/reset-password';
  static final String changePassword = '$baseUrl/auth/change-password';
  static final String socialLogin = '$baseUrl/auth/social-login';

  // http://10.10.20.52:5001/auth/register
  static final String getUserProfile = '$baseUrl/user/user-profile';
  static final String becomeDriver = '$baseUrl/user/become-driver';

  static final String createPost = '$baseUrl/post';
  static final String updatePost = '$baseUrl/post/:id';
  static String getPostDetails(String id) => '$baseUrl/post/$id';

  static final String getPendingPosts = '$baseUrl/post/my-posts?status=pending';
  static final String getActivePosts = '$baseUrl/post/my-posts?status=active';

  static final String getCompletedPosts =
      '$baseUrl/post/my-posts?status=completed';

  static final String getJobPost = '$baseUrl/post';
  static String getJobPostDetails(String id) => '$baseUrl/post/$id';

  //================Request Status=======================

  static String postSendJobRequest(String id) =>
      '$baseUrl/driver/jobs/$id/request';
  static String deleteCancelJobRequest(String id) =>
      '$baseUrl/driver/jobs/$id/request';

  static final getActiveTasks = "$baseUrl/driver/tasks?status=active";
  static final getCompletedTasks = "$baseUrl/driver/tasks?status=completed";
  static final getCancelledTasks = "$baseUrl/driver/tasks?status=cancelled";
  static String getTaskDetails(String id) => '$baseUrl/driver/tasks/$id';

  //==========================
  static String acceptRequest(String id, String requestId) =>
      '$baseUrl/post/$id/requests/$requestId/accept';

  static final String userPostReview = '$baseUrl/review';

  static String userGetReview(String userId) =>
      '$baseUrl/review/user/$userId?type=userToDriver';

  //======================Chat All Endpoint====================
  static final String chatPost = '$baseUrl/chat/post-chat';

  static final String getAllChatList = '$baseUrl/chat/get-all-chats';
  static String getChatMessage(String chatId) =>
      '$baseUrl/chat/get-chat-messages?chatId=$chatId';

  static final String uploadMedia = '$baseUrl/chat/upload-media';

  static final String getPrivacyAndPolicy =
      '$baseUrl/manage/get-privacy-policy';
  static final String getFaq = '$baseUrl/manage/get-faq';
  static final String getTermAndConditions =
      '$baseUrl/manage/get-terms-conditions';
  static final String postContactSupport = '$baseUrl/manage/contact-support';

  //======================Socket====================
  static String socketUrl({required String userID}) =>
      '$baseUrl?userId=$userID';
}

// lib/core/network/api_url.dart

class ApiUrl {
  ApiUrl._();

  // ── Domain ───────────────────────────────────────────────
  // 🔧 Switch domain here only — everything else updates automatically
  static const String _mainDomain = "https://your-jeebjab-api.com";
  static final String baseUrl = '$_mainDomain/api/v1';

  /// Convert relative image path → full URL
  /// e.g. "uploads\image.png" → "https://domain.com/uploads/image.png"
  static String buildImageUrl(String relativePath) {
    final path = relativePath.replaceAll(r'\', '/');
    return '$_mainDomain/$path';
  }

  // ════════════════════════════════════════════════════════
  //  AUTH
  // ════════════════════════════════════════════════════════
  static final String login           = '$baseUrl/auth/login';
  static final String register        = '$baseUrl/auth/register';
  static final String verifyEmailOtp  = '$baseUrl/auth/verify-email-otp';
  static final String forgotPassword  = '$baseUrl/auth/forgot-password';
  static final String verifyOtp       = '$baseUrl/auth/verify-otp';
  static final String resetPassword   = '$baseUrl/auth/reset-password';
  static final String changePassword  = '$baseUrl/auth/change-password';
  static final String refreshToken    = '$baseUrl/auth/refresh-token';
  static final String logout          = '$baseUrl/auth/logout';

  // Social login
  static final String appleLogin      = '$baseUrl/auth/apple';
  static final String googleLogin     = '$baseUrl/auth/google';

  // ════════════════════════════════════════════════════════
  //  USER PROFILE
  // ════════════════════════════════════════════════════════
  static final String getMe           = '$baseUrl/user/me';
  static final String updateProfile   = '$baseUrl/user/update-profile';
  static final String deleteAccount   = '$baseUrl/user/delete-account';
  static final String uploadAvatar    = '$baseUrl/user/upload-avatar';

  // Saved locations (Home / Work)
  static final String savedLocations        = '$baseUrl/user/saved-locations';
  static String deleteSavedLocation(String id) => '$baseUrl/user/saved-locations/$id';

  // ════════════════════════════════════════════════════════
  //  DRIVER
  // ════════════════════════════════════════════════════════
  static final String driverRegister       = '$baseUrl/driver/register';
  static final String driverProfile        = '$baseUrl/driver/profile';
  static final String updateDriverProfile  = '$baseUrl/driver/update-profile';
  static final String driverDocuments      = '$baseUrl/driver/documents';
  static final String driverStatus         = '$baseUrl/driver/status';    // online/offline
  static final String driverEarnings       = '$baseUrl/driver/earnings';
  static final String driverCurrentTask    = '$baseUrl/driver/current-task';
  static final String driverJobHistory     = '$baseUrl/driver/job-history';

  // ════════════════════════════════════════════════════════
  //  POSTS / ADS
  // ════════════════════════════════════════════════════════
  static final String createPost      = '$baseUrl/posts';
  static final String getAllPosts      = '$baseUrl/posts';
  static final String getMyPosts      = '$baseUrl/posts/my-posts';
  static String getPostById(String id)   => '$baseUrl/posts/$id';
  static String updatePost(String id)    => '$baseUrl/posts/$id';
  static String deletePost(String id)    => '$baseUrl/posts/$id';
  static String publishPost(String id)   => '$baseUrl/posts/$id/publish';
  static String cancelPost(String id)    => '$baseUrl/posts/$id/cancel';

  // Post photos
  static String uploadPostPhotos(String postId) => '$baseUrl/posts/$postId/photos';

  // ════════════════════════════════════════════════════════
  //  ORDERS / DELIVERY
  // ════════════════════════════════════════════════════════
  static final String createOrder         = '$baseUrl/orders';
  static final String getMyOrders         = '$baseUrl/orders/my-orders';
  static String getOrderById(String id)      => '$baseUrl/orders/$id';
  static String acceptOrder(String id)       => '$baseUrl/orders/$id/accept';
  static String cancelOrder(String id)       => '$baseUrl/orders/$id/cancel';
  static String updateOrderStatus(String id) => '$baseUrl/orders/$id/status';
  static String pickupOrder(String id)       => '$baseUrl/orders/$id/pickup';
  static String deliverOrder(String id)      => '$baseUrl/orders/$id/deliver';

  // ════════════════════════════════════════════════════════
  //  LOCATION / MAP
  // ════════════════════════════════════════════════════════
  static final String reverseGeocode      = '$baseUrl/location/reverse-geocode';
  static final String searchPlaces        = '$baseUrl/location/search';
  static final String updateDriverLocation = '$baseUrl/location/driver-location';
  static final String getNearbyDrivers    = '$baseUrl/location/nearby-drivers';

  // ════════════════════════════════════════════════════════
  //  PAYMENT
  // ════════════════════════════════════════════════════════
  static final String addCard             = '$baseUrl/payment/add-card';
  static final String getCards            = '$baseUrl/payment/cards';
  static String deleteCard(String id)        => '$baseUrl/payment/cards/$id';
  static final String initiatePayment     = '$baseUrl/payment/initiate';
  static String confirmPayment(String id)    => '$baseUrl/payment/$id/confirm';
  static final String paymentHistory      = '$baseUrl/payment/history';

  // ════════════════════════════════════════════════════════
  //  NOTIFICATIONS
  // ════════════════════════════════════════════════════════
  static final String getNotifications        = '$baseUrl/notifications';
  static final String markAllRead             = '$baseUrl/notifications/read-all';
  static String markNotificationRead(String id) => '$baseUrl/notifications/$id/read';
  static String deleteNotification(String id)   => '$baseUrl/notifications/$id';
  static final String registerFcmToken        = '$baseUrl/notifications/fcm-token';

  // ════════════════════════════════════════════════════════
  //  REVIEWS & RATINGS
  // ════════════════════════════════════════════════════════
  static final String createReview        = '$baseUrl/reviews';
  static String getUserReviews(String userId) => '$baseUrl/reviews/user/$userId';
  static String getDriverReviews(String driverId) => '$baseUrl/reviews/driver/$driverId';

  // ════════════════════════════════════════════════════════
  //  SUPPORT & CONTACT
  // ════════════════════════════════════════════════════════
  static final String contactUs           = '$baseUrl/support/contact';
  static final String getFaqs             = '$baseUrl/support/faqs';
  static final String reportAd            = '$baseUrl/support/report';

  // ════════════════════════════════════════════════════════
  //  PROMO / CAMPAIGN
  // ════════════════════════════════════════════════════════
  static final String validateCoupon      = '$baseUrl/promo/validate';
  static final String getActivePromos     = '$baseUrl/promo/active';
}
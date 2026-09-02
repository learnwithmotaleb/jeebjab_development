import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart' as g_auth;
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/widget/app_confirmation_alert.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';

import '../../../../../helper/local_db/local_db.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/custom_alert.dart';
import '../model/user_model.dart';

class ProfileMenuItem {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  ProfileMenuItem({
    required this.title,
    required this.icon,
    this.iconColor,
    required this.onTap,
  });
}

class ProfileController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  var isLoading = false.obs;
  var isSwitchingMode = false.obs;
  var userData = Rxn<UserModel>();

  // ── Driver Availability (Online / Offline) ─────────────────────────
  var isAvailable = false.obs;
  var isTogglingAvailability = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    try {
      // Same UserModel shape comes back from both endpoints (see the
      // model's own note) — driver mode is read from `driver/profile`
      // so driver-only fields (isAvailable, documents, etc.) stay fresh,
      // otherwise the plain user profile is used.
      final response = await _apiClient.get(
        url: SharePrefsHelper.isDriverMode
            ? ApiUrl.getDriverProfile
            : ApiUrl.getUserProfile,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userModel = UserModel.fromJson(response.body);
        userData.value = userModel;
        isAvailable.value = userModel.driverProfile?.isAvailable ?? false;
        if (userModel.activeMode != null) {
          await SharePrefsHelper.saveActiveMode(userModel.activeMode!);
        }
      } else {
        // Handle error but don't show snackbar every time if it's a silent fetch
        // AppSnackBar.fail(response.body['message'] ?? "Failed to fetch profile");
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Whether this account can operate in driver mode at all — only
  /// once a become-driver request has actually been approved.
  bool get canSwitchToDriverMode =>
      userData.value?.driverProfile?.isApproved ?? false;

  bool get isDriverMode => userData.value?.activeMode == 'driver';

  Future<void> switchMode() async {
    final switchingToDriver = !isDriverMode;

    AppAlerts.confirm(
      title: AppStrings.switchModeConfirmTitle.tr,
      message: switchingToDriver
          ? AppStrings.switchToDriverModeConfirm.tr
          : AppStrings.switchToUserModeConfirm.tr,
      onConfirm: () async {
        isSwitchingMode.value = true;
        try {
          final response = await _apiClient.patch(
            url: ApiUrl.switchUserMode(),
            isToken: true,
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            // Persist the new mode *before* refetching so getProfile()
            // hits the right endpoint (driver/profile vs user-profile)
            // instead of the stale, pre-switch one.
            await SharePrefsHelper.saveActiveMode(
              switchingToDriver ? 'driver' : 'user',
            );
            await getProfile(); // refresh with server-confirmed data
            AppSnackBar.success(
              response.body['message'] ??
                  AppStrings.modeSwitchedSuccessfully.tr,
              title: "Success",
            );

            Get.offAllNamed(
              SharePrefsHelper.isDriverMode
                  ? RoutePath.driverBottomNav
                  : RoutePath.bottomNav,
            );
          } else {
            AppSnackBar.fail(
              response.body['message'] ?? "Failed to switch mode",
            );
          }
        } catch (e) {
          debugPrint("Error switching mode: $e");
          AppSnackBar.fail("An unexpected error occurred");
        } finally {
          isSwitchingMode.value = false;
        }
      },
    );
  }

  /// PATCH /driver/availability — flips isAvailable each call.
  /// Only approved drivers can go online, so this is only wired up
  /// from the UI when [isDriverMode] is true.
  Future<void> toggleAvailability() async {
    if (isTogglingAvailability.value) return;

    final previous = isAvailable.value;
    isAvailable.value = !previous; // optimistic
    isTogglingAvailability.value = true;
    try {
      final response = await _apiClient.patch(
        url: ApiUrl.toggleDriverAvailability,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body['data'];
        if (data is Map && data['isAvailable'] != null) {
          isAvailable.value = data['isAvailable'] == true;
        }
        AppSnackBar.success(
          AppStrings.availabilityUpdatedSuccessfully.tr,
          title: "Success",
        );
      } else {
        isAvailable.value = previous; // revert on failure
        AppSnackBar.fail(
          response.body['message'] ?? AppStrings.failedToUpdateAvailability.tr,
        );
      }
    } catch (e) {
      isAvailable.value = previous; // revert on failure
      debugPrint("Error toggling availability: $e");
      AppSnackBar.fail(AppStrings.failedToUpdateAvailability.tr);
    } finally {
      isTogglingAvailability.value = false;
    }
  }

  List<ProfileMenuItem> get menuItems => [
    ProfileMenuItem(
      title: AppStrings.accountSetting.tr,
      icon: Icons.settings_outlined,
      onTap: () => Get.toNamed(RoutePath.account),
    ),
    ProfileMenuItem(
      title: AppStrings.language.tr,
      icon: Icons.language_outlined,
      onTap: () => Get.toNamed(RoutePath.profileLanguage),
    ),
    ProfileMenuItem(
      title: AppStrings.contactAndSupport.tr,
      icon: Icons.help_outline_rounded,
      onTap: () => Get.toNamed(RoutePath.contactAndSupport),
    ),
    ProfileMenuItem(
      title: AppStrings.termsAndCondition.tr,
      icon: Icons.description_outlined,
      onTap: () => Get.toNamed(RoutePath.termAndCondition),
    ),
    ProfileMenuItem(
      title: AppStrings.privacyPolicy.tr,
      icon: Icons.privacy_tip_outlined,
      onTap: () => Get.toNamed(RoutePath.policyAndPrivacy),
    ),

    ProfileMenuItem(
      title: AppStrings.faqs.tr,
      icon: Icons.help_outline_rounded,
      onTap: () => Get.toNamed(RoutePath.faqs),
    ),
    ProfileMenuItem(
      title: AppStrings.logOut.tr,
      icon: Icons.logout_rounded,
      iconColor: Colors.red,
      onTap: () {
        AppAlerts.confirm(
          title: AppStrings.areYourSureLogout.tr,
          message: AppStrings.areYourSureLogoutFrom.tr,
          onConfirm: () async {
            try {
              // Delete FCM token from backend
              await _apiClient.delete(
                url: ApiUrl.deleteFcmToken,
                isToken: true,
              );

              await FirebaseAuth.instance.signOut();
              await g_auth.GoogleSignIn.instance.signOut();
            } catch (e) {
              debugPrint("Error during sign out: $e");
            }
            await SharePrefsHelper.clearAll();
            Get.offAllNamed(RoutePath.login);
          },
        );
      },
    ),
  ];
}

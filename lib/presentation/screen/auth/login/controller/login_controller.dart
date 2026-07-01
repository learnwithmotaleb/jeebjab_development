import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/core/enums/app_role.dart';
import 'package:jeebjab/helper/local_db/local_db.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/helper/tost_message/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart' as g_auth;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final ApiClient apiClient = ApiClient();
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();

    emailController.text = "soniaai@yopmail.com";
    passwordController.text = "123456MMmm..";
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }

  bool validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState?.save();
    }
    return isValid;
  }

  Future<void> submit() async {
    if (!validateForm()) return;

    isLoading.value = true;

    try {
      final response = await apiClient.post(
        url: ApiUrl.login,
        body: {
          "email": emailController.text.trim(),
          "password": passwordController.text,
          "fcmToken": SharePrefsHelper.getFcmToken() ?? "",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;
        final data = body['data'];

        if (data != null) {
          final token = data['accessToken'];
          if (token != null) {
            await SharePrefsHelper.saveToken(token);
          }

          final user = data['user'];
          if (user != null) {
            final userId = user['_id'];
            if (userId != null) {
              await SharePrefsHelper.saveUserId(userId);
            }

            final authId = user['authId'];
            if (authId != null) {
              final roleStr = authId['role'];
              if (roleStr != null) {
                if (roleStr.toString().toUpperCase() == 'USER' ||
                    roleStr.toString().toUpperCase() == 'USER') {
                  await SharePrefsHelper.saveRole(AppRole.USER);
                } else if (roleStr.toString().toUpperCase() == 'DRIVER') {
                  await SharePrefsHelper.saveRole(AppRole.DRIVER);
                }
              }
            }
          }
        }

        final role = SharePrefsHelper.getRole();

        AppSnackBar.success(
          body['message'] ?? "Log in successful",
          title: "Success",
        );

        if (role == AppRole.USER) {
          Get.offAllNamed(RoutePath.bottomNav);
        } else if (role == AppRole.DRIVER) {
          Get.offAllNamed(RoutePath.driverBottomNav);
        } else {
          Get.offAllNamed(RoutePath.signup);
        }
      } else {
        String errorMessage =
            response.body['message'] ??
            response.statusText ??
            "Login failed. Please try again.";
        AppSnackBar.fail(errorMessage, title: "Login Failed");
      }
    } catch (e, stackTrace) {
      debugPrint("Login Error: $e\n$stackTrace");
      AppSnackBar.fail(
        "An unexpected error occurred. Please try again.",
        title: "Error",
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ================= SOCIAL LOGIN =================

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final g_auth.GoogleSignInAccount? googleUser =
          await g_auth.GoogleSignIn.instance.authenticate();

      if (googleUser == null) {
        // User cancelled the sign-in
        return;
      }

      final g_auth.GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final String? idToken = await userCredential.user?.getIdToken();

      if (idToken != null) {
        debugPrint("========= FIREBASE GOOGLE LOGIN ID TOKEN =========");
        debugPrint(idToken);
        debugPrint("================================================");

        // Send token to backend API for social login
        await _processSocialLogin(idToken, "google");
      }
    } catch (e, stackTrace) {
      debugPrint("Google Sign In Error: $e\n$stackTrace");
      AppSnackBar.fail(
          "Google Sign In failed: ${e.toString().split('\n')[0]}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithApple() async {
    isLoading.value = true;
    try {
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );

      final AuthCredential authCredential = OAuthProvider("apple.com")
          .credential(
            idToken: credential.identityToken,
            accessToken: credential.authorizationCode,
          );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(authCredential);
      final String? idToken = await userCredential.user?.getIdToken();

      if (idToken != null) {
        debugPrint("========= FIREBASE APPLE LOGIN ID TOKEN =========");
        debugPrint(idToken);
        debugPrint("===============================================");

        // Send token to backend API for social login
        await _processSocialLogin(idToken, "apple");
      }
    } catch (e, stackTrace) {
      debugPrint("Apple Sign In Error: $e\n$stackTrace");
      AppSnackBar.fail("Apple Sign In failed: ${e.toString().split('\n')[0]}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _processSocialLogin(String token, String provider) async {
    try {
      final response = await apiClient.post(
        url: ApiUrl.socialLogin,
        body: {
          "token": token,
          "provider": provider,
          "fcmToken": SharePrefsHelper.getFcmToken() ?? "",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;
        final data = body['data'];

        if (data != null) {
          final accessToken = data['accessToken'];
          if (accessToken != null) {
            await SharePrefsHelper.saveToken(accessToken);
          }

          final user = data['user'];
          if (user != null) {
            final userId = user['_id'];
            if (userId != null) {
              await SharePrefsHelper.saveUserId(userId);
            }

            final authId = user['authId'];
            if (authId != null) {
              final roleStr = authId['role'];
              if (roleStr != null) {
                if (roleStr.toString().toUpperCase() == 'USER') {
                  await SharePrefsHelper.saveRole(AppRole.USER);
                } else if (roleStr.toString().toUpperCase() == 'DRIVER') {
                  await SharePrefsHelper.saveRole(AppRole.DRIVER);
                }
              }
            }
          }
        }

        final role = SharePrefsHelper.getRole();
        AppSnackBar.success("Logged in successfully", title: "Success");

        if (role == AppRole.USER) {
          Get.offAllNamed(RoutePath.bottomNav);
        } else if (role == AppRole.DRIVER) {
          Get.offAllNamed(RoutePath.driverBottomNav);
        } else {
          Get.offAllNamed(RoutePath.signup);
        }
      } else {
        AppSnackBar.fail(response.body['message'] ?? "Social Login failed");
      }
    } catch (e) {
      debugPrint("Process Social Login Error: $e");
      AppSnackBar.fail("Something went wrong during social login.");
    }
  }
}

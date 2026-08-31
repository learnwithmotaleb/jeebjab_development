import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';
import '../../../profile/controller/profile_controller.dart';
import '../../../profile/model/user_model.dart';

class EditProfileController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // ── Form Controllers ──────────────────────────────────────────────────────
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  // ── Profile Image ─────────────────────────────────────────────────────────
  final Rx<File?> pickedImage = Rx<File?>(null);
  final RxnString existingAvatarUrl = RxnString();
  final ImagePicker _picker = ImagePicker();

  // ── Loading state ──────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;

  // ── Gender picker ─────────────────────────────────────────────────────────
  // Display labels shown in the picker vs. the exact enum values the
  // backend expects (male | female | other | prefer_not_to_say).
  final RxString selectedGender = ''.obs;
  final List<String> genders = ['Male', 'Female', 'Other', 'Prefer not to say'];
  static const Map<String, String> _genderApiValues = {
    'Male': 'male',
    'Female': 'female',
    'Other': 'other',
    'Prefer not to say': 'prefer_not_to_say',
  };

  // ── DOB (kept as a real DateTime so we can send an ISO date to the API) ───
  DateTime? _selectedDob;

  @override
  void onInit() {
    super.onInit();
    _prefillFromCurrentProfile();
  }

  /// Load the current profile so the form isn't blank / stale on open.
  Future<void> _prefillFromCurrentProfile() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(
        url: ApiUrl.getUserProfile,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = UserModel.fromJson(response.body);
        nameController.text = user.name;
        existingAvatarUrl.value = user.avatarUrl;

        if (user.gender != null && user.gender!.isNotEmpty) {
          // The backend returns the lowercase enum value — map it back
          // to the display label the picker uses.
          final display = _genderApiValues.entries
              .firstWhere(
                (e) => e.value == user.gender,
                orElse: () => MapEntry(user.gender!, user.gender!),
              )
              .key;
          selectGender(display);
        }

        if (user.dateOfBirth != null) {
          _setDob(user.dateOfBirth!);
        }
      }
    } catch (e) {
      debugPrint("Error fetching profile for edit: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (photo != null) pickedImage.value = File(photo.path);
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
    genderController.text = gender;
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDob ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF17C5B5)),
        ),
        child: child!,
      ),
    );
    if (picked != null) _setDob(picked);
  }

  void _setDob(DateTime date) {
    _selectedDob = date;
    dobController.text =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().substring(2)}';
  }

  /// yyyy-MM-dd — the format the backend expects.
  String get _dobForApi {
    final d = _selectedDob!;
    return '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  bool get isValid => nameController.text.trim().isNotEmpty;

  Future<void> onUpdateProfile() async {
    if (!isValid) {
      AppSnackBar.fail("Name can't be empty");
      return;
    }
    if (isUpdating.value) return;

    isUpdating.value = true;
    try {
      final fields = <String, String>{
        'name': nameController.text.trim(),
        if (selectedGender.value.isNotEmpty)
          'gender':
              _genderApiValues[selectedGender.value] ?? selectedGender.value,
        if (_selectedDob != null) 'dateOfBirth': _dobForApi,
      };

      final response = await _apiClient.patchWithMultipart(
        url: ApiUrl.updateUserProfile,
        fields: fields,
        imageFile: pickedImage.value,
        imageKey: 'profile_image',
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Refresh the profile screen behind this one, if it's alive.
        if (Get.isRegistered<ProfileController>()) {
          Get.find<ProfileController>().getProfile();
        }
        // Pop first, then show the snackbar — showing it right before
        // Get.back() risks the overlay tearing down mid-pop and the
        // snackbar never actually rendering.
        Get.back();
        AppSnackBar.success("Profile updated successfully");
      } else {
        final message = response.body is Map
            ? (response.body['message']?.toString() ??
                  "Failed to update profile")
            : "Failed to update profile";
        AppSnackBar.fail(message);
      }
    } catch (e) {
      debugPrint("Error updating profile: $e");
      AppSnackBar.fail("Something went wrong. Please try again.");
    } finally {
      isUpdating.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    genderController.dispose();
    dobController.dispose();
    super.onClose();
  }
}

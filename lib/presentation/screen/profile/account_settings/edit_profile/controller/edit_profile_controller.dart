import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileController extends GetxController {
  // ── Form Controllers ──────────────────────────────────────────────────────
  final TextEditingController nameController =
  TextEditingController(text: 'Rayyan Hassan');
  final TextEditingController genderController =
  TextEditingController(text: 'Male');
  final TextEditingController dobController =
  TextEditingController(text: '10/12/94');

  // ── Profile Image ─────────────────────────────────────────────────────────
  final Rx<File?> pickedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (photo != null) pickedImage.value = File(photo.path);
  }

  // ── Gender picker ─────────────────────────────────────────────────────────
  final RxString selectedGender = 'Male'.obs;
  final List<String> genders = ['Male', 'Female', 'Other'];

  void selectGender(String gender) {
    selectedGender.value = gender;
    genderController.text = gender;
  }

  // ── DOB picker ────────────────────────────────────────────────────────────
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1994, 10, 12),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF17C5B5),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      dobController.text =
      '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString().substring(2)}';
    }
  }

  bool get isValid => nameController.text.trim().isNotEmpty;

  void onUpdateProfile() {
    if (!isValid) return;
    // TODO: Call API to update profile
  }

  @override
  void onClose() {
    nameController.dispose();
    genderController.dispose();
    dobController.dispose();
    super.onClose();
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeebjab/helper/tost_message/show_snackbar.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

/// Edits a job post — only reachable/allowed while the post is still
/// "pending" (PATCH /post/:id enforces this server-side too: "Only
/// pending posts can be edited").
class EditPostController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final ImagePicker _picker = ImagePicker();

  String postId = '';

  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxString errorMessage = ''.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  final RxString size = 'medium'.obs;
  final List<String> sizeOptions = const ['small', 'medium', 'large', 'extra_large'];

  static const int maxPhotos = 5;

  // Existing server-side photos (relative paths) kept unless the user
  // removes one — sent back as `keepPhotos` per the API contract.
  final RxList<String> existingPhotos = <String>[].obs;
  // New photos picked locally, uploaded alongside the update as `post_image`.
  final RxList<File> newPhotos = <File>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    postId = args?['id']?.toString() ?? '';
    if (postId.isNotEmpty) {
      _loadPost();
    } else {
      errorMessage.value = "No post selected.";
    }
  }

  Future<void> _loadPost() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await _apiClient.get(
        url: ApiUrl.getPostDetails(postId),
        isToken: true,
      );

      if (response.statusCode == 200) {
        final data = response.body['data'] as Map<String, dynamic>;

        if ((data['status']?.toString() ?? 'pending') != 'pending') {
          errorMessage.value = AppStrings.thisPostCanNoLongerBeEdited.tr;
          return;
        }

        titleController.text = data['title']?.toString() ?? '';
        descriptionController.text = data['description']?.toString() ?? '';
        priceController.text = (data['price'] ?? '').toString();
        size.value = data['size']?.toString() ?? 'medium';
        existingPhotos.assignAll(
          (data['photos'] as List? ?? []).map((p) => p.toString()),
        );
      } else {
        errorMessage.value =
            response.body['message'] ?? "Failed to load post";
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }

  int get totalPhotoCount => existingPhotos.length + newPhotos.length;

  void removeExistingPhoto(String path) => existingPhotos.remove(path);

  void removeNewPhoto(File file) => newPhotos.remove(file);

  Future<void> pickImage() async {
    if (totalPhotoCount >= maxPhotos) {
      AppSnackBar.info("You can have up to $maxPhotos photos.");
      return;
    }
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (image != null) newPhotos.add(File(image.path));
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> save() async {
    if (postId.isEmpty || isSaving.value) return;

    final title = titleController.text.trim();
    if (title.isEmpty) {
      AppSnackBar.fail("Title can't be empty.");
      return;
    }

    final price = num.tryParse(priceController.text.trim());
    if (price == null || price <= 0) {
      AppSnackBar.fail("Enter a valid price.");
      return;
    }

    if (existingPhotos.isEmpty && newPhotos.isEmpty) {
      AppSnackBar.fail("Add at least one photo.");
      return;
    }

    isSaving.value = true;
    try {
      // keepPhotos belongs *inside* the `data` JSON object, not as its own
      // form field — sending it separately meant the backend never saw it
      // (its parsed `data` had no such key), so it defaulted to keeping
      // every existing photo no matter what was removed here, and adding
      // any new upload pushed the total past the 5-photo limit.
      final Map<String, dynamic> data = {
        "title": title,
        "description": descriptionController.text.trim(),
        "size": size.value,
        "price": price,
        "keepPhotos": existingPhotos.toList(),
      };

      final files = newPhotos
          .map((f) => MultipartFileData(key: 'post_image', path: f.path))
          .toList();

      final response = await _apiClient.patchMultipart(
        url: ApiUrl.updateJobPostDetails(postId),
        fields: {'data': jsonEncode(data)},
        files: files,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Navigate back *before* the snackbar — Get.snackbar and Get.back()
        // both drive GetX's overlay/route stack, and firing them together
        // races the snackbar's own transition, silently swallowing it.
        // It still shows fine on the screen we land back on.
        Get.back(result: true);
        AppSnackBar.success(
          response.body['message'] ?? AppStrings.postUpdatedSuccessfully.tr,
        );
      } else {
        AppSnackBar.fail(
          response.body['message'] ?? AppStrings.failedToUpdatePost.tr,
        );
      }
    } catch (e) {
      AppSnackBar.fail("An error occurred: $e");
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.onClose();
  }
}

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import '../../../../helper/tost_message/show_snackbar.dart';

class CaptureImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final RxList<File> selectedImages = <File>[].obs;
  static const int maxImages = 4;
  final Rx<File?> previewImage = Rx<File?>(null);

  bool get hasImages => selectedImages.isNotEmpty;

  Future<void> captureFromCamera() async {
    if (selectedImages.length >= maxImages) return;
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (photo != null) {
      final file = File(photo.path);
      selectedImages.add(file);
      previewImage.value = file;
    }
  }

  Future<void> pickFromGallery() async {
    if (selectedImages.length >= maxImages) return;
    final List<XFile> photos = await _picker.pickMultiImage(imageQuality: 85);
    for (final photo in photos) {
      if (selectedImages.length >= maxImages) break;
      final file = File(photo.path);
      selectedImages.add(file);
      previewImage.value = file;
    }
  }

  void selectPreview(File image) => previewImage.value = image;

  void removeImage(File image) {
    selectedImages.remove(image);
    if (previewImage.value?.path == image.path) {
      previewImage.value =
      selectedImages.isNotEmpty ? selectedImages.last : null;
    }
  }


  // ── Pass images as arguments to CaptureInfoScreen ────────────────────────
  void onNext() {
    if (!hasImages) {
      AppSnackBar.fail("Please capture or select at least one image.", title: "Required");
      return;
    }
    final bool isEditMode = Get.arguments?['isEdit'] ?? false;
    
    if (isEditMode) {
      Get.back();
    } else {
      Get.toNamed(
        RoutePath.captureInfo,
        arguments: {'images': selectedImages.toList()}, // List<File>
      );
    }
  }

  void onBack() => Get.back();
}
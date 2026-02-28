import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadDocumentController extends GetxController {
  final Rx<File?> imageFile = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? picked =
    await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      imageFile.value = File(picked.path);
    }
  }

  void removeImage() {
    imageFile.value = null;
  }







}

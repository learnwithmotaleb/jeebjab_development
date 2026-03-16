
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<T?> AppBottomSheet<T>({required Widget child}) {
  return Get.bottomSheet<T>(
    SafeArea(child: child),
    backgroundColor: Get.theme.colorScheme.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
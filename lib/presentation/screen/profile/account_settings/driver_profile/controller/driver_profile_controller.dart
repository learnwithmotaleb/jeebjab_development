import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

class DriverProfileController extends GetxController {
  // ── Driver Information ────────────────────────────────────────────────────
  final RxMap<String, String> driverInfo = <String, String>{
    'Company': 'Acme Co.',
    'ID': '56465416515',
    'Driver Number': '1641617565',
    'License Number': '7725068610',
    'Vehicle Type': 'Truck',
    'Brand': 'Man',
    'Model': 'CX-220',
    'Contact Number': '(307) 555-0133',
    'Contact Email': 'sara.cruz@example.com',
  }.obs;

  // ── Bank Information ──────────────────────────────────────────────────────
  final RxMap<String, String> bankInfo = <String, String>{
    'Bank Name': 'Acme Co.',
    'Account Holder Name': 'Dianne Russell',
    'Account Number': '285 392 3562',
  }.obs;

  void onEditProfile() {
    Get.toNamed(RoutePath.editDriverProfile);
  }
}
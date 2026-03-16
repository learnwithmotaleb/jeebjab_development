import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class DriverProfileController extends GetxController {
  // ── Driver Information ────────────────────────────────────────────────────
  final RxMap<String, String> driverInfo = <String, String>{
    AppStrings.driverProfile.tr: 'Acme Co.',
    AppStrings.id.tr: '56465416515',
    AppStrings.driverName.tr: '1641617565',
    AppStrings.licenseNumber.tr: '7725068610',
    AppStrings.vehicleType.tr: 'Truck',
    AppStrings.brand.tr: 'Man',
    AppStrings.model.tr: 'CX-220',
    AppStrings.contactNumber.tr: '(307) 555-0133',
    AppStrings.contactEmail.tr: 'sara.cruz@example.com',
  }.obs;

  // ── Bank Information ──────────────────────────────────────────────────────
  final RxMap<String, String> bankInfo = <String, String>{
    AppStrings.bankName.tr: 'Acme Co.',
    AppStrings.accountHolderName.tr: 'Dianne Russell',
    AppStrings.accountNumber.tr: '285 392 3562',
  }.obs;

  void onEditProfile() {
    Get.toNamed(RoutePath.editDriverProfile);
  }
}
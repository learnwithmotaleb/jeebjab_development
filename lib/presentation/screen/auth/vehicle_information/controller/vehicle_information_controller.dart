import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VehicleInformationController extends GetxController {
  final vehicleBrand = TextEditingController();
  final vehicleModel = TextEditingController();
  final vehicleYear = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    vehicleBrand.dispose();
    vehicleModel.dispose();
    vehicleYear.dispose();
    super.onClose();
  }
}
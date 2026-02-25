import 'package:get/get.dart';

class OverviewController extends GetxController{

  RxString serviceType = "Move".obs;
  RxString serviceTitle = "Move Bike To Another City".obs;
  RxString description = "Empty".obs;
  RxString sizeOfProduct = "Medium".obs;

  RxString pickupAddress = "Dubai Downtown".obs;
  RxString pickupPlacement = "Inside, Meet, Can Help".obs;
  RxString pickupFloor = "6 / A 95".obs;

  RxString dropAddress = "Dubai Downtown".obs;
  RxString dropPlacement = "Outside, No Meet".obs;
  RxString dropFloor = "6 / A 95".obs;

  RxString dateTime = "Anytime".obs;
  RxString price = "120 SAR".obs;

  RxBool termsAccepted = false.obs;

  RxBool acknowledgePickup = false.obs;
  RxBool correspondsWithPictures = false.obs;
  RxBool notToxicOrHarmful = false.obs;
  RxBool willBeAvailableForPickup = false.obs;

}
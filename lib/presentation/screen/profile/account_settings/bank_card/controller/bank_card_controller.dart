import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

class BankCardModel {
  final String cardNumber;
  final String addedDate;

  BankCardModel({required this.cardNumber, required this.addedDate});
}

class BankCardController extends GetxController {
  final RxList<BankCardModel> cards = <BankCardModel>[
    BankCardModel(
      cardNumber: '4084 4084 4084 4084',
      addedDate: '10 January 2026',
    ),
  ].obs;

  void onEditCard(BankCardModel card) {
    Get.toNamed(RoutePath.addCard);
  }

  void onAddCard() {
    // TODO: Get.toNamed(RoutePath.addCard);
  }
}
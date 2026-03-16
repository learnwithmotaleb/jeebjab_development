import 'package:get/get.dart';

class PrivacyAndPolicyController extends GetxController{


  final payments = """

All payments are processed securely via [paystack].
\n\n

If a payment fails, your order may be canceled automatically.
""".obs;

  final cancellations = """
Refund eligibility depends on timing of cancellation and local policy.
""".obs;


}
import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetController extends GetxController {
  /// Observable for internet connection status
  final RxBool isConnected = true.obs;

  /// Subscription to listen for connectivity changes
  StreamSubscription<InternetStatus>? _subscription;

  /// Singleton instance for easy access
  static InternetController get to => Get.find<InternetController>();

  @override
  void onInit() {
    super.onInit();
    _initConnection();
  }

  /// ---------------- Initialize connection ----------------
  void _initConnection() {
    // Check initial connection
    _checkInitialConnection();

    // Listen for changes
    _subscription = InternetConnection().onStatusChange.listen((status) {
      isConnected.value = status == InternetStatus.connected;
    });
  }

  /// ---------------- Check initial connection ----------------
  Future<void> _checkInitialConnection() async {
    final status = await InternetConnection().hasInternetAccess;
    isConnected.value = status;
  }

  /// ---------------- Force set connected ----------------
  void setConnected() => isConnected.value = true;

  /// ---------------- Force set disconnected ----------------
  void setDisconnected() => isConnected.value = false;

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}

import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetController extends GetxController {
  final RxBool isConnected = true.obs;
  final RxBool isChecking = false.obs;
  final RxString retryMessage = ''.obs;
  Timer? _statusTimer;
  int _statusVersion = 0;
  StreamSubscription<InternetStatus>? _subscription;
  static InternetController get to => Get.find<InternetController>();

  // ✅ Custom checker — multiple addresses
  final InternetConnection _checker = InternetConnection.createInstance(
    customCheckOptions: [
      InternetCheckOption(uri: Uri.parse('https://google.com')),
      InternetCheckOption(uri: Uri.parse('https://cloudflare.com')),
      InternetCheckOption(uri: Uri.parse('https://apple.com')),
      InternetCheckOption(uri: Uri.parse('https://amazon.com')),
    ],
    useDefaultOptions: false,
  );

  @override
  void onInit() {
    super.onInit();
    _initConnection();
  }

  void _initConnection() {
    retryConnection();

    _subscription = _checker.onStatusChange.listen((status) {
      _statusTimer?.cancel();
      if (isChecking.value) return;
      _statusVersion++;
      _statusTimer = Timer(const Duration(seconds: 2), () {
        if (!isClosed) {
          isConnected.value = status == InternetStatus.connected;
        }
      });
    });
  }

  Future<void> retryConnection() async {
    if (isChecking.value || isClosed) return;
    _statusTimer?.cancel();
    final version = ++_statusVersion;
    isChecking.value = true;
    retryMessage.value = '';
    try {
      final connected = await _checker.hasInternetAccess.timeout(
        const Duration(seconds: 10),
      );
      if (isClosed || version != _statusVersion) return;
      isConnected.value = connected;
      if (!connected) {
        retryMessage.value = 'Still offline. Check your connection and try again.';
      }
    } catch (_) {
      if (isClosed || version != _statusVersion) return;
      isConnected.value = false;
      retryMessage.value = 'Unable to connect. Please try again.';
    } finally {
      if (!isClosed) isChecking.value = false;
    }
  }

  void setConnected() {
    _statusTimer?.cancel();
    _statusVersion++;
    isConnected.value = true;
    retryMessage.value = '';
  }

  void setDisconnected() {
    _statusTimer?.cancel();
    _statusVersion++;
    isConnected.value = false;
  }

  @override
  void onClose() {
    _statusTimer?.cancel();
    _subscription?.cancel();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../helper/local_db/local_db.dart';
import '../utils/app_const/app_const.dart';
import 'api_url.dart';

class SocketApi {
  // ─── Singleton ───────────────────────────────────────────────
  factory SocketApi() => _socketApi;
  SocketApi._internal();
  static final SocketApi _socketApi = SocketApi._internal();

  // ─── Socket Instance ─────────────────────────────────────────
  static io.Socket? socket;
  static bool _isInitialized = false;

  // ─── Init ─────────────────────────────────────────────────────
  static Future<void> init() async {
    // Prevent duplicate initialization
    if (_isInitialized && (socket?.connected ?? false)) {
      debugPrint('🟡 Socket already connected. Skipping init.');
      return;
    }

    final String userId = SharePrefsHelper.getUserId() ?? '';
    final String token = SharePrefsHelper.getToken() ?? '';

    if (userId.isEmpty || userId == 'null') {
      debugPrint('🔴 Socket init skipped — no userId found.');
      return;
    }

    debugPrint('🔵 Initializing socket for userId: $userId');

    socket = io.io(
      ApiUrl.socketUrl(userID: userId),
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(5)
          .setReconnectionDelay(2000)
          .setAuth({'token': token}) // JWT auth
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    _registerEvents();
    _isInitialized = true;
  }

  // ─── Register All Events ──────────────────────────────────────
  static void _registerEvents() {
    if (socket == null) return;

    socket!.onConnect((_) {
      debugPrint('🟢 Socket connected | id: ${socket!.id}');
    });

    socket!.on('connecting', (_) {
      debugPrint('🔵 Socket connecting...');
    });

    socket!.on('reconnecting', (_) {
      debugPrint('🟡 Socket reconnecting...');
    });

    socket!.on('reconnect', (_) {
      debugPrint('🟢 Socket reconnected successfully.');
    });

    socket!.on('reconnect_failed', (_) {
      debugPrint('🔴 Socket reconnection failed after max attempts.');
    });

    socket!.onDisconnect((data) {
      debugPrint('🔴 Socket disconnected: $data');
    });

    socket!.onError((error) {
      debugPrint('🔴 Socket error: $error');
    });

    socket!.on('unauthorized', (data) {
      debugPrint('🔴 Unauthorized: $data');
      disconnect(); // clear socket on auth failure
    });

    socket!.on('connect_error', (data) {
      debugPrint('🔴 Connection error: $data');
    });
  }

  // ─── Emit Event ───────────────────────────────────────────────
  static void emit(String event, dynamic data) {
    if (socket != null && socket!.connected) {
      socket!.emit(event, data);
      debugPrint('📤 Emitted [$event]: ${_shorten(data)}');
    } else {
      debugPrint('⚠️ Emit failed — socket not connected.');
    }
  }

  // ─── Listen to Event ──────────────────────────────────────────
  // Returns the unsubscribe callback for THIS handler only. Multiple
  // callers can listen to the same event name (e.g. ChatController and
  // ChatListController both listen to 'send_message') — the underlying
  // EventEmitter appends listeners rather than replacing them, so that's
  // fine. But `off(event)` with no handler wipes every listener for that
  // event regardless of who registered it, which would silently kill a
  // sibling controller's listener. Callers should store and invoke this
  // returned function on their own onClose instead of calling off(event)
  // directly, so each caller only ever removes its own handler.
  static Function() on(String event, Function(dynamic) handler) {
    void wrapped(dynamic data) {
      debugPrint('📥 Received [$event]: ${_shorten(data)}');
      handler(data);
    }

    return socket?.on(event, wrapped) ?? () {};
  }

  // ─── Log helper ───────────────────────────────────────────────
  // Printing a whole payload (a chat message list, a large attachment
  // reference, etc.) synchronously on every single socket message is a
  // real, measurable source of main-thread jank — cap it instead.
  static String _shorten(dynamic data) {
    final str = data.toString();
    return str.length > 200 ? '${str.substring(0, 200)}…' : str;
  }

  // ─── Remove Listener ──────────────────────────────────────────
  static void off(String event) {
    socket?.off(event);
    debugPrint('🗑️ Removed listener for [$event]');
  }

  // ─── Disconnect ───────────────────────────────────────────────
  static void disconnect() {
    socket?.disconnect();
    socket?.dispose();
    socket = null;
    _isInitialized = false;
    debugPrint('🔴 Socket disconnected and disposed.');
  }

  // ─── Reconnect manually ───────────────────────────────────────
  static Future<void> reconnect() async {
    debugPrint('🔁 Manual reconnect triggered.');
    disconnect();
    await Future.delayed(const Duration(milliseconds: 500));
    await init();
  }

  // ─── Status ───────────────────────────────────────────────────
  static bool get isConnected => socket?.connected ?? false;
}

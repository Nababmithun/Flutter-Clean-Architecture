import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetChecker {
  static final Connectivity _connectivity = Connectivity();
  static StreamSubscription<dynamic>? _subscription;

  /// Start listening globally (call from main.dart)
  static void startListening() {
    if (_subscription != null) return;

    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      final offline = _isOffline(event);
      if (offline) {
        _showNoInternetDialog();
      } else {
        if (Get.isDialogOpen == true) {
          Get.back(); // close dialog when online
        }
      }
    });
  }

  /// Manual single check (optional)
  static Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return !_isOffline(result);
  }

  static bool _isOffline(dynamic event) {
    if (event is List<ConnectivityResult>) {
      return event.isEmpty || event.every((r) => r == ConnectivityResult.none);
    } else if (event is ConnectivityResult) {
      return event == ConnectivityResult.none;
    } else {
      return true;
    }
  }

  static void _showNoInternetDialog() {
    if (Get.isDialogOpen == true) return;

    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 30),
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.wifi_off_rounded,
                      size: 50, color: Colors.redAccent),
                ),
                const SizedBox(height: 20),
                const Text(
                  "No Internet Connection",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Please check your Wi-Fi or mobile data.\nWe’ll reconnect automatically once you're online.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 28),

                // ✅ Buttons row side-by-side
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          side: const BorderSide(color: Colors.redAccent),
                        ),
                        onPressed: _exitApp,
                        icon: const Icon(Icons.exit_to_app, color: Colors.redAccent),
                        label: const Text(
                          "Exit",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () async {
                          final ok = await isConnected();
                          if (ok) {
                            if (Get.isDialogOpen == true) Get.back();
                          } else {
                            Get.snackbar("Still offline",
                                "Please connect to the internet");
                          }
                        },
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        label: const Text(
                          "Retry",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void _exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }

  static void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}

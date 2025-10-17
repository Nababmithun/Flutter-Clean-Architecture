import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetChecker {
  static final Connectivity _connectivity = Connectivity();

  // v6: Stream<List<ConnectivityResult>>
  // v5: Stream<ConnectivityResult>
  static StreamSubscription<dynamic>? _subscription;

  ///
  static void startListening() {
    //
    if (_subscription != null) return;

    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      final bool offline = _isOffline(event);
      if (offline) {
        _showNoInternetDialog();
      } else {
        if (Get.isDialogOpen == true) {
          Get.back(); // back
        }
      }
    });
  }

  /// checkConnectivity todo
  static Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return !_isOffline(result);
  }

  /// v5: event  ConnectivityResult
  static bool _isOffline(dynamic event) {
    if (event is List<ConnectivityResult>) {
      if (event.isEmpty) return true;
      // offline = none
      return event.every((r) => r == ConnectivityResult.none);
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
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
          title: Column(
            children: const [
              Icon(Icons.wifi_off_rounded, size: 56, color: Colors.redAccent),
              SizedBox(height: 12),
              Text(
                'No Internet Connection',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          //Online Toast
          content: const Text(
            "Please check your Wi-Fi or mobile data.\nWe'll reconnect automatically once you're online.",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size(140, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final ok = await isConnected();
                if (ok) {
                  Get.back();
                } else {
                  Get.snackbar(
                    'Still offline',
                    'Please connect to the internet',
                  );
                }
              },
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  //dispose method
  static void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}

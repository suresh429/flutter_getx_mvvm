import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'dart:io';

class ConnectivityService extends GetxService {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      bool connectionStatus = await _manualConnectivityCheck();
      isConnected.value = connectionStatus;
      print('Connectivity changed: $connectionStatus');
    });
    // Check initial connection status
    checkInitialConnection();
  }

  Future<void> checkInitialConnection() async {
    bool connectionStatus = await _manualConnectivityCheck();
    isConnected.value = connectionStatus;
    print('Initial connection status: $connectionStatus');
  }

  Future<bool> _manualConnectivityCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      print('Manual connectivity check failed: $e');
      return false;
    }
  }
}
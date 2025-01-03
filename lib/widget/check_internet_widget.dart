import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/ConnectivityService.dart';

class CheckInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;
  const CheckInternetWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final ConnectivityService connectivityService = Get.find();

    return Center(
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: const Icon(
                Icons.wifi_off,
                color: Colors.red,
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'No Internet Connection',
              style: TextStyle(color: Colors.black, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'No internet connection. Please check your network settings.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  print('Retry button pressed');
                  await connectivityService.checkInitialConnection();
                  if (connectivityService.isConnected.value) {
                    print('Internet is connected, retrying fetch requests');
                    onRetry();
                  } else {
                    print('Internet is not connected, cannot retry fetch requests');
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
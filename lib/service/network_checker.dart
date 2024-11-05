import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkChecker {
  static Future<bool> isConnected() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
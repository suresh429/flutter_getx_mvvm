import 'package:flutter/foundation.dart';
import 'common_main.dart';
import "package:TALLeaders/env/app_env.dart";

void main() {
  // Use kReleaseMode to automatically determine the environment
  AppEnvironment.setupEnv(kReleaseMode ? Environment.prod : Environment.dev);
  commonMain();
}

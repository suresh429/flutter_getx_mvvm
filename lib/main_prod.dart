
import 'common_main.dart';
import "package:flutter_getx_mvvm/env/app_env.dart";

void main() {
  AppEnvironment.setupEnv(Environment.prod);
  commonMain();
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_mvvm/env/app_env.dart';
import 'package:flutter_getx_mvvm/view/explore_screen.dart';
import 'package:flutter_getx_mvvm/view/login_view.dart';
import 'package:flutter_getx_mvvm/view/main_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void commonMain() async{
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Change this to your desired color
    statusBarIconBrightness: Brightness.dark, // Change icon brightness
  ));

  // local storage
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final storage = GetStorage(); // Access GetStorage
    bool isLoggedIn  = storage.read('isLoggedIn') ?? false;
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFEC1C24), // Set your primary color
        colorScheme: const ColorScheme(
          primary: Color(0xFFEC1C24), // Primary color
          secondary: Colors.white, // Secondary color (can be different)
          surface: Color(0xFFE5E5E5), // Background color
          error: Colors.red, // Error color
          onPrimary: Colors.white, // Text color on primary
          onSecondary: Colors.white, // Text color on secondary
          onSurface: Colors.black, // Text color on background
          onError: Colors.white, // Text color on error
          brightness: Brightness.light, // Light or dark theme

        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Solid color for all AppBars
          foregroundColor: Colors.black, // Text and icon color
          elevation: 1, // Customize elevation if desired
          surfaceTintColor: Colors.white, // Avoids overlay effects in Material 3
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFEC1C24), // Solid color for all FABs
          foregroundColor: Colors.white, // Text and icon color in FAB
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFFEC1C24)), // Solid color for all ElevatedButtons
            foregroundColor: MaterialStateProperty.all(Colors.white), // Text color
          ),
        ),
      ),
      home: isLoggedIn ? MainScreen() : const LoginView(),
      getPages: [
        GetPage(name: '/', page: () => const LoginView()),
        GetPage(name: '/home', page: () => MainScreen()), // Define your home screen
        GetPage(name: '/explore', page: () => const ExploreScreen()),
      ],
    );
  }
}



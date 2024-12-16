import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_mvvm/view/explore_screen.dart';
import 'package:flutter_getx_mvvm/view/login_view.dart';
import 'package:flutter_getx_mvvm/view/main_screen.dart';
import 'package:flutter_getx_mvvm/view/manage_preferences.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'utilites/colors.dart';

void commonMain() async {
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
    bool isLoggedIn = storage.read('isLoggedIn') ?? false;
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorUtils.colorPrimary,
        // Set your primary color
        colorScheme: ColorScheme(
          primary: ColorUtils.colorPrimary,
          // Primary color
          secondary: Colors.white,
          // Secondary color (can be different)
          surface: ColorUtils.colorSurface,
          // Background color
          error: Colors.red,
          // Error color
          onPrimary: Colors.white,
          // Text color on primary
          onSecondary: Colors.white,
          // Text color on secondary
          onSurface: ColorUtils.colorSurface,
          // Text color on background
          onError: Colors.white,
          // Text color on error
          brightness: Brightness.light, // Light or dark theme
        ),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Solid color for all AppBars
          foregroundColor: Colors.black, // Text and icon color
          elevation: 1, // Customize elevation if desired
          surfaceTintColor:
              Colors.white, // Avoids overlay effects in Material 3
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorUtils.colorPrimary, // Solid color for all FABs
          foregroundColor: Colors.white, // Text and icon color in FAB
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ColorUtils.colorPrimary),
            // Solid color for all ElevatedButtons
            foregroundColor:
                MaterialStateProperty.all(Colors.white), // Text color
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey, width: 1.0), // Default border color
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey, width: 1.0), // Enabled border color
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorUtils.colorPrimary, width: 2.0), // Focused border color
          ),
          errorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.red, width: 1.0), // Error border color
          ),
          hintStyle: TextStyle(color: ColorUtils.colorGray),
          // Hint text style
          labelStyle: const TextStyle(color: Colors.grey), // Label text style
        ),
      ),
      home: isLoggedIn ? MainScreen() : const LoginView(),
      getPages: [
        GetPage(name: '/', page: () => const LoginView()),
        GetPage(name: '/home', page: () => MainScreen()),
        // Define your home screen
        GetPage(name: '/explore', page: () => ExploreScreen()),
        GetPage(name: '/managePref', page: () => const ManagePreferences()),
      ],
    );
  }
}

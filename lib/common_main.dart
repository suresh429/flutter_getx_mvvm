import 'package:TALLeaders/view/comment_reply_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:TALLeaders/service/ConnectivityService.dart';
import 'package:TALLeaders/view/comments_screen.dart';
import 'package:TALLeaders/view/details_screen.dart';
import 'package:TALLeaders/view/explore_screen.dart';
import 'package:TALLeaders/view/login_view.dart';
import 'package:TALLeaders/view/main_screen.dart';
import 'package:TALLeaders/view/manage_preferences.dart';
import 'package:TALLeaders/view/public_profile_screen.dart';
import 'package:TALLeaders/view/settings_screen.dart';
import 'package:TALLeaders/view/user_profile_screen.dart';
import 'package:TALLeaders/view_model/explore_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'utilites/colors.dart';


void commonMain() async {
  WidgetsFlutterBinding.ensureInitialized(); // VERY IMPORTANT

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Change this to your desired color
    statusBarIconBrightness: Brightness.dark, // Change icon brightness
  ));

  Get.put(ConnectivityService()); // Initialize the ConnectivityService
  // local storage
  await GetStorage.init();

  // firebase initialization with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase initialized');


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
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
      initialRoute: isLoggedIn ? '/main' : '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/main', page: () => MainScreen()),  // removed const
        GetPage(name: '/details', page: () => const DetailsScreen()),
        GetPage(name: '/explore', page: () => ExploreScreen()),
        GetPage(name: '/managePref', page: () => const ManagePreferences()),
        GetPage(name: '/settings', page: () => SettingsScreen()),
        GetPage(name: '/userProfile', page: () => ProfileScreen()),
        GetPage(name: '/comments', page: () => const CommentsScreen()),
        GetPage(name: '/publicProfile', page: () =>  const PublicProfileScreen()),
        GetPage(name: '/commentReply', page: () =>   CommentReplyPage()),

      ],
    );
  }
}

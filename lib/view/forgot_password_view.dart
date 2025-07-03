import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../env/app_env.dart';
import '../utilites/colors.dart';
import '../utilites/constants_Utils.dart';
import '../view_model/login_controller.dart';
class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    // Lazily initializes the controller the first time it's accessed
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Image
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recover Account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Choose whether you want to recover your account email or password."),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    Get.toNamed('/recoverEmailPassword',
                      arguments: {'title': 'Recover Email'}); // Pass index if needed);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,  // outline color
                        width: 1,            // outline thickness
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Recover Email',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text('Keep the email you used while registering on TALLeaders handy.'),
                        ),
                        trailing: Icon(Icons.arrow_forward, color: Colors.grey),
                        ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.toNamed('/recoverEmailPassword',
                        arguments: {'title': 'Recover Password'});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,  // outline color
                        width: 1,            // outline thickness
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Recover Password',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text('Keep your touchalife email id handy.'),
                        ),
                        trailing: Icon(Icons.arrow_forward, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Return to sign in",
                      style: TextStyle(
                        color: ColorUtils.colorPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

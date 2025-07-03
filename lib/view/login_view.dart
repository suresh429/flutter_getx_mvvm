import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../env/app_env.dart';
import '../utilites/colors.dart';
import '../utilites/constants_Utils.dart';
import '../view_model/login_controller.dart';
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Lazily initializes the controller the first time it's accessed
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Image
                Image.asset(
                  'assets/app_logo.png', // Ensure this path is correct
                  height: 40,
                ),
                const SizedBox(height: 70),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("You can only use touchalife email"),
                ),
                const SizedBox(height: 40),
                // Email Field
                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    suffix: Text(
                      controller.domain,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
                Obx(() => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        controller.isPasswordHidden.toggle();
                      },
                    ),
                  ),
                )),
                const SizedBox(height: 15),
                 Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: (){
                      Get.toNamed('/forgotPassword');
                    },
                      child: const Text("Forgot Password/Email?")),
                ),
                const SizedBox(height: 20),

                // Login Button with Loading State
                Obx(() {
                  return ElevatedButton(
                    onPressed:
                        controller.isLoading.value ? null : controller.login,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45),
                      // Full-width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          5,
                        ), // Set the radius to 5
                      ),
                    ),
                    child:
                        controller.isLoading.value
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                  );
                }),
                const SizedBox(height: 30),
                const Text("Don't have a TALLeaders Account?"),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    ConstantsUtils.launchURL('${AppEnvironment.baseWebUrl}become-a-TALLeader', context);
                  },
                  child: Text(
                    "Become a TALLeader",
                    style: TextStyle(
                      color: ColorUtils.colorPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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

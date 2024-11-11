import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/env/app_env.dart';
import 'package:get/get.dart';
import '../view_model/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: const Text('Login'),
       // backgroundColor: Colors.deepPurple,
      ),*/
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
                  height: 50,
                ),
                const SizedBox(height: 40),

                // Email Field
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),

                // Login Button with Loading State
                Obx(() {
                  return ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.login,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 45), // Full-width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Set the radius to 5
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text('Login',style: TextStyle(color: Colors.white),),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

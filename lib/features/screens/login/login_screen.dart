import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrp/features/screens/login/login_form_widgets.dart';
import 'package:mrp/features/screens/login/login_header_widgets.dart';
import 'package:mrp/src/constants/image_strings.dart';  // Import the constants file where GoogleLogoImage is defined
import 'package:mrp/src/constants/sizes.dart';
import 'package:mrp/src/constants/text_strings.dart';
import 'package:mrp/features/screens/signUp/sign_up_screen.dart';
import 'package:mrp/features/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginHeaderWidgets(size: size),
                const LoginForm(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("OR"),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Image(
                          image: AssetImage("assets/logo/google_logo.png"),  // Use the constant here
                          width: 20.0,
                        ),
                        onPressed: () {
                          // Google sign-in functionality here
                        },
                        label: const Text("Sign Up with Google"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Use GetX for navigation
                    Get.offAll(() => HomeScreen());
                  },
                  child: const Text("Customer"),
                ),
                TextButton(
                  onPressed: () {
                    // Use GetX for navigation
                    Get.to(() => SignUpScreen());
                  },
                  child: Text.rich(
                    TextSpan(
                      text: dontHaveAnAccount,
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: signup,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
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

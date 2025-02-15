import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../src/constants/image_strings.dart';
import 'sign_up_form_widgets.dart';
import 'signup_header_widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                SignupHeaderWidgets(size: size),

                // Sign-up form section
                SignUpForm(),

                // OR divider
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("OR"),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: Image.asset(
                          GoogleLogoImage, // Use the Google logo constant here
                          width: 20.0,
                        ),
                        onPressed: () {
                          // Implement Google sign-in functionality here
                        },
                        label: const Text("Sign Up with Google"),
                      ),
                    ),
                  ],
                ),

                // Spacer for additional space before text button
                const SizedBox(height: 20),

                // Login redirection
                TextButton(
                  onPressed: () {
                    Get.back(); // Go back to the previous screen
                  },
                  child: const Text('Already have an account? Log in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

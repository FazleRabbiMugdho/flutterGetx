import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrp/features/screens/signUp/sign_up_form_widgets.dart';
import 'package:mrp/features/screens/signUp/signup_header_widgets.dart';
import 'package:mrp/src/constants/image_strings.dart';
import 'package:mrp/src/constants/sizes.dart';
import 'package:mrp/src/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                SignupHeaderWidgets(size: size),
                const SignUpForm(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("OR"),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Image(
                          image: AssetImage(GoogleLogoImage),
                          width: 20.0,
                        ),
                        onPressed: () {},
                        label: Text(stringInWithGoogle),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: formHeight - 20),
                TextButton(
                  onPressed: () {
                    // Use GetX for navigation
                    Get.back();
                  },
                  child: Text.rich(
                    TextSpan(
                      text: alreadyHaveAnAccount,
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: login,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrp/src/constants/text_strings.dart';
import 'package:mrp/features/screens/signUp/sign_up_controller.dart';

import '../../../src/constants/sizes.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController()); // Instantiate the controller

    return Form(
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              signUpController.fullName.value = value;
            },
            decoration: const InputDecoration(labelText: "Full Name"),
          ),
          const SizedBox(height: formHeight - 10),
          TextFormField(
            onChanged: (value) {
              signUpController.email.value = value;
            },
            decoration: const InputDecoration(labelText: "Email"),
          ),
          const SizedBox(height: formHeight - 10),
          TextFormField(
            onChanged: (value) {
              signUpController.password.value = value;
            },
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          const SizedBox(height: formHeight - 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                signUpController.signUp();
              },
              child: const Text("Sign Up"),
            ),
          ),
        ],
      ),
    );
  }
}

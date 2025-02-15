import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrp/src/constants/text_strings.dart';
import 'package:mrp/features/screens/login/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController()); // Instantiate the controller

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) {
            loginController.email.value = value;
          },
          decoration: const InputDecoration(
            labelText: email,
          ),
        ),
        const SizedBox(height: 20),
        Obx(() => TextField(
          onChanged: (value) {
            loginController.password.value = value;
          },
          obscureText: true,
          decoration: InputDecoration(
            labelText: password,
            errorText: loginController.password.value.isEmpty
                ? 'Password cannot be empty'
                : null,
          ),
        )),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            loginController.login();
          },
          child: const Text("Login"),
        ),
      ],
    );
  }
}

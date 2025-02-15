import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sign_up_controller.dart';

class SignUpForm extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) => controller.fullName.value = value, // Full Name input
          decoration: const InputDecoration(labelText: 'Full Name'),
        ),
        TextField(
          onChanged: (value) => controller.email.value = value,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          onChanged: (value) => controller.password.value = value,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Password'),
        ),
        TextField(
          onChanged: (value) => controller.confirmPassword.value = value, // Confirm Password input
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Confirm Password'),
        ),
        TextField(
          onChanged: (value) => controller.phoneNumber.value = value, // Phone number input
          decoration: const InputDecoration(labelText: 'Phone Number'),
        ),
        Obx(
              () => DropdownButtonFormField<String>(
            value: controller.selectedRole.value,
            items: controller.roles
                .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                .toList(),
            onChanged: (value) => controller.selectedRole.value = value!,
            decoration: const InputDecoration(labelText: 'Role'),
          ),
        ),
        Obx(
              () => DropdownButtonFormField<String>(
            value: controller.selectedLocation.value,
            items: controller.locations
                .map((location) => DropdownMenuItem(value: location, child: Text(location)))
                .toList(),
            onChanged: (value) => controller.selectedLocation.value = value!,
            decoration: const InputDecoration(labelText: 'Location'),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: controller.signUp,
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}

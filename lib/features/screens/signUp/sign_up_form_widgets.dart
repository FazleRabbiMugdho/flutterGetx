import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sign_up_controller.dart';

class SignUpForm extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full Name input with icon
          _buildTextField(
            label: 'Full Name',
            onChanged: (value) => controller.fullName.value = value,
            icon: Icons.person,
          ),

          // Email input with icon
          _buildTextField(
            label: 'Email',
            onChanged: (value) => controller.email.value = value,
            icon: Icons.email,
          ),

          // Password input with icon
          _buildTextField(
            label: 'Password',
            onChanged: (value) => controller.password.value = value,
            obscureText: true,
            icon: Icons.lock,
          ),

          // Confirm Password input with icon
          _buildTextField(
            label: 'Confirm Password',
            onChanged: (value) => controller.confirmPassword.value = value,
            obscureText: true,
            icon: Icons.lock_outline,
          ),

          // Phone Number input with icon
          _buildTextField(
            label: 'Phone Number',
            onChanged: (value) => controller.phoneNumber.value = value,
            keyboardType: TextInputType.phone,
            icon: Icons.phone,
          ),

          // Role Dropdown with icon (Administrator or Merchant)
          Obx(
                () => _buildDropdown(
              label: 'Role',
              value: controller.selectedRole.value,
              items: controller.roles,
              onChanged: (value) => controller.selectedRole.value = value!,
              icon: Icons.account_circle,
            ),
          ),

          // Location Dropdown with icon
          Obx(
                () => _buildDropdown(
              label: 'Location',
              value: controller.selectedLocation.value,
              items: controller.locations,
              onChanged: (value) => controller.selectedLocation.value = value!,
              icon: Icons.location_on,
            ),
          ),

          const SizedBox(height: 30), // Spacing between form and button

          // Updated Sign Up button with an icon
          ElevatedButton.icon(
            onPressed: controller.signUp,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
              backgroundColor: Colors.white, // White background for button
              foregroundColor: Colors.blue.shade800, // Text color blue
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Rounded corners
              ),
              elevation: 10, // Subtle elevation
              shadowColor: Colors.blueAccent, // Subtle shadow for depth
            ),
            icon: Icon(Icons.person_add, size: 24), // Person Add icon
            label: const Text(
              'Sign Up',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build text fields with icons
  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required IconData icon,
    TextEditingController? controller,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blue.shade700),
          prefixIcon: Icon(icon, color: Colors.blue.shade700), // Icon for the field
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  // Helper method to build dropdown fields with icons
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blue.shade700),
          prefixIcon: Icon(icon, color: Colors.blue.shade700), // Icon for dropdown
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}

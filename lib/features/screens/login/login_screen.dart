import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrp/src/constants/image_strings.dart';
import '../signUp/sign_up_screen.dart';
import 'login_controller.dart'; // Your login controller

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController()); // Instantiate the controller
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section with image and text (matching sign-up page)
                _buildLoginHeader(context, size),

                const SizedBox(height: 40), // Spacing between header and form

                // Login form section
                _buildTextField(
                  label: 'Email',
                  onChanged: (value) => loginController.email.value = value,
                  icon: Icons.email,
                ),
                _buildTextField(
                  label: 'Password',
                  onChanged: (value) => loginController.password.value = value,
                  obscureText: true,
                  icon: Icons.lock,
                ),

                const SizedBox(height: 30), // Spacing between form and button

                // Login button with icon and modern style
                ElevatedButton.icon(
                  onPressed: () {
                    loginController.login(); // Trigger login
                  },
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
                  icon: Icon(Icons.login, size: 24), // Login icon
                  label: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 20), // Spacing between button and text button

                // "Don't have an account?" text button to navigate to sign-up screen
                TextButton(
                  onPressed: () {
                    Get.to(() => SignUpScreen()); // Navigate to Sign-Up screen
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      children: [
                        TextSpan(
                          text: 'Sign Up',
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

  // Helper method to build the login header (same as sign-up page)
  Widget _buildLoginHeader(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          WelcomeScreenImage,
          height: size.height * 0.2,
        ),
        const SizedBox(height: 20),
        Text(
          'Welcome Back!',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please log in to continue.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // Helper method to build text fields with icons (same as sign-up page)
  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    bool obscureText = false,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        onChanged: onChanged,
        obscureText: obscureText,
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
}

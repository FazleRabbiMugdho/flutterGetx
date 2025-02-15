import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home_screen.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;  // To handle loading state

  // Add a method to handle login logic
  Future<void> login() async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        isLoading.value = true;

        // Perform login using Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.value,
          password: password.value,
        );

        // Handle success (user is logged in)
        if (userCredential.user != null) {
          Get.snackbar("Success", "Login Successful");
          // Navigate to the home screen or any other page
          Get.offAll(() => HomeScreen());
        } else {
          Get.snackbar("Error", "Failed to log in.");
        }
      } catch (e) {
        // Handle errors (invalid credentials, network issues, etc.)
        Get.snackbar("Error", "Failed to log in: ${e.toString()}");
      } finally {
        isLoading.value = false;  // Stop loading state
      }
    } else {
      // Show error if email or password is empty
      Get.snackbar("Error", "Please enter both email and password.");
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'AdminScreen.dart';
import 'BuyerAndSeller.dart';


class LoginController extends GetxController {
  // Add a reactive variable for user inputs
  var email = ''.obs;
  var password = ''.obs;

  // Function to handle login
  Future<void> login() async {
    try {
      if (email.value.isEmpty || password.value.isEmpty) {
        Get.snackbar('Error', 'Please fill in both email and password');
        return;
      }

      // Sign in the user using Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      if (userCredential.user != null) {
        // Successfully logged in, now check the user's role in Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (!userDoc.exists) {
          Get.snackbar('Error', 'User data not found');
          return;
        }

        // Fetch the 'role' field safely
        String role = userDoc['role'] ?? '';  // Use default value if not found

        // Handle roles:
        if (role == 'Administrator') {
          Get.offAll(() => AdminScreen()); // Navigate to Admin screen
        } else if (role == 'Merchant') {
          Get.offAll(() => Buyerandseller()); // Navigate to Merchant dashboard
        } else {
          // If role is invalid or not found
          Get.snackbar('Error', 'Invalid role');
        }
      } else {
        Get.snackbar('Error', 'Failed to log in');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    }
  }
}

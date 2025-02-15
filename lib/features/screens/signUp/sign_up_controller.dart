import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;  // Added confirmPassword field
  var fullName = ''.obs; // Added full name field
  var selectedRole = 'Administrator'.obs; // Changed to Administrator and Merchant roles
  var selectedLocation = 'Dhaka'.obs;
  var phoneNumber = ''.obs;
  var uniqueId = ''.obs;  // Field for unique ID

  List<String> roles = ['Administrator', 'Merchant']; // Updated roles
  List<String> locations = ['Dhaka', 'Chattogram', 'Khulna', 'Rajshahi', 'Barishal', 'Sylhet', 'Rangpur'];

  // This method will handle the sign-up process
  Future<void> signUp() async {
    // Password and confirm password validation
    if (password.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match!');
      return;
    }

    // Ensure all required fields are filled
    if (fullName.value.isEmpty || email.value.isEmpty || phoneNumber.value.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields!');
      return;
    }

    // Generate unique ID based on selected role
    generateUniqueId();

    try {
      // Create user using email and password from Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      // Save user data to Firestore (including full name, role, location, phone number, unique ID)
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'full_name': fullName.value,  // Save full name
        'email': email.value,
        'role': selectedRole.value,
        'location': selectedLocation.value,
        'phone_number': phoneNumber.value, // Save phone number
        'unique_id': uniqueId.value,  // Save unique ID
      });

      // Notify the user of the successful sign-up
      Get.snackbar('Success', 'Sign Up Successful!');
    } catch (e) {
      // Show an error message if sign-up fails
      Get.snackbar('Error', 'Failed to sign up: $e');
    }
  }

  // Generate unique ID based on role (Administrator or Merchant)
  void generateUniqueId() {
    // Generate unique ID for Admin or Merchant based on the current timestamp
    if (selectedRole.value == 'Administrator') {
      uniqueId.value = 'ADM${DateTime.now().millisecondsSinceEpoch}';
    } else if (selectedRole.value == 'Merchant') {
      uniqueId.value = 'MER${DateTime.now().millisecondsSinceEpoch}';
    }
  }
}

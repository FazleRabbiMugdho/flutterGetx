import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;  // Added confirmPassword field
  var fullName = ''.obs; // Added full name field
  var selectedRole = 'Buyer'.obs;
  var selectedLocation = 'Dhaka'.obs;
  var phoneNumber = ''.obs;

  List<String> roles = ['Administrator', 'Buyer', 'Seller'];
  List<String> locations = ['Dhaka', 'Chattogram', 'Khulna', 'Rajshahi', 'Barishal', 'Sylhet', 'Rangpur'];

  // This method will handle the sign-up process
  Future<void> signUp() async {
    // Password and confirm password validation
    if (password.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match!');
      return;
    }

    try {
      // Create user using email and password from Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      // Save user data to Firestore (including full name, role, location, phone number)
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'full_name': fullName.value,  // Save full name
        'email': email.value,
        'role': selectedRole.value,
        'location': selectedLocation.value,
        'phone_number': phoneNumber.value, // Save phone number
      });

      // Notify the user of the successful sign-up
      Get.snackbar('Success', 'Sign Up Successful!');
    } catch (e) {
      // Show an error message if sign-up fails
      Get.snackbar('Error', 'Failed to sign up: $e');
    }
  }
}

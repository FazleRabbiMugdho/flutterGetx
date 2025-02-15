import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrp/features/screens/login/login_screen.dart';

class LogOutPage extends StatelessWidget {
  const LogOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Log Out")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut(); // Sign out from Firebase
            Get.offAll(() => LoginScreen()); // Redirect to login screen
          },
          child: const Text("Log Out"),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthService extends GetxController {
  // Observables to hold user authentication state and errors
  var isSignedIn = false.obs;
  var user = Rx<User?>(null);
  var errorMessage = ''.obs;

  // FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up method with email and password
  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = userCredential.user;
      isSignedIn.value = true;
      Get.snackbar('Success', 'Account created successfully!');
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'An error occurred';
      Get.snackbar('Error', errorMessage.value);
    }
  }

  // Login method with email and password
  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      // Sign in user with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = userCredential.user;
      isSignedIn.value = true;
      Get.snackbar('Success', 'Login successful!');
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'An error occurred';
      Get.snackbar('Error', errorMessage.value);
    }
  }

  // Sign Out method
  Future<void> signOut() async {
    await _auth.signOut();
    user.value = null;
    isSignedIn.value = false;
    Get.snackbar('Success', 'Logged out successfully!');
  }
}

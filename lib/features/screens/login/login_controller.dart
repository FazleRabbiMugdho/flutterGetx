import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  // Add a method to handle login logic if needed
  void login() {
    if (email.isNotEmpty && password.isNotEmpty) {
      // Perform login logic
    } else {
      // Handle errors
    }
  }
}

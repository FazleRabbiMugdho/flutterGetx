import 'package:get/get.dart';

class SignUpController extends GetxController {
  var fullName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  // Add a method to handle sign-up logic if needed
  void signUp() {
    if (fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // Perform sign-up logic
    } else {
      // Handle errors
    }
  }
}

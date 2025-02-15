import 'package:flutter/material.dart';
import 'package:mrp/src/constants/image_strings.dart';
import 'package:mrp/src/constants/text_strings.dart';

class SignupHeaderWidgets extends StatelessWidget {
  const SignupHeaderWidgets({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the header image for the signup screen
        Image(
          image: const AssetImage(WelcomeScreenImage), // You can use the same image or a different one
          height: size.height * 0.2,
        ),
        // Title and subtitle for Sign Up
        Text(signupTitle, style: Theme.of(context).textTheme.displayLarge),
        Text(signupSubTitle, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

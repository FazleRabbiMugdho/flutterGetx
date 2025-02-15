import 'package:flutter/material.dart';

import '../../../src/constants/image_strings.dart';

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
        Image(
          image: const AssetImage(WelcomeScreenImage),
          height: size.height * 0.2,
        ),
        Text(
          'Sign Up',
          style: Theme.of(context).textTheme.headlineLarge, // Using theme for header
        ),
        Text(
          'Create a new account to get started',
          style: Theme.of(context).textTheme.bodyLarge, // Using theme for subtitle
        ),
      ],
    );
  }
}

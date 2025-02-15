import 'package:mrp/src/constants/image_strings.dart';
import 'package:mrp/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class LoginHeaderWidgets extends StatelessWidget {
  const LoginHeaderWidgets({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image(
        image: const AssetImage(WelcomeScreenImage),
        height: size.height * 0.2,
      ),
      Text(loginTitle, style: Theme.of(context).textTheme.displayLarge),
      Text(loginSubTitle, style: Theme.of(context).textTheme.bodyLarge),
    ]);
  }
}

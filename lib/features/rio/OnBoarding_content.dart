import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingContent extends StatelessWidget {
  final String animation;
  final String title;
  final String description;

  const OnboardingContent({
    Key? key,
    required this.animation,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Lottie.asset(
                  animation,
                  height: constraints.maxHeight * 0.4,
                  width: constraints.maxWidth * 0.8,
                  repeat: true,
                  animate: true,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

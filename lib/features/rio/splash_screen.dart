import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrp/features/rio/onboarding_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset(
          'assets/animations/Splash.json',
        ),
      ),
      nextScreen: const OnboardingPage(), // Navigate to Onboarding
      duration: 2000,
      backgroundColor: Colors.lightBlueAccent,
      splashIconSize: 200,
      animationDuration: const Duration(seconds: 1),
    );
  }
}

import 'package:flutter/material.dart';

class OnboardingDot extends StatelessWidget {
  final int currentIndex;
  final int dotIndex;

  const OnboardingDot({
    super.key,
    required this.currentIndex,
    required this.dotIndex,
  });

  static const Duration animationDuration = Duration(milliseconds: 200);
  static const EdgeInsets dotMargin = EdgeInsets.only(right: 5);
  static const double dotHeight = 10;
  static const double activeDotWidth = 20;
  static const double inactiveDotWidth = 10;
  static const BorderRadius dotBorderRadius = BorderRadius.all(Radius.circular(5));

  @override
  Widget build(BuildContext context) {
    final bool isActive = currentIndex == dotIndex;
    final Color activeColor = Theme.of(context).colorScheme.primary;
    final Color inactiveColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.5);

    return Semantics(
      label: "Page ${dotIndex + 1} indicator, ${isActive ? "selected" : "not selected"}",
      child: AnimatedContainer(
        duration: animationDuration,
        margin: dotMargin,
        height: dotHeight,
        width: isActive ? activeDotWidth : inactiveDotWidth,
        decoration: BoxDecoration(
          color: isActive ? activeColor : inactiveColor,
          borderRadius: dotBorderRadius,
        ),
      ),
    );
  }
}

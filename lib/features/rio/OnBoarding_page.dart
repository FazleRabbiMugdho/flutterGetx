import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrp/features/screens/login/login_screen.dart';
import 'package:mrp/features/rio/OnBoarding_content.dart';
import 'package:mrp/features/rio/OnBoarding_dot.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  void goToNextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      Get.to(() => LoginScreen(), transition: Transition.fadeIn);
    }
  }

  void setPage(int index) {
    currentPage.value = index;
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    final List<Map<String, String>> onboardingData = [
      {
        "animation": "assets/OnBoarding gifs/ONboarding1.json",
        "title": "Welcome to MRP App",
        "description": "Discover amazing features and tools to track prices in a marketplace reliably."
      },
      {
        "animation": "assets/OnBoarding gifs/ONboarding2.json",
        "title": "Stay Organized",
        "description": "Keep track of your nearest market price to make life comfortable."
      },
      {
        "animation": "assets/OnBoarding gifs/ONboarding3.json",
        "title": "Get Started",
        "description": "Join our community and start your journey today."
      },
    ];

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.setPage,
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => OnboardingContent(
                  animation: onboardingData[index]["animation"]!,
                  title: onboardingData[index]["title"]!,
                  description: onboardingData[index]["description"]!,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                          (index) => OnboardingDot(
                        currentIndex: controller.currentPage.value,
                        dotIndex: index,
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: controller.goToNextPage,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: Obx(() => Text(
                        controller.currentPage.value == onboardingData.length - 1
                            ? "Get Started"
                            : "Next",
                        style: const TextStyle(fontSize: 16),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

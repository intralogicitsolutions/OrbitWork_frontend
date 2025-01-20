import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../routes/app_routes.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // PageView for swiping between pages
          Expanded(
            flex: 4,
            child: PageView(
              controller: _pageController,
              children: [
                buildPage(
                  image: 'assets/images/onboarding1.jpg',
                  title: 'Welcome to Orbitwork',
                  subtitle: 'Find the best jobs and grow your career.',
                ),
                buildPage(
                  image: 'assets/images/onboarding2.jpg',
                  title: 'Collaborate with Professionals',
                  subtitle: 'Connect with top clients worldwide.',
                ),
                buildPage(
                  image: 'assets/images/onboarding3.jpg',
                  title: 'Achieve Success',
                  subtitle: 'Take the next step in your freelance journey.',
                ),
              ],
            ),
          ),
          // SmoothPageIndicator
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.green,
                dotColor: Colors.grey,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.login); // Navigate to Login Page
              },
              child: Text("Login", style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.signup); // Navigate to Signup Page
              },
              child: RichText(
                text: TextSpan(
                  text: 'New to Orbitwork? ',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each onboarding page
  Widget buildPage({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 200,
          width: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

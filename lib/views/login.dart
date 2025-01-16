import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Orbitwork',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Subtitle
              const Text(
                'Log in to Orbitwork',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                onChanged: (value) => controller.username.value = value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline),
                  hintText: 'Username or Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Continue Button
              ElevatedButton(
                onPressed: () {
                  // Add login functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              // Divider with "or"
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('or'),
                  ),
                  const Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                },
                icon: Image.asset(
                  'assets/icon/google.png',
                  height: 20,
                  width: 20,
                ),
                label: const Text('Continue with Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Colors.black12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {

                },
                icon: const Icon(
                  Icons.apple,
                  size: 24,
                  color: Colors.black,
                ),
                label: const Text('Continue with Apple'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Colors.black12),
                  ),
                ),
              ),
              const Spacer(),
              // Footer
              // const Text(
              //   'Upwork uses cookies for analytics, personalized\ncontent, and ads. By using Upwork\'s services, you\nagree to this use of cookies.',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 12, color: Colors.black54),
              // ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}


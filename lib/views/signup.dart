import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/widgets/custom_textfeild.dart';
import '../controllers/signup_controller.dart';
import '../routes/app_routes.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orbitwork'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Sign up to find work you love",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle Google Sign-In
                  Get.snackbar('Google Sign-In', 'Google Sign-In clicked!');
                },
                icon: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icon/google.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                label: Text("Continue with Google",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue.shade700,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 20),
              // CustomTextField(hintText: "First Name",onChanged: (value) => controller.firstName.value = value,),
              TextField(
                onChanged: (value) => controller.firstName.value = value,
                decoration: InputDecoration(labelText: "First Name"),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) => controller.lastName.value = value,
                decoration: InputDecoration(labelText: "Last Name"),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) => controller.email.value = value,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              Obx(() => TextField(
                onChanged: (value) => controller.password.value = value,
                decoration: InputDecoration(
                  labelText: "Password (8 or more characters)",
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.password.isEmpty ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      // Handle password visibility toggle
                    },
                  ),
                ),
                obscureText: true,
              )),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: controller.country.value,
                onChanged: (value) => controller.country.value = value!,
                items: ["India", "USA", "UK", "Australia", "Canada"]
                    .map((country) => DropdownMenuItem(
                  value: country,
                  child: Text(country),
                ))
                    .toList(),
                decoration: InputDecoration(labelText: "Country"),
              ),
              SizedBox(height: 10),
              Obx(() => CheckboxListTile(
                value: controller.sendEmails.value,
                onChanged: (value) => controller.sendEmails.value = value!,
                title: Text("Send me helpful emails to find rewarding work and job leads."),
              )),
              Obx(() => CheckboxListTile(
                value: controller.agreeToTerms.value,
                onChanged: (value) => controller.agreeToTerms.value = value!,
                title: RichText(
                  text: TextSpan(
                    text: "Yes, I understand and agree to the ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Terms of Service",
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(
                        text: " including the User Agreement and Privacy Policy.",
                      ),
                    ],
                  ),
                ),
              )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.submitForm,
                child: Text("Sign Up"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(
                        text: "Log In",
                        style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to login page
                            Get.toNamed(AppRoutes.login); // Ensure '/login' is defined in your GetX routes
                          },
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

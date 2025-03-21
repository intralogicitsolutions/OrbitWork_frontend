import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/widgets/custom_textfeild.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/signup_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_dropdown.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  Future<void> _launch(Uri  urlString) async {
    if (await canLaunchUrl(urlString)) {
      await launchUrl(urlString);
    } else {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFFDF6F0),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Orbitwork',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
       // backgroundColor: Color(0xFFFDF6F0),
        backgroundColor: Colors.white,
        elevation: 0,
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle Google Sign-In
                  Get.snackbar('Google Sign-In', 'Google Sign-In clicked!');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
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
                    ),
                    Text(
                      "Continue with Google",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade400)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade400)),
                ],
              ),
              SizedBox(height: 20),
              CustomTextField(label: "First Name", onChanged: (value) => controller.firstName.value = value,),

              SizedBox(height: 10),
              CustomTextField(label: "Last Name", onChanged: (value) => controller.lastName.value = value,),

              SizedBox(height: 10),
              CustomTextField(label:  "Email", onChanged: (value) => controller.email.value = value,),

              SizedBox(height: 10),
              Obx(
                    () => _buildTextField(
                  label: "Password (8 or more characters)",
                  obscureText: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.password.isEmpty
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {
                      // Toggle password visibility
                    },
                  ),
                  onChanged: (value) => controller.password.value = value,
                ),
              ),
              SizedBox(height: 10),
              CustomDropdown(),
              SizedBox(height: 10),
              Obx(() => CheckboxListTile(
                value: controller.sendEmails.value,
                onChanged: (value) => controller.sendEmails.value = value!,
                title: Text(
                  "Send me helpful emails to find rewarding work and job leads.",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.green,
                contentPadding: EdgeInsets.zero,
              )),
              Obx(() => CheckboxListTile(
                value: controller.agreeToTerms.value,
                onChanged: (value) =>
                controller.agreeToTerms.value = value!,
                title: RichText(
                  text: TextSpan(
                    text: "Yes, I understand and agree to the ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Terms of Service",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            var url = Uri.parse('https://www.google.com');
                            await _launch(url);
                          },
                      ),
                      TextSpan(
                        text:
                        " including the User Agreement and Privacy Policy.",
                      ),
                    ],
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.green,
                contentPadding: EdgeInsets.zero,
              )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.signUpUser,
                //onPressed: controller.submitForm,
                child: controller.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white) :Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(AppRoutes.login,
                                arguments: {'fromSignUp': true});
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

  Widget _buildTextField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    required Function(String) onChanged,
  }) {
    return TextField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

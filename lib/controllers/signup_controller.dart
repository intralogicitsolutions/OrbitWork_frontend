import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../enum/user_role_enum.dart';
import '../repository/api/api_constants.dart';
import '../routes/app_routes.dart';

class SignUpController extends GetxController{
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var role = ''.obs;
  var country = 'India'.obs;
  var sendEmails = false.obs;
  var agreeToTerms = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final UserRole? selectedRole = Get.arguments;
    if (selectedRole != null) {
      role.value = selectedRole == UserRole.FREELANCER ? "1" : "2";
    }
    print('user role ====> ${role.value}');
  }

  bool _validateFields() {
    if (firstName.value.trim().isEmpty ||
        lastName.value.trim().isEmpty ||
        email.value.trim().isEmpty ||
        password.value.trim().isEmpty) {
      Get.snackbar("Error", "All fields are required.");
      return false;
    }

    if (!email.value.isEmail) {
      Get.snackbar("Error", "Invalid email format.");
      return false;
    }

    if (password.value.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters.");
      return false;
    }

    if (!agreeToTerms.value) {
      Get.snackbar("Error", "You must agree to the terms and conditions.");
      return false;
    }

    return true;
  }

  Future<void> signUpUser() async {
    if (!_validateFields()) return;
    if (!agreeToTerms.value) {
      Get.snackbar("Error", "You must agree to the terms and conditions.");
      return;
    }
    isLoading.value = true;

    try{
      var response = await http.post(
        Uri.parse(ApiConstants.SIGNUP),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "firstname": firstName.value,
          "lastname": lastName.value,
          "email": email.value,
          "password": password.value,
          "role": role.value,
        }),
      );

      isLoading.value = false;
      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      var data = jsonDecode(response.body);


      if (response.statusCode == 200) {
        Get.snackbar("Success", "Account created successfully!");
        Get.offNamed(AppRoutes.login);
      } else {
        Get.snackbar("Error", data["message"] ?? "Signup failed. Try again.");
      }
    }catch(error){
      isLoading.value = false;
      Get.snackbar("Error", "An error occurred. Please try again.");
    }
  }

  // void submitForm() {
  //   if (firstName.isEmpty ||
  //       lastName.isEmpty ||
  //       email.isEmpty ||
  //       password.isEmpty) {
  //    // Get.offNamed(AppRoutes.jobs);
  //    //  Get.offNamed(AppRoutes.homeScreen);
  //     Get.offNamed(AppRoutes.getStarted);
  //     Get.snackbar('Error', 'Please fill in all fields.');
  //     return;
  //   }
  //   if (!agreeToTerms.value) {
  //     Get.snackbar('Error', 'You must agree to the terms.');
  //     return;
  //   }
  //   Get.snackbar('Success', 'Form submitted successfully.');
  //   //if (AppRoutes.jobs.isEmpty) {
  //   if (AppRoutes.homeScreen.isEmpty) {
  //     Get.snackbar('Error', 'Home screen route is not defined.');
  //     return;
  //   }
  //   //Get.offNamed(AppRoutes.homeScreen);
  //   //Get.toNamed(AppRoutes.jobs);
  //   // Get.toNamed(AppRoutes.homeScreen);
  //  Get.toNamed(AppRoutes.getStarted);
  //   print("First Name: $firstName");
  //   print("Last Name: $lastName");
  //   print("Email: $email");
  //   print("Password: $password");
  //   print("Country: $country");
  // }
}
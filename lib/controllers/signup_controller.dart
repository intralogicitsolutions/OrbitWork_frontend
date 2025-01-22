import 'package:get/get.dart';

import '../routes/app_routes.dart';

class SignUpController extends GetxController{
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var country = 'India'.obs;

  var sendEmails = false.obs;
  var agreeToTerms = false.obs;

  void submitForm() {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
     // Get.offNamed(AppRoutes.jobs);
      Get.offNamed(AppRoutes.homeScreen);
      Get.snackbar('Error', 'Please fill in all fields.');
      return;
    }
    if (!agreeToTerms.value) {
      Get.snackbar('Error', 'You must agree to the terms.');
      return;
    }
    Get.snackbar('Success', 'Form submitted successfully.');
    //if (AppRoutes.jobs.isEmpty) {
    if (AppRoutes.homeScreen.isEmpty) {
      Get.snackbar('Error', 'Home screen route is not defined.');
      return;
    }
    //Get.offNamed(AppRoutes.homeScreen);
    //Get.toNamed(AppRoutes.jobs);
    Get.toNamed(AppRoutes.homeScreen);
    print("First Name: $firstName");
    print("Last Name: $lastName");
    print("Email: $email");
    print("Password: $password");
    print("Country: $country");
  }
}
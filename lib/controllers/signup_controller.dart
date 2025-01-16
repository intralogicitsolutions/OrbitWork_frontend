import 'package:get/get.dart';

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
      Get.snackbar('Error', 'Please fill in all fields.');
      return;
    }
    if (!agreeToTerms.value) {
      Get.snackbar('Error', 'You must agree to the terms.');
      return;
    }

    Get.snackbar('Success', 'Form submitted successfully.');
    print("First Name: $firstName");
    print("Last Name: $lastName");
    print("Email: $email");
    print("Password: $password");
    print("Country: $country");
  }
}
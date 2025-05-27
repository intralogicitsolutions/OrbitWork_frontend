// import 'package:get/get.dart';
//
// class LoginController extends GetxController {
//   var username = ''.obs;
// }

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:orbitwork/enum/user_role_enum.dart';
import 'package:orbitwork/global/tokenStorage.dart';
import 'dart:convert';

import '../global/global.dart';
import '../repository/api/api_constants.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isEmailValid = false.obs; // Control password field visibility
  var isLoading = false.obs;

  final storage = GetStorage(); // For global token storage

  // Perform Login
  Future<void> login() async {
    if (password.value.isEmpty) {
      Get.snackbar('Error', 'Enter your password');
      return;
    }

    isLoading.value = true;
    final url = Uri.parse(ApiConstants.SIGNIN); // Update API URL

    final response = await http.post(
      url,
      body: jsonEncode({"email": email.value, "password": password.value}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["success"] == 1) {
        Global.userId = data["body"]["_id"];
        Global.userFirstname = data["body"]["firstname"];
        Global.userLastname = data["body"]["lastname"];
        Global.email = data["body"]["email"];

        Global.role = int.tryParse(data["body"]["role"].toString()) ?? 1;

        print('userId ===> ${Global.userId}');
        print('role ===> ${Global.role}');

        String token = data["body"]["token"];
        await TokenStorage.saveToken(token);
        print('token ==> ${token}');

       Get.offNamed(AppRoutes.homeScreen); // Navigate to home page

        // if (Global.role == 2) {
        //   Get.offNamed(AppRoutes.dashboard); // CLIENT
        // } else if (Global.role == 1) {
        //   Get.offNamed(AppRoutes.homeScreen); // FREELANCER
        // } else {
        //   Get.snackbar('Error', 'Unknown role. Cannot continue.');
        // }
      } else {
        Get.snackbar('Error', data["msg"]);
      }
    } else {
      Get.snackbar('Error', 'Invalid credentials');
    }
    isLoading.value = false;
  }
}

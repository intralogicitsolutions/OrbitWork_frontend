import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:orbitwork/repository/api/api_constants.dart';
import '../models/user_model.dart';

class UserController extends GetxController{
  var users = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers(); // Calls API automatically on page load
  }

  Future<void> fetchUsers() async {
    try{
      final response = await http.get(Uri.parse(ApiConstants.GET_USERS_LIST));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData["success"] == 1) {
          List<dynamic> userList = jsonData["body"];
          users.assignAll(userList.map((json) => UserModel.fromJson(json)).toList());
        }
      } else {
        Get.snackbar("Error", "Failed to fetch users");
      }

    }catch(e){
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

}
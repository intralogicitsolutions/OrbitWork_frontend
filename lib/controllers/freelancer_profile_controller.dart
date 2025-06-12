import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:orbitwork/global/global.dart';
import 'package:orbitwork/repository/api/api_constants.dart';

import '../global/tokenStorage.dart';

class FreelancerProfileController extends GetxController {
  // Fields
  var professionalRole = ''.obs;
  var uploadResume = ''.obs;
  var categories = <String>[].obs;
  var skills = <String>[].obs;
  var bio = ''.obs;
  var hourlyRate = 0.0.obs;

  // Category and Skill Options
  final availableCategories = ['Web Development', 'Mobile Apps', 'DevOps'].obs;
  final availableSkills = ['Node.js', 'React', 'Flutter', 'MongoDB'].obs;

  Future<void> pickResume() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      File file = File(result.files.single.path!);
      uploadResume.value = file.path;
    }
  }

  void toggleCategory(String category) {
    if (categories.contains(category)) {
      categories.remove(category);
    } else {
      categories.add(category);
    }
  }

  void toggleSkill(String skill) {
    if (skills.contains(skill)) {
      skills.remove(skill);
    } else {
      skills.add(skill);
    }
  }

  Future<void> submitProfile() async {
    String? token = await TokenStorage.getToken();
    final uri = Uri.parse(ApiConstants.CREATE_FREELANCER_PROFILE);

    final body = jsonEncode({
      'firstname': Global.userFirstname,
      'lastname': Global.userLastname,
      'email': Global.email,
      'upload_resume': uploadResume.value,
      'categories': categories,
      'skills': skills,
      'professional_role': professionalRole.value,
      'bio': bio.value,
      'hourly_rate': hourlyRate.value,
    });

    final response = await http.post(
      uri,
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Profile created successfully');
    } else {
      Get.snackbar('Error', 'Failed to create profile');
    }
  }
}

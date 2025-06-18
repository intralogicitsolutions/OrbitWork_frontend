
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:orbitwork/controllers/education_history_controller.dart';
import 'package:orbitwork/controllers/photo_and_location_controller.dart';
import 'package:orbitwork/controllers/profile/set_user_rate_controller.dart';
import 'package:orbitwork/controllers/profile_skill_controller.dart';
import 'package:orbitwork/controllers/profile_title_controller.dart';
import 'package:orbitwork/controllers/skill_controller.dart';
import 'package:orbitwork/controllers/work_experience_controller.dart';
import 'package:orbitwork/global/global.dart';
import 'package:orbitwork/repository/api/api_constants.dart';
import '../global/tokenStorage.dart';
import '../models/freelancer_profile_model.dart';
import 'language_controller.dart';

class FreelancerProfileController extends GetxController {
  var isLoading = false.obs;
  var profileData = Rxn<FreelancerProfile>();
  final SkillsController skillsController = Get.put(SkillsController());
  final ProfileSkillController profileSkillController = Get.put(ProfileSkillController());
  final ProfileTitleController profileTitleController = Get.put(ProfileTitleController());
  final WorkExperienceController experienceController = Get.put(WorkExperienceController());
  final EducationHistoryController educationController = Get.put(EducationHistoryController());
  final LanguageController languageController = Get.put(LanguageController());
  final bioController = TextEditingController();
  final SetUserRateController setUserRateController = Get.put(SetUserRateController());
  final PhotoAndLocationController portfolioController = Get.put(PhotoAndLocationController());



  @override
  void onClose() {
    bioController.dispose();
    super.onClose();
  }

  Future<void> createFreelancerProfile() async {
    isLoading.value = true;
    String? token = await TokenStorage.getToken();
    final url = Uri.parse(ApiConstants.CREATE_FREELANCER_PROFILE);
    final selectedCategoryNames = skillsController.selectedSkills
        .map((skill) => skill.category)
        .toSet()
        .toList();
    final selectedSkillNames = profileSkillController.selectedSkills.map((s) => s.name).toList();
    final professionalTitle = profileTitleController.professionalTitle.value;
    final experienceList = experienceController.workExperiences.map((exp) => {
      "title": exp.title,
      "company": exp.companyName,
      "location": exp.location,
      "country": exp.country,
      "is_current_role": exp.isCurrent,
      "start_date": exp.startDate,
      "end_date": exp.endDate,
      "description": exp.description,
    }).toList();

    final educationList = educationController.educationList.map((edu) => edu.toJson()).toList();

    final selectedLanguages = languageController.languages
        .map((lang) => lang.toJson())
        .toList();


    final requestBody = {
      //...baseRequestData,
      "firstname": Global.userFirstname,
      "lastname": Global.userLastname,
      "email": Global.email,
      "categories": selectedCategoryNames,
      "skills": selectedSkillNames,
      "professional_title": professionalTitle,
      "experience": experienceList,
      "education": educationList,
      "languages": selectedLanguages,
      "bio": bioController.text,
      "hourly_rate": setUserRateController.hourlyRate.value,
      "portfolio": [portfolioController.portfolio.value.toJson()],
      // "portfolio": [
      //   portfolioController.portfolio.value.toJson()
      // ],
    };


    print("request body ::: ${requestBody}");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      print('response :: ${response}');


      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        print('response json ::: ${json}');
        if (json['success'] == 1) {
          profileData.value = FreelancerProfile.fromJson(json['body']);
          Get.snackbar("Success", "Profile created successfully");
        } else {
          Get.snackbar("Error", json['msg'] ?? 'Something went wrong');
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
        print('Error ==> ${response.body}');
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to create profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getFreelancerProfile() async {
    isLoading.value = true;
    String? token = await TokenStorage.getToken();
    final url = Uri.parse(ApiConstants.GET_FREELANCER_PROFILE); // make sure this is correct

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
      );

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['success'] == 1) {
          profileData.value = FreelancerProfile.fromJson(json['body']);
          print("Profile fetched successfully");
          print('profile data ==> ${ profileData.value}');
        } else {
          Get.snackbar("Error", json['msg'] ?? 'Failed to fetch profile');
          print('error message --> ${ json['msg']}');
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
        print('server error --> ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch profile: $e");
      print('error ---> $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateFreelancerProfile() async {
    try{

    }catch(e){
      print('error $e');
    }
  }

}

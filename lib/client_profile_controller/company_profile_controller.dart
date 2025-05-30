import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/global/global.dart';

import '../client_profile_model/company_model.dart';
import '../component/client_profile/close_account_bottomsheet.dart';
import '../component/client_profile/create_new_account_bottomsheet.dart';
import '../component/client_profile/re_enter_password_bottomsheet.dart';
import '../models/user_model.dart';

class CompanyProfileController extends GetxController{
  var user = Rx<UserModel?>(null);
  var company = CompanyModel().obs;
  var companyContacts = CompanyContactsModel().obs;
  var isLoading = false.obs;
  var showCompanyForm = false.obs;
  var isDataUsedForAI = false.obs;

  // Form controllers
  final companyNameController = TextEditingController();
  final websiteController = TextEditingController();
  final taglineController = TextEditingController();
  final descriptionController = TextEditingController();


  // Dropdown options
  final List<String> industries = [
    'Technology',
    'Healthcare',
    'Finance',
    'Education',
    'Manufacturing',
    'Retail',
    'Consulting',
    'Real Estate',
    'Marketing',
    'Other'
  ];

  final List<String> companySizes = [
    "It's just me",
    "2-9 employees",
    "10-99 employees",
    "100-1,000 employees",
    "More than 1,000 employees"
  ];

  @override
  void onInit() {
    super.onInit();
    initializeCompanyData();
    initializeContactsData();
  }

  @override
  void onClose() {
    companyNameController.dispose();
    websiteController.dispose();
    taglineController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void initializeCompanyData() {
    companyNameController.text = "Ishita P";
    company.value.companyName = "Ishita P";
  }

  void initializeContactsData() {
    companyContacts.value = CompanyContactsModel(
      owner: "I***hiya",
      phone: "",
      timeZone: "UTC+05:30 Mumbai, Kolkata, Chennai, New Delhi",
      address: "India",
    );
  }

  void toggleCompanyForm() {
    showCompanyForm.value = !showCompanyForm.value;
  }

  void updateCompanyName(String value) {
    company.update((val) {
      val?.companyName = value;
    });
  }

  void updateWebsite(String value) {
    company.update((val) {
      val?.website = value;
    });
  }

  void updateTagline(String value) {
    company.update((val) {
      val?.tagline = value;
    });
  }

  void updateDescription(String value) {
    company.update((val) {
      val?.description = value;
    });
  }

  void selectIndustry(String? industry) {
    company.update((val) {
      val?.selectedIndustry = industry;
    });
  }

  void selectCompanySize(String size) {
    company.update((val) {
      val?.companySize = size;
    });
  }

  void clearCompanyName() {
    companyNameController.clear();
    updateCompanyName('');
  }

  bool get isFormValid {
    return company.value.selectedIndustry != null &&
        company.value.companySize != null;
  }

  void saveCompanyDetails() {
    if (isFormValid) {
      // Save company details
      Get.snackbar(
        "Success",
        "Company details saved successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Error",
        "Please fill all required fields",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void cancelEdit() {
    // Reset form or navigate back
    //Get.snackbar("Cancelled", "Changes discarded");
    showCompanyForm.value = false;
  }

  void editCompanyContacts() {
    Get.bottomSheet(
      ReEnterPasswordBottomsheet(),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }



  void editProfile() {
    // Handle edit profile action
    Get.snackbar("Edit Profile", "Edit profile functionality");
  }

  void createNewAccount() {
    Get.bottomSheet(
      CreateNewAccountBottomsheet(),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }

  void closeAccount() {
    Get.bottomSheet(
      CloseAccountBottomsheet(),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }

  void changePreference() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'AI Data Usage Preference',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Radio(
                value: true,
                groupValue: isDataUsedForAI.value,
                onChanged: (value) {
                  isDataUsedForAI.value = value!;
                  Get.back();
                },
              ),
              title: Text('Allow data to be used for AI training'),
            ),
            ListTile(
              leading: Radio(
                value: false,
                groupValue: isDataUsedForAI.value,
                onChanged: (value) {
                  isDataUsedForAI.value = value!;
                  Get.back();
                },
              ),
              title: Text('Do not use data for AI training'),
            ),
          ],
        ),
      ),
    );
  }

  void learnMore() {
    Get.snackbar(
      'Info',
      'Learn more about AI preferences',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

}
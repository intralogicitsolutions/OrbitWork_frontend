import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import '../component/select_year_bottomsheet.dart';
import '../models/company_model.dart';
import '../models/freelancer_profile_model.dart';
import '../models/job_title_model.dart';
import '../models/month_model.dart';
import '../models/work_experience_model.dart';

class WorkExperienceController extends GetxController {
  var title = ''.obs;
  var company = ''.obs;
  var location = ''.obs;

  // var country = ''.obs;
  var isCurrentRole = false.obs;

//  var startMonth = ''.obs;
  // var startYear = ''.obs;
  // var endMonth = ''.obs;
  // var endYear = ''.obs;
  var description = ''.obs;

  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  var companies = <Company>[].obs;
  var filteredCompanies = <Company>[].obs;

  var titles = <JobTitle>[].obs;
  var filteredTitles = <JobTitle>[].obs;

  //final workExperiences = <WorkExperience>[].obs;
  final workExperiences = <Experience>[].obs;

  RxInt startYear = 0.obs;
  RxInt endYear = 0.obs;

  var selectedMonth = Rx<MonthModel?>(null);
  final selectedYear = DateTime.now().year.obs;
  final years = List<int>.generate(30, (index) => DateTime.now().year - index);
  final filteredYears = <int>[].obs;
  final selectedCountry = ''.obs;

  final countries = [
    'Afghanistan',
    'Aland Islands',
    'Albania',
    'Algeria',
    'American Samoa',
    'Andorra',
    'Angola',
    'Anguilla',
    'Antarctica',
    'Antigua and Barbuda',
    'Argentina',
    'India'
  ];

  final filteredCountries = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredCountries.value = countries;
    filteredYears.value = years;
    locationController.text = location.value;
    descriptionController.text = description.value;

    locationController.addListener(() {
      location.value = locationController.text;
    });
    descriptionController.addListener(() {
      description.value = descriptionController.text;
    });

    companies.value = [
      Company(name: 'IAC/InterActiveCorp'),
      Company(name: 'IBEX Global'),
      Company(name: 'IBI GROUP INC'),
      Company(name: 'IBM'),
      Company(name: 'IBM Global Services'),
      Company(name: 'IBM Solutions Delivery'),
      Company(name: 'Iamgold'),
      Company(name: 'Iberdrola'),
      Company(name: 'Ibotta'),
      Company(name: 'Seven & I Holdings'),
    ];
    filteredCompanies.value = companies;

    titles.value = [
      JobTitle(name: 'Software Engineer'),
      JobTitle(name: 'Software Quality Assurance Analyst'),
      JobTitle(name: 'Principal Software Engineer'),
      JobTitle(name: 'Senior Software Engineer'),
      JobTitle(name: 'Systems Software Engineer'),
    ];
    filteredTitles.value = titles;
  }

  void toggleCurrentRole(bool? value) {
    isCurrentRole.value = value ?? false;
  }

  bool canSave() {
    return title.value.isNotEmpty && company.value.isNotEmpty;
    // startMonth.value.isNotEmpty &&
    // startYear.value.isNotEmpty &&
    // endYear.value.isNotEmpty &&
    // endMonth.value.isNotEmpty;
  }

  // void saveExperience() {
  //   if (canSave()) {
  //     final experience = WorkExperience(
  //       title: title.value,
  //       company: company.value,
  //       location: location.value,
  //       country: country.value,
  //       isCurrentRole: isCurrentRole.value,
  //       startMonth: startMonth.value,
  //       startYear: startYear.value,
  //       endMonth: endMonth.value,
  //       endYear: endYear.value,
  //       description: description.value,
  //     );
  //     Get.back(result: experience);
  //   }
  // }

  void showStartYearPicker() {
    Get.bottomSheet(SelectYearBottomsheet(
      title: 'Select Start Year',
      selectedYear: startYear,
      onYearSelected: (value) => startYear.value = value,
    ));
  }

  void showEndYearPicker() {
    Get.bottomSheet(SelectYearBottomsheet(
      title: 'Select End Year',
      selectedYear: endYear,
      onYearSelected: (value) => endYear.value = value,
    ));
  }

  void saveExperience() {
    if (canSave()) {
      // final startDate = '${startMonth.value} ${startYear.value}';
      //final endDate = isCurrentRole.value ? null : '${endMonth.value} ${endYear.value}';

      final startDate = selectedMonth.value != null
          ? '${selectedMonth.value!.name} ${startYear.value}'
          : '';

      final endDate = isCurrentRole.value
          ? null
          : (selectedMonth.value != null
              ? '${selectedMonth.value!.name} ${endYear.value}'
              : '');

      final experience = Experience(
        title: title.value,
        companyName: company.value,
        location: location.value,
        country: selectedCountry.value,
        description: description.value,
        startDate: startDate,
        endDate: endDate,
        isCurrent: isCurrentRole.value,
      );
      print('Title: ${experience.title}');
      print('Company: ${experience.companyName}');
      print('Location: ${experience.location}');
      print('Country: ${experience.country}');
      print('Start Date: ${experience.startDate}');
      print('End Date: ${experience.endDate}');
      print('Current Role: ${experience.isCurrent}');
      print('Description: ${experience.description}');

      workExperiences.add(experience);
      Get.back(result: experience);
    }
  }

  final List<MonthModel> months = [
    MonthModel(name: 'January', index: 0),
    MonthModel(name: 'February', index: 1),
    MonthModel(name: 'March', index: 2),
    MonthModel(name: 'April', index: 3),
    MonthModel(name: 'May', index: 4),
    MonthModel(name: 'June', index: 5),
    MonthModel(name: 'July', index: 6),
    MonthModel(name: 'August', index: 7),
    MonthModel(name: 'September', index: 8),
    MonthModel(name: 'October', index: 9),
    MonthModel(name: 'November', index: 10),
    MonthModel(name: 'December', index: 11),
  ];

  void selectMonth(MonthModel month) {
    selectedMonth.value = month;
    Get.back(result: month);
  }

  void updateYear(int year) {
    selectedYear.value = year;
    Get.back();
  }

  void filterYears(String query) {
    if (query.isEmpty) {
      filteredYears.value = years;
    } else {
      filteredYears.value =
          years.where((year) => year.toString().contains(query)).toList();
    }
  }

  void filterCountries(String query) {
    if (query.isEmpty) {
      filteredCountries.value = countries;
    } else {
      filteredCountries.value = countries
          .where(
              (country) => country.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void updateCountry(String country) {
    selectedCountry.value = country;
    Get.back();
  }

  void searchCompanies(String query) {
    if (query.isEmpty) {
      filteredCompanies.value = companies;
    } else {
      filteredCompanies.value = companies
          .where((company) =>
              company.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void searchTitles(String query) {
    if (query.isEmpty) {
      filteredTitles.value = titles;
    } else {
      filteredTitles.value = titles
          .where(
              (title) => title.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}

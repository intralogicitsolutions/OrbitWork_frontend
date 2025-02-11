import 'package:get/get.dart';
import '../models/company_model.dart';
import '../models/job_title_model.dart';
import '../models/month_model.dart';
import '../models/work_experience_model.dart';

class WorkExperienceController extends GetxController {
  var title = ''.obs;
  var company = ''.obs;
  var location = ''.obs;
  var country = ''.obs;
  var isCurrentRole = false.obs;
  var startMonth = ''.obs;
  var startYear = ''.obs;
  var endMonth = ''.obs;
  var endYear = ''.obs;
  var description = ''.obs;

  var companies = <Company>[].obs;
  var filteredCompanies = <Company>[].obs;

  var titles = <JobTitle>[].obs;
  var filteredTitles = <JobTitle>[].obs;


  var selectedMonth = Rx<MonthModel?>(null);
  final selectedYear = DateTime.now().year.obs;
  final years = List<int>.generate(30, (index) => DateTime.now().year - index);
  final filteredYears = <int>[].obs;
  final selectedCountry = ''.obs;

  final countries = [
    'Afghanistan', 'Aland Islands', 'Albania', 'Algeria',
    'American Samoa', 'Andorra', 'Angola', 'Anguilla',
    'Antarctica', 'Antigua and Barbuda', 'Argentina'
  ];

  final filteredCountries = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredCountries.value = countries;
    filteredYears.value = years;

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
    return title.value.isNotEmpty &&
        company.value.isNotEmpty;
        // startMonth.value.isNotEmpty &&
        // startYear.value.isNotEmpty &&
        // endYear.value.isNotEmpty &&
        // endMonth.value.isNotEmpty;
  }

  void saveExperience() {
    if (canSave()) {
      final experience = WorkExperience(
        title: title.value,
        company: company.value,
        location: location.value,
        country: country.value,
        isCurrentRole: isCurrentRole.value,
        startMonth: startMonth.value,
        startYear: startYear.value,
        endMonth: endMonth.value,
        endYear: endYear.value,
        description: description.value,
      );
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
      filteredYears.value = years
          .where((year) => year.toString().contains(query))
          .toList();
    }
  }

  void filterCountries(String query) {
    if (query.isEmpty) {
      filteredCountries.value = countries;
    } else {
      filteredCountries.value = countries
          .where((country) =>
          country.toLowerCase().contains(query.toLowerCase()))
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
          .where((title) =>
          title.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

}


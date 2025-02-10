import 'package:get/get.dart';
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
  }

  void toggleCurrentRole(bool? value) {
    isCurrentRole.value = value ?? false;
  }

  bool canSave() {
    return title.value.isNotEmpty &&
        company.value.isNotEmpty &&
        startMonth.value.isNotEmpty &&
        startYear.value.isNotEmpty &&
        endYear.value.isNotEmpty &&
        endMonth.value.isNotEmpty;
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

}


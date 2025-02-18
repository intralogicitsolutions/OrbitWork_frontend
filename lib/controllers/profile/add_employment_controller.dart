import 'package:get/get.dart';

class AddEmploymentController extends GetxController{
  var isChecked = false.obs;

  final company = ''.obs;
  final city = ''.obs;
  final country = ''.obs;
  final title = ''.obs;
  final month = ''.obs;
  final year = ''.obs;
  final description = ''.obs;
  final throughMonth = ''.obs;
  final throughYear = ''.obs;

  void resetForm() {
    company.value = '';
    city.value = '';
    country.value = '';
    title.value = '';
    month.value = '';
    year.value = '';
    description.value = '';
    throughMonth.value = '';
    throughYear.value = '';
  }
}
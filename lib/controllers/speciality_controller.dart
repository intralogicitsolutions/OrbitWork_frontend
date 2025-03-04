import 'package:get/get.dart';

class SpecialityController extends GetxController{
  final RxString selectedSpecialty = ''.obs;
  final RxString searchQuery = ''.obs;

  final List<String> specialties = [
    'Accounting',
    'Booking',
    'Career Coaching',
    'Consulting',
    'Data Analysis',
    'Design',
    'Development',
    'Marketing',
    'Project Management',
    'Writing',
  ];

  List<String> get filteredSpecialties => specialties
      .where((item) => item.toLowerCase().contains(searchQuery.value.toLowerCase()))
      .toList();

  void setSpecialty(String specialty) {
    selectedSpecialty.value = specialty;
    Get.back();
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}
import 'package:get/get.dart';

import '../../models/proficiency_level_model.dart';

class AddLanguageController extends GetxController {
  final selectedLanguage = ''.obs;
  //final selectedProficiency = ''.obs;
  final selectedProficiency = Rxn<ProficiencyLevel>();
  final isFormValid = false.obs;

  final searchQuery = ''.obs;
  final languages = <String>[
    'Afrikaans',
    'Amharic',
    'Assamese',
    'Azerbaijani',
    'Belarusian',
    'Bulgarian',
    'Bhojpuri',
    'Bengali',
    'Bosnian',
    'Catalan, Valencian',
    'Cebuano',
    // Add more languages as needed
  ].obs;

  final filteredLanguages = <String>[].obs;

  final proficiencyLevels = [
    ProficiencyLevel(
      title: 'Basic',
      description: 'I am only able to communicate in this language...',
    ),
    ProficiencyLevel(
      title: 'Conversational',
      description: 'I know this language well enough to verball...',
    ),
    ProficiencyLevel(
      title: 'Fluent',
      description: 'I have complete command of this language...',
    ),
    ProficiencyLevel(
      title: 'Native or Bilingual',
      description: 'I have complete command of this language...',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    filteredLanguages.value = languages;
  }

  void setLanguage(String language) {
    selectedLanguage.value = language;
    validateForm();
  }

  void setProficiency(ProficiencyLevel  proficiency) {
    selectedProficiency.value = proficiency;
    validateForm();
  }

  void validateForm() {
    isFormValid.value = selectedLanguage.isNotEmpty && selectedProficiency.value != null;
  }

  void clearSelections() {
    selectedLanguage.value = '';
    selectedProficiency.value = null;
    isFormValid.value = false;
  }

  void saveLanguage() {
    if (isFormValid.value) {
      // Add your save logic here
      print('Saving: ${selectedLanguage.value} - ${selectedProficiency.value?.title}');
      Get.back();
    }
  }

  void filterLanguages(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredLanguages.value = languages;
    } else {
      filteredLanguages.value = languages
          .where((language) =>
          language.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}

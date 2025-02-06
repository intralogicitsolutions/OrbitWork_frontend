import 'package:get/get.dart';
import 'package:orbitwork/models/language_model.dart';

class LanguageController extends GetxController{
  var languages = <Language>[].obs;

  final List<String> languageOptions = [
    'Select Language',
    'English',
    'Gujarati',
    'Hindi',
  ];

  var proficiencyLevels = [
    'Basic',
    'Conversational',
    'Fluent',
    'Native or Bilingual'
  ];

  @override
  void onInit() {
    super.onInit();
    // Add default English language
    languages.add(Language(
        name: 'English',
        proficiency: 'Conversational',
        isDefault: true
    ));
  }

  void addLanguage() {
    languages.add(Language(
        name: 'Select Language',
        proficiency: 'Conversational'
    ));
  }

  void removeLanguage(int index) {
    if (!languages[index].isDefault) {
      languages.removeAt(index);
    }
  }

  void updateLanguage(int index, String language) {
    languages[index].name = language;
    languages.refresh();
  }

  void updateProficiency(int index, String proficiency) {
    languages[index].proficiency = proficiency;
    languages.refresh();
  }
}



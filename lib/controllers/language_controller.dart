import 'package:get/get.dart';

import '../models/freelancer_profile_model.dart';

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

  // @override
  // void onInit() {
  //   super.onInit();
  //   Future.delayed(Duration.zero, () {
  //   // Add default English language
  //   languages.add(Language(
  //       name: 'English',
  //       proficiency: 'Conversational',
  //       isDefault: true
  //   ));
  //   });
  // }
  //
  // void addLanguage() {
  //   languages.add(Language(
  //       name: 'Select Language',
  //       proficiency: 'Conversational'
  //   ));
  // }
  //
  // void removeLanguage(int index) {
  //   if (!languages[index].isDefault) {
  //     languages.removeAt(index);
  //   }
  // }
  //
  // void updateLanguage(int index, String language) {
  //   languages[index].name = language;
  //   languages.refresh();
  // }
  //
  // void updateProficiency(int index, String proficiency) {
  //   languages[index].proficiency = proficiency;
  //   languages.refresh();
  // }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () {
      // Add default English language
      languages.add(Language(language: 'English', level: 'Conversational'));
    });
  }

  void addLanguage() {
    languages.add(Language(language: null, level: null));
  }

  void removeLanguage(int index) {
    if (languages[index].language != 'English') {
      languages.removeAt(index);
    }
  }

  void updateLanguage(int index, String language) {
    languages[index] = Language(
      language: language,
      level: languages[index].level,
    );
    languages.refresh();
  }

  void updateProficiency(int index, String level) {
    languages[index] = Language(
      language: languages[index].language,
      level: level,
    );
    languages.refresh();
  }
}



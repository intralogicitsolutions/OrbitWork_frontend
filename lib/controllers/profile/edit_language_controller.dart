import 'package:get/get.dart';

import '../../models/language_entry_model.dart';
import '../../models/proficiency_level_model.dart';

class EditLanguagesController extends GetxController {
  final languageEntries = <LanguageEntry>[].obs;
  final isModified = false.obs;

  @override
  void onInit() {
    super.onInit();
    languageEntries.addAll([
      LanguageEntry(
        language: 'English',
        proficiency: ProficiencyLevel(
          title: 'Conversational',
          description: 'I know this language well enough to verbally...',
        ),
      ),
      LanguageEntry(
        language: 'Gujarati',
        proficiency: ProficiencyLevel(
          title: 'Fluent',
          description: 'I have complete command of this language...',
        ),
      ),
      LanguageEntry(
        language: 'Hindi',
        proficiency: ProficiencyLevel(
          title: 'Fluent',
          description: 'I have complete command of this language...',
        ),
      ),
      LanguageEntry(
        language: 'Arabic',
        proficiency: ProficiencyLevel(
          title: 'Basic',
          description: 'I am only able to communicate in this language...',
        ),
      ),
    ]);
  }

  void removeLanguage(int index) {
    languageEntries.removeAt(index);
    isModified.value = true;
  }

  void updateProficiency(int index, ProficiencyLevel newProficiency) {
    final entry = languageEntries[index];
    languageEntries[index] = LanguageEntry(
      language: entry.language,
      proficiency: newProficiency,
    );
    isModified.value = true;
  }

  void saveChanges() {

    Get.back();
  }
}
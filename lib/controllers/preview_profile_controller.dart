import 'package:get/get.dart';
import '../models/preview_profile_model.dart';


class PreviewProfileController extends GetxController {
  final profile = Rx<PreviewProfileModel?>(null);
  final skills = <String>[
    'Android App Development',
    'App Development',
    'Mobile App Development',
    'iOS Development',
    'App Design'
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data
    profile.value = PreviewProfileModel(
      name: 'Ishita Poshiya',
      location: 'Rajkot, GJ',
      profession: 'Mobile app developer',
      localTime: '12:17 PM local time',
      expertise: 'Expertise in building cross-platform mobile applications using flutter. Proficient in flutter widgets, state management (provider, riverpod, block), and using firebase',
      hourlyRate: 40.00,
      skills: skills,
    );
  }

  void updateSkills(String skill) {
    if (!skills.contains(skill)) {
      skills.add(skill);
    }
  }

  void removeSkill(String skill) {
    skills.remove(skill);
  }

  void updateProfile(PreviewProfileModel newProfile) {
    profile.value = newProfile;
  }

  // String getLocalTime() {
  //   return DateTime.now().format('hh:mm a');
  // }


  final workHistory = <WorkHistoryModel>[
    WorkHistoryModel(
      company: 'IBM',
      position: 'Software Engineer',
      period: 'January 2024 - Present',
    )
  ].obs;

  // Education
  final education = <EducationModel>[
    EducationModel(
      institution: 'University of Dubuque',
      degree: null,
      period: null,
    )
  ].obs;

  // Languages
  final languages = <LanguageModel>[
    LanguageModel(language: 'English', proficiencyLevel: 'Conversational'),
    LanguageModel(language: 'Gujarati', proficiencyLevel: 'Fluent'),
    LanguageModel(language: 'Hindi', proficiencyLevel: 'Fluent'),
  ].obs;

  void addWorkHistory(WorkHistoryModel entry) {
    workHistory.add(entry);
  }

  void removeWorkHistory(WorkHistoryModel entry) {
    workHistory.remove(entry);
  }

  void updateWorkHistory(WorkHistoryModel oldEntry, WorkHistoryModel newEntry) {
    final index = workHistory.indexOf(oldEntry);
    if (index != -1) {
      workHistory[index] = newEntry;
    }
  }

  void addEducation(EducationModel entry) {
    education.add(entry);
  }

  void removeEducation(EducationModel entry) {
    education.remove(entry);
  }

  void updateEducation(EducationModel oldEntry, EducationModel newEntry) {
    final index = education.indexOf(oldEntry);
    if (index != -1) {
      education[index] = newEntry;
    }
  }

  void addLanguage(LanguageModel language) {
    languages.add(language);
  }

  void removeLanguage(LanguageModel language) {
    languages.remove(language);
  }

  void updateLanguage(LanguageModel oldLanguage, LanguageModel newLanguage) {
    final index = languages.indexOf(oldLanguage);
    if (index != -1) {
      languages[index] = newLanguage;
    }
  }
}

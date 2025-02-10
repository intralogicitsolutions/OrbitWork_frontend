import 'package:get/get.dart';

import '../models/skill_model.dart';

class ProfileSkillController extends GetxController {
  var selectedSkills = <Skill>[].obs;
  var suggestedSkills = <Skill>[].obs;
  final maxSkills = 15;

  var searchQuery = ''.obs;
  var allSkills = <Skill>[].obs;
  var filteredSkills = <Skill>[].obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () {
    // Initialize with some default skills
    suggestedSkills.addAll([
      Skill(name: 'Mobile Game'),
      Skill(name: 'iOS Development'),
      Skill(name: 'Mobile App'),
    ]);

    selectedSkills.addAll([
      Skill(name: 'Android App Development', isSelected: true),
      Skill(name: 'App Development', isSelected: true),
    ]);


    allSkills.addAll([
      Skill(name: 'App Design'),
      Skill(name: 'App Feature Development'),
      Skill(name: 'App Game Kit'),
      Skill(name: 'App Icon Design'),
      Skill(name: 'App Marketplace'),
      Skill(name: 'App Store'),
      Skill(name: 'App Store Description'),
      Skill(name: 'App Store Optimization'),
      Skill(name: 'App Store Upload'),
      Skill(name: 'App Usability Analysis'),

    ]);
    updateFilteredSkills();
    });
  }

  void addSkill(Skill skill) {
    if (selectedSkills.length < maxSkills) {
      selectedSkills.add(skill);
      suggestedSkills.remove(skill);
    }
  }

  void removeSkill(Skill skill) {
    selectedSkills.remove(skill);
    suggestedSkills.add(skill);
  }
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    updateFilteredSkills();
  }

  void updateFilteredSkills() {
    if (searchQuery.isEmpty) {
      filteredSkills.value = allSkills
          .where((skill) => !selectedSkills.any((s) => s.name == skill.name))
          .toList();
    } else {
      filteredSkills.value = allSkills
          .where((skill) =>
      skill.name.toLowerCase().contains(searchQuery.toLowerCase()) &&
          !selectedSkills.any((s) => s.name == skill.name))
          .toList();
    }
  }

  void toggleSkill(Skill skill) {
    if (selectedSkills.any((s) => s.name == skill.name)) {
      selectedSkills.removeWhere((s) => s.name == skill.name);
    } else {
      selectedSkills.add(Skill(name: skill.name, isSelected: true));
    }
    updateFilteredSkills();
  }
}
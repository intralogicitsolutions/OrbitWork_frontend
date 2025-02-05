import 'package:get/get.dart';
import '../models/skill_category.dart';

class SkillsController extends GetxController {
  final categories = <SkillCategory>[
    SkillCategory(
      name: 'Design & Creative',
      specialties: ['UI/UX Design', 'Graphic Design', 'Animation'],
    ),
    SkillCategory(
      name: 'Engineering & Architecture',
      specialties: ['Civil Engineering', 'Architecture', 'Interior Design'],
    ),
    SkillCategory(
      name: 'IT & Networking',
      specialties: ['Network Administration', 'System Administration', 'Cloud Computing'],
    ),
    SkillCategory(
      name: 'Legal',
      specialties: ['Contract Law', 'Corporate Law', 'Patent Law'],
    ),
    SkillCategory(
      name: 'Sales & Marketing',
      specialties: ['Digital Marketing', 'Sales Strategy', 'Brand Management'],
    ),
    SkillCategory(
      name: 'Translation',
      specialties: ['Language Tutoring & Interpretation', 'Translation & Localization Services'],
    ),
    SkillCategory(
      name: 'Web, Mobile & Software Dev',
      specialties: ['Frontend Development', 'Backend Development', 'Mobile Development'],
    ),
    SkillCategory(
      name: 'Writing',
      specialties: ['Content Writing', 'Technical Writing', 'Copywriting'],
    ),
  ].obs;

  final selectedSkills = <SelectedSkill>[].obs;

  void toggleExpansion(int index) {
    for (var i = 0; i < categories.length; i++) {
      if (i == index) {
        categories[i].isExpanded = !categories[i].isExpanded;
      } else {
        categories[i].isExpanded = false;
      }
    }
    update();
  }

  void selectSkill(String category, String specialty) {
    if (selectedSkills.length < 3) {
      if (!selectedSkills.any((skill) =>
      skill.category == category && skill.specialty == specialty)) {
        selectedSkills.add(SelectedSkill(
          category: category,
          specialty: specialty,
        ));
      }
    }
  }

  void clearSelections() {
    selectedSkills.clear();
  }
}
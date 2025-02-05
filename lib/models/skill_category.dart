class SkillCategory {
  final String name;
  final List<String> specialties;
  bool isExpanded;

  SkillCategory({
    required this.name,
    required this.specialties,
    this.isExpanded = false,
  });
}


class SelectedSkill {
  final String category;
  final String specialty;

  SelectedSkill({
    required this.category,
    required this.specialty,
  });
}
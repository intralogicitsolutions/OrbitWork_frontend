class PreviewProfileModel {
  final String name;
  final String location;
  final String profession;
  final String? imageUrl;
  final String localTime;
  final String expertise;
  final double hourlyRate;
  final List<String> skills;

  PreviewProfileModel({
    required this.name,
    required this.location,
    required this.profession,
    this.imageUrl,
    required this.localTime,
    required this.expertise,
    required this.hourlyRate,
    required this.skills,
  });
}


class WorkHistoryModel {
  final String company;
  final String position;
  final String period;

  WorkHistoryModel({
    required this.company,
    required this.position,
    required this.period,
  });
}


class EducationModel {
  final String institution;
  final String? degree;
  final String? period;

  EducationModel({
    required this.institution,
    this.degree,
    this.period,
  });
}


class LanguageModel {
  final String language;
  final String proficiencyLevel;

  LanguageModel({
    required this.language,
    required this.proficiencyLevel,
  });
}
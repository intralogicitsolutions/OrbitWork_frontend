
class Experience {
  String? title;
  String? companyName;
  String? location;
  String? country;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  bool? isCurrent;

  Experience({
    this.title,
    this.companyName,
    this.location,
    this.country,
    this.description,
    this.startDate,
    this.endDate,
    this.isCurrent,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "company_name": companyName,
    "location": location,
    "country": country,
    "description": description,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "is_current": isCurrent,
  };
}

class Education {
  String? institutionName;
  String? degree;
  String? fieldOfStudy;
  int? startYear;
  int? endYear;
  String? description;

  Education({
    this.institutionName,
    this.degree,
    this.fieldOfStudy,
    this.startYear,
    this.endYear,
    this.description,
  });

  Map<String, dynamic> toJson() => {
    "institution_name": institutionName,
    "degree": degree,
    "field_of_study": fieldOfStudy,
    "start_year": startYear,
    "end_year": endYear,
    "description": description,
  };
}

class Language {
  String? language;
  String? level;

  Language({this.language, this.level});

  Map<String, dynamic> toJson() => {
    "language": language,
    "level": level,
  };
}

class Portfolio {
  String? profilePhoto;
  DateTime? dob;
  String? streetAddress;
  String? city;
  String? state;
  String? zip;
  String? phone;

  Portfolio({
    this.profilePhoto,
    this.dob,
    this.streetAddress,
    this.city,
    this.state,
    this.zip,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
    "profile_photo": profilePhoto,
    "dob": dob?.toIso8601String(),
    "street_address": streetAddress,
    "city": city,
    "state": state,
    "zip": zip,
    "phone": phone,
  };
}

class FreelancerProfileRequest {
  String? professionalRole;
  String? uploadResume;
  List<String>? categories;
  List<String>? skills;
  List<Experience>? experience;
  List<Education>? education;
  List<Language>? languages;
  String? bio;
  int? hourlyRate;
  List<Portfolio>? portfolio;

  FreelancerProfileRequest({
    this.professionalRole,
    this.uploadResume,
    this.categories,
    this.skills,
    this.experience,
    this.education,
    this.languages,
    this.bio,
    this.hourlyRate,
    this.portfolio,
  });

  Map<String, dynamic> toJson() => {
    "professional_role": professionalRole,
    "upload_resume": uploadResume,
    "categories": categories,
    "skills": skills,
    "experience": experience?.map((e) => e.toJson()).toList(),
    "education": education?.map((e) => e.toJson()).toList(),
    "languages": languages?.map((e) => e.toJson()).toList(),
    "bio": bio,
    "hourly_rate": hourlyRate,
    "portfolio": portfolio?.map((e) => e.toJson()).toList(),
  };
}

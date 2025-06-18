//
// class Experience {
//   String? title;
//   String? companyName;
//   String? location;
//   String? country;
//   String? description;
//   DateTime? startDate;
//   DateTime? endDate;
//   bool? isCurrent;
//
//   Experience({
//     this.title,
//     this.companyName,
//     this.location,
//     this.country,
//     this.description,
//     this.startDate,
//     this.endDate,
//     this.isCurrent,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "company_name": companyName,
//     "location": location,
//     "country": country,
//     "description": description,
//     "start_date": startDate?.toIso8601String(),
//     "end_date": endDate?.toIso8601String(),
//     "is_current": isCurrent,
//   };
// }
//
// class Education {
//   String? institutionName;
//   String? degree;
//   String? fieldOfStudy;
//   int? startYear;
//   int? endYear;
//   String? description;
//
//   Education({
//     this.institutionName,
//     this.degree,
//     this.fieldOfStudy,
//     this.startYear,
//     this.endYear,
//     this.description,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "institution_name": institutionName,
//     "degree": degree,
//     "field_of_study": fieldOfStudy,
//     "start_year": startYear,
//     "end_year": endYear,
//     "description": description,
//   };
// }
//
// class Language {
//   String? language;
//   String? level;
//
//   Language({this.language, this.level});
//
//   Map<String, dynamic> toJson() => {
//     "language": language,
//     "level": level,
//   };
// }
//
// class Portfolio {
//   String? profilePhoto;
//   DateTime? dob;
//   String? streetAddress;
//   String? city;
//   String? state;
//   String? zip;
//   String? phone;
//
//   Portfolio({
//     this.profilePhoto,
//     this.dob,
//     this.streetAddress,
//     this.city,
//     this.state,
//     this.zip,
//     this.phone,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "profile_photo": profilePhoto,
//     "dob": dob?.toIso8601String(),
//     "street_address": streetAddress,
//     "city": city,
//     "state": state,
//     "zip": zip,
//     "phone": phone,
//   };
// }
//
// class FreelancerProfileRequest {
//   String? professionalRole;
//   String? uploadResume;
//   List<String>? categories;
//   List<String>? skills;
//   List<Experience>? experience;
//   List<Education>? education;
//   List<Language>? languages;
//   String? bio;
//   int? hourlyRate;
//   List<Portfolio>? portfolio;
//
//   FreelancerProfileRequest({
//     this.professionalRole,
//     this.uploadResume,
//     this.categories,
//     this.skills,
//     this.experience,
//     this.education,
//     this.languages,
//     this.bio,
//     this.hourlyRate,
//     this.portfolio,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "professional_role": professionalRole,
//     "upload_resume": uploadResume,
//     "categories": categories,
//     "skills": skills,
//     "experience": experience?.map((e) => e.toJson()).toList(),
//     "education": education?.map((e) => e.toJson()).toList(),
//     "languages": languages?.map((e) => e.toJson()).toList(),
//     "bio": bio,
//     "hourly_rate": hourlyRate,
//     "portfolio": portfolio?.map((e) => e.toJson()).toList(),
//   };
// }





// lib/models/freelancer_profile_model.dart

class FreelancerProfile {
  final String? userId;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? uploadResume;
  final List<String>? categories;
  final List<String>? skills;
  final String? professionalRole;
  final List<Experience>? experience;
  final List<Education>? education;
  final List<Language>? languages;
  final String? bio;
  final String? hourlyRate;
  final List<Portfolio>? portfolio;

  FreelancerProfile({
    this.userId,
    this.firstname,
    this.lastname,
    this.email,
    this.uploadResume,
    this.categories,
    this.skills,
    this.professionalRole,
    this.experience,
    this.education,
    this.languages,
    this.bio,
    this.hourlyRate,
    this.portfolio,
  });

  factory FreelancerProfile.fromJson(Map<String, dynamic> json) {
    return FreelancerProfile(
      userId: json['user_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      uploadResume: json['upload_resume'],
      categories: List<String>.from(json['categories'] ?? []),
      skills: List<String>.from(json['skills'] ?? []),
      professionalRole: json['professional_role'],
      experience: (json['experience'] as List?)?.map((e) => Experience.fromJson(e)).toList(),
      education: (json['education'] as List?)?.map((e) => Education.fromJson(e)).toList(),
      languages: (json['languages'] as List?)?.map((e) => Language.fromJson(e)).toList(),
      bio: json['bio'],
      hourlyRate: json['hourly_rate'],
      portfolio: (json['portfolio'] as List?)?.map((e) => Portfolio.fromJson(e)).toList(),
    );
  }
}

class Experience {
  final String? title;
  final String? companyName;
  final String? location;
  final String? country;
  final String? description;
  final String? startDate;
  final String? endDate;
  final bool? isCurrent;

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

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'],
      companyName: json['company_name'],
      location: json['location'],
      country: json['country'],
      description: json['description'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      isCurrent: json['is_current'],
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "company_name": companyName,
    "location": location,
    "country": country,
    "description": description,
    "start_date": startDate,
    "end_date": endDate,
    "is_current": isCurrent,
  };
}

class Education {
  final String? institutionName;
  final String? degree;
  final String? fieldOfStudy;
  final String? startYear;
  final String? endYear;
  final String? description;

  Education({
    this.institutionName,
    this.degree,
    this.fieldOfStudy,
    this.startYear,
    this.endYear,
    this.description,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      institutionName: json['institution_name'],
      degree: json['degree'],
      fieldOfStudy: json['field_of_study'],
      startYear: json['start_year'],
      endYear: json['end_year'],
      description: json['description'],
    );
  }

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
  final String? language;
  final String? level;

  Language({this.language, this.level});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      language: json['language'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
    "language": language,
    "level": level,
  };
}

class Portfolio {
    String? profilePhoto;
    String? dob;
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

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      profilePhoto: json['profile_photo'] == null ? "" : json['profile_photo'],
      dob: json['dob'],
      streetAddress: json['street_address'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    "profile_photo": profilePhoto,
    "dob": dob,
    "street_address": streetAddress,
    "city": city,
    "state": state,
    "zip": zip,
    "phone": phone,
  };
}

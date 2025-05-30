class CompanyModel{
  String companyName;
  String website;
  String? selectedIndustry;
  String? companySize;
  String tagline;
  String description;

  CompanyModel({
    this.companyName = '',
    this.website = '',
    this.selectedIndustry,
    this.companySize,
    this.tagline = '',
    this.description = '',
  });
}

class CompanyContactsModel {
  String owner;
  String phone;
  String timeZone;
  String address;

  CompanyContactsModel({
    this.owner = '',
    this.phone = '',
    this.timeZone = '',
    this.address = '',
  });
}
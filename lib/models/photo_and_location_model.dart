class PhotoAndLocationModel {
  String? photoUrl;
  DateTime? dateOfBirth;
  String? country;
  String? streetAddress;
  String? aptSuite;
  String? city;
  String? stateProvince;
  String? zipCode;
  String? phoneNumber;
  String? phoneCountryCode;



  PhotoAndLocationModel({
    this.photoUrl,
    this.dateOfBirth,
    this.country,
    this.streetAddress,
    this.aptSuite,
    this.city,
    this.stateProvince,
    this.zipCode,
    this.phoneNumber,
    this.phoneCountryCode = '+91',
  });
}
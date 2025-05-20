class CardModel {
  String paymentMethodId;
  String cardNumber;
  String expireMonth;
  String expireYear;
  String securityCode;
  String firstName;
  String lastName;
  String addressLine1;
  String city;
  String state;
  String zip;
  String countryCode;

  CardModel({
    required this.paymentMethodId,
    required this.cardNumber,
    required this.expireMonth,
    required this.expireYear,
    required this.securityCode,
    required this.firstName,
    required this.lastName,
    required this.addressLine1,
    required this.city,
    required this.state,
    required this.zip,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() => {
    "payment_method_id": paymentMethodId,
    "card_number": cardNumber,
    "expire_month": expireMonth,
    "expire_year": expireYear,
    "security_code": securityCode,
    "first_name": firstName,
    "last_name": lastName,
    "address_line1": addressLine1,
    "city": city,
    "state": state,
    "zip": zip,
    "country_code": countryCode,
  };
}



class PaymentcardModel {
  final String id;
  final String customerId;
  final String last4;
  final String brand;
  final int expMonth;
  final int expYear;
  final String name;

  PaymentcardModel({
    required this.id,
    required this.customerId,
    required this.last4,
    required this.brand,
    required this.expMonth,
    required this.expYear,
    required this.name,
  });

  factory PaymentcardModel.fromJson(Map<String, dynamic> json) {
    return PaymentcardModel(
      id: json['id'],
      customerId: json['customer_id'],
      last4: json['last4'],
      brand: json['type'],
      expMonth: json['exp_month'],
      expYear: json['exp_year'],
      name: json['name'],
    );
  }
}

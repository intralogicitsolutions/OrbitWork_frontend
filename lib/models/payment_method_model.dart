class PaymentMethodModel {
 // final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final bool isPrimary;
  final String paymentMethodId; // from Stripe frontend (Stripe.js or SDK)
  final BillingAddress address;

  PaymentMethodModel({
   // required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isPrimary,
    required this.paymentMethodId,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      //'user_id': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'is_primary': isPrimary,
      'paymentMethodId': paymentMethodId,
      'address': address.toJson(),
    };
  }
}

class BillingAddress {
  final String country;
  final String addressLine;
  final String city;
  final String postalCode;

  BillingAddress({
    required this.country,
    required this.addressLine,
    required this.city,
    required this.postalCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'addressLine': addressLine,
      'city': city,
      'postalCode': postalCode,
    };
  }
}
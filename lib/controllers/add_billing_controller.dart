import 'dart:convert';

import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:orbitwork/models/payment_card_model.dart';
import 'package:orbitwork/repository/api/api_constants.dart';
import '../global/global.dart';
import '../global/tokenStorage.dart';
import '../models/payment_method_model.dart';

class AddBillingController extends GetxController {
  final RxString selectedMethod = ''.obs;

  final cardFieldController = CardEditController();
  final cardDetails = Rx<CardFieldInputDetails?>(null);

  var savedCard = Rxn<PaymentcardModel>();
  var showAddBillingMethod = false.obs;
  // final cardFormFieldController = CardFormEditController();
  // final cardFormDetails = Rx<CardFieldInputDetails?>(null);
  //
  // CardFieldInputDetails? cardDetails; // Declare this in your controller or state
  // final CardEditController cardFieldController = CardEditController();

  RxBool cardNumberError = false.obs;
  RxBool expiryMonthError = false.obs;
  RxBool expiryYearError = false.obs;
  RxBool securityCodeError = false.obs;

  final cardNumberController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final expiryMonthController = TextEditingController();
  final expiryYearController = TextEditingController();
  final securityCodeController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  final selectedCountry = 'India'.obs;
  final selectedCountryCode = RxString('IN');
 //  final countries = ['India', 'USA', 'UK', 'Canada', 'Australia'].obs;
 // List<String> countries = ['India', 'USA', 'UK', 'Canada', 'Australia'];
  final List<Map<String, String>> countries = [
    {'code': 'IN', 'name': 'India'},
    {'code': 'US', 'name': 'United States'},
    {'code': 'GB', 'name': 'United Kingdom'},
    {'code': 'EG', 'name': 'Egypt'},
    // Add more as needed
  ];
  final selectedCardType = 'visa'.obs;

  var isLoading = false.obs;

  var cardError = RxnString();
  var monthError = RxnString();
  var yearError = RxnString();
  var cvcError = RxnString();


  void onInit() {
    super.onInit();
    // Set default values from Global on init
    firstNameController.text = Global.userFirstname ?? '';
    lastNameController.text = Global.userLastname ?? '';
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    expiryMonthController.dispose();
    expiryYearController.dispose();
    securityCodeController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    super.onClose();
  }

  void setSelectedMethod(String method) {
    selectedMethod.value = method;
  }

  void addPaymentMethod() {
    Get.back();
  }

  void validateCardFields() {
    final cardNumber = cardNumberController.text.replaceAll(' ', '');
    final month = expiryMonthController.text;
    final year = expiryYearController.text;
    final cvc = securityCodeController.text;

    cardError.value = validateCardNumber(cardNumber);
    monthError.value = validateMonth(month);
    yearError.value = validateYear(year);
    cvcError.value = validateCVC(cvc);
  }

  String? validateCardNumber(String input) {
    final regex = RegExp(r'^[0-9]{16}$');
    return regex.hasMatch(input) ? null : 'Invalid card number';
  }

  String? validateMonth(String input) {
    final month = int.tryParse(input);
    if (month == null || month < 1 || month > 12) {
      return 'Invalid month';
    }
    return null;
  }

  String? validateYear(String input) {
    final year = int.tryParse(input);
    final currentYear = DateTime.now().year % 100;
    if (year == null || year < currentYear || year > currentYear + 20) {
      return 'Invalid year';
    }
    return null;
  }

  String? validateCVC(String input) {
    final regex = RegExp(r'^[0-9]{3,4}$');
    return regex.hasMatch(input) ? null : 'Invalid CVC';
  }


  bool get isValid =>
      cardError.value == null &&
          monthError.value == null &&
          yearError.value == null;



  bool validateExpMonth(String month) {
    if (month.isEmpty) return false;
    final monthInt = int.tryParse(month);
    return monthInt != null && monthInt >= 1 && monthInt <= 12;
  }

  bool validateExpYear(String year) {
    if (year.isEmpty) return false;
    final yearInt = int.tryParse(year);
    if (yearInt == null) return false;

    final now = DateTime.now();
    final currentYear = now.year % 100; // Get last 2 digits
    final currentMonth = now.month;

    // If year is 2 digits, compare with current year
    if (year.length == 2) {
      return yearInt >= currentYear;
    }

    // If year is 4 digits
    return yearInt >= now.year;
  }

  Future<bool> validateForm() async {
    final validator = CreditCardValidator();

    // Validate card number
    final cardValidation = validator.validateCCNum(cardNumberController.text);
    cardNumberError.value = !cardValidation.isValid;

    // Validate expiry month
    expiryMonthError.value = validateExpMonth(expiryMonthController.text);
   // expiryMonthError.value = !monthValidation.isValid;

    // Validate expiry year
    expiryYearError.value = validateExpYear(expiryYearController.text);
    //expiryYearError.value = !yearValidation.isValid;

    // Validate CVV
    final cvvValidation = validator.validateCVV(
        securityCodeController.text,
        cardValidation.ccType
    );
    securityCodeError.value = !cvvValidation.isValid;

    // Validate other fields as needed

    return cardValidation.isValid &&
        !expiryMonthError.value &&
        !expiryYearError.value &&
        cvvValidation.isValid;
  }



  Future<void> saveCard() async {
    isLoading.value = true;
    String? token = await TokenStorage.getToken();

    try {
      final billingDetails = BillingDetails(
        name: "${firstNameController.text} ${lastNameController.text}",
        email: Global.email,
      );

      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: billingDetails,
          ),
        ),
      );

      final paymentMethodId = paymentMethod.id;
      print("Created PaymentMethod ID: $paymentMethodId");

      final body = {
        "payment_method_id": paymentMethodId,
        "first_name": Global.userFirstname ?? '',
        "last_name": Global.userLastname ?? '',
        "address_line1": addressLine1Controller.text,
        "city":cityController.text,
        "state": selectedCountry.value,
        "zip": postalCodeController.text,
        "country_code": selectedCountryCode.value,
      };

      print('body:: ${body.toString()}');
      print('token :: ${token}');

      final response = await http.post(
        Uri.parse('${ApiConstants.SAVE_PAYMENTCARD}'),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      final data = json.decode(response.body);

      print('data:: ${data}');

      if (response.statusCode == 200 && data['success']) {
      //  savedCard.value = PaymentcardModel.fromJson(data['data']['card_details']);
        Get.snackbar("Success", data['message']);
        print("Payment Method ID: ${data['data']['payment_method_id']}");
        print("Customer ID: ${data['data']['customer_id']}");
        Get.snackbar('Success', 'Card saved successfully!');
      } else {
        Get.snackbar('Failed', data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      debugPrint('Error saving card: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> savePaymentCard() async {
    isLoading.value = true;
    String? token = await TokenStorage.getToken();
    try{

      final billingDetails = BillingDetails(
        name: "${firstNameController.text} ${lastNameController.text}",
        email: Global.email,
        address: Address(
          city: cityController.text,
          country: selectedCountryCode.value,
          line1: addressLine1Controller.text,
          postalCode: postalCodeController.text, line2: '', state: '',
        ),
      );

      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: billingDetails,
          ),
        ),
      );

      final paymentMethodId = paymentMethod.id;
      print("Created PaymentMethod ID: $paymentMethodId");


      final model  = CardModel(
          cardNumber: cardNumberController.text,
          expireMonth: expiryMonthController.text,
          expireYear: expiryYearController.text,
          securityCode: securityCodeController.text,
          firstName: Global.userFirstname??'',
          lastName: Global.userLastname??'',
          addressLine1: addressLine1Controller.text,
          city: cityController.text,
          state: selectedCountry.value,
          zip: postalCodeController.text,
          countryCode: selectedCountry.value,
          paymentMethodId: paymentMethodId
      );
      var response = await http.post(
        Uri.parse('${ApiConstants.SAVE_PAYMENTCARD}'),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()),
      );
      print('statuscode ==> ${response.statusCode}');
      if(response.statusCode == 200){
        print('response body ==> ${response.body}');

        return jsonDecode(response.body);
      }else{
        throw Exception("Failed to save card: ${response.body}");
      }


    }catch(e){
      print('Error =====> ${e.toString()}');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> submitBilling() async {
    isLoading.value = true;
    String? token = await TokenStorage.getToken();

    try {
      // 1. Create Payment Method from CardField
      final billingDetails = BillingDetails(
        name: "${firstNameController.text} ${lastNameController.text}",
        email: Global.email,
        address: Address(
          city: cityController.text,
          country: selectedCountryCode.value,
          line1: addressLine1Controller.text,
          postalCode: postalCodeController.text, line2: '', state: '',
        ),
      );

      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: billingDetails,
          ),
        ),
      );

      final paymentMethodId = paymentMethod.id;
      print("Created PaymentMethod ID: $paymentMethodId");

      // 2. Prepare model
      final model = PaymentMethodModel(
        //userId: Global.userId??'',
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: Global.email??'', // <- Replace with actual email
        isPrimary: true,
        paymentMethodId: paymentMethodId,
        address: BillingAddress(
          // country: "United States",
          // addressLine: "123 Main Street",
          // city: "New York",
          // postalCode: "10001",
          country: selectedCountryCode.value,
          addressLine: addressLine1Controller.text,
          city: cityController.text,
          postalCode: postalCodeController.text,
        ),
      );



      // 3. Send to backend
      var response = await http.post(
        Uri.parse('${ApiConstants.TEMP_URL}/add/billing'),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()),
      );

      print('Backend response code: ${response.statusCode}');
      print('Backend response body: ${response.body}');

      if (response.statusCode == 200) {
        // final jsonResponse = jsonDecode(response.body);
        // final subscriptionId = jsonResponse['data']['subscription']['id'];
        // final clientSecret = jsonResponse['data']['clientSecret'];
        //
        // print('Subscription created: $subscriptionId');
        // print('Client secret: $clientSecret');
        //
        // await confirmPayment(clientSecret); /// add new

        Get.snackbar('Success', 'Billing method added successfully');
        Get.back();
      } else {
        final jsonError = jsonDecode(response.body);
        print('Error =====--> ${jsonError['message']}');
        Get.snackbar('Error', 'Failed to add billing method');
      }
    } catch (e) {
      print('Error =====> ${e.toString()}');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> confirmPayment(String clientSecret) async {
    try {
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );
      print('Payment confirmed');
    } catch (e) {
      print('Payment confirmation error: $e');
      Get.snackbar('Error', 'Payment confirmation failed');
    }
  }















  var primaryMethod = ''.obs;

  Future<void> createPaymentCard(PaymentMethodModel model) async {
    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse("https://your-api-domain.com/api/payment/card"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        primaryMethod.value = data['data']['payment']['billing_address']; // Example field
        Get.snackbar("Success", "Payment method added successfully");
      } else {
        Get.snackbar("Error", "Failed to add payment method");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void removePrimaryMethod() {
    primaryMethod.value = '';
    Get.snackbar("Removed", "Primary billing method removed");
  }

  void toggleBillingMethod(){
    showAddBillingMethod.value = !showAddBillingMethod.value;
  }

  void cancelEdit() {
    showAddBillingMethod.value = false;
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:orbitwork/comms/global/global_tooltip.dart';

import '../controllers/add_billing_controller.dart';

class AddBillingMethod extends StatelessWidget {
  final AddBillingController controller = Get.put(AddBillingController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Billing & payments',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add a billing method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              _buildCancelButton(),
              SizedBox(height: 20),
              _buildPaymentOptions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      child: TextButton(
        onPressed: () => Get.back(),
        child: Text(
          'Cancel',
          style: TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade300, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      children: [
        _buildPaymentOption(
          'Payment card',
          'Visa, Mastercard, American Express, Discover, Diners',
          'card',
        ),
        SizedBox(
          height: 16,
        ),
        Obx(() {
          return controller.selectedMethod.value == 'card'
              ? _showPaymentCard()
              : SizedBox();
        }),
        _buildPaymentOption(
          'PayPal',
          '',
          'paypal',
          paypalLogo: true,
        ),
        Obx(() {
          return controller.selectedMethod.value == 'paypal'
              ? _showPayPal()
              : SizedBox();
        }),
      ],
    );
  }

  // Widget _showPaymentCard() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       // CardField replaces separate card number, expiry, and cvc fields
  //       Text(
  //         'Card Details',
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //       ),
  //       SizedBox(height: 12),
  //       Container(
  //         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.grey),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: CardField(
  //           controller: controller.cardFieldController,
  //           decoration: InputDecoration.collapsed(hintText: 'Card details'),
  //           style: TextStyle(fontSize: 16),
  //           onCardChanged: (card) {
  //             controller.cardDetails.value = card;
  //           },
  //         ),
  //         // child: CardFormField(
  //         //   controller: controller.cardFormFieldController,
  //         //   enablePostalCode: false,
  //         //   style: CardFormStyle(fontSize: 16),
  //         //   onCardChanged: (formDetails) {
  //         //     controller.cardFormDetails.value = formDetails;
  //         //   },
  //         // ),
  //       ),
  //       SizedBox(height: 24),
  //
  //       // First name
  //       Text('First name', style: TextStyle(fontSize: 16)),
  //       SizedBox(height: 8),
  //       Container(
  //         height: 40,
  //         child: TextField(
  //           controller: controller.firstNameController,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             contentPadding: EdgeInsets.symmetric(horizontal: 12),
  //           ),
  //         ),
  //       ),
  //       SizedBox(height: 24),
  //
  //       // Last name
  //       Text('Last name', style: TextStyle(fontSize: 16)),
  //       SizedBox(height: 8),
  //       Container(
  //         height: 40,
  //         child: TextField(
  //           controller: controller.lastNameController,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             contentPadding: EdgeInsets.symmetric(horizontal: 12),
  //           ),
  //         ),
  //       ),
  //       SizedBox(height: 24),
  //
  //       // Billing address
  //       Text(
  //         'Billing address',
  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  //       ),
  //       SizedBox(height: 16),
  //
  //       // Country
  //       Text('Country', style: TextStyle(fontSize: 16)),
  //       SizedBox(height: 8),
  //       Container(
  //         height: 40,
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.grey),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: Obx(() => DropdownButtonHideUnderline(
  //           child: DropdownButton<String>(
  //             value: controller.selectedCountryCode.value,
  //             isExpanded: true,
  //             icon: Icon(Icons.keyboard_arrow_down),
  //             padding: EdgeInsets.symmetric(horizontal: 16),
  //             items: controller.countries.map((country) {
  //               return DropdownMenuItem<String>(
  //                 value: country['code'],
  //                 child: Text(country['name']!),
  //               );
  //             }).toList(),
  //             onChanged: (String? newValue) {
  //               if (newValue != null) {
  //                 controller.selectedCountryCode.value = newValue;
  //               }
  //             },
  //           ),
  //         )),
  //       ),
  //       SizedBox(height: 24),
  //
  //       // Address line 1
  //       Text('Address line 1', style: TextStyle(fontSize: 16)),
  //       SizedBox(height: 8),
  //       Container(
  //         height: 40,
  //         child: TextField(
  //           controller: controller.addressLine1Controller,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             contentPadding: EdgeInsets.symmetric(horizontal: 12),
  //           ),
  //         ),
  //       ),
  //       SizedBox(height: 24),
  //
  //       // Address line 2 (optional)
  //       RichText(
  //         text: TextSpan(
  //           children: [
  //             TextSpan(
  //               text: 'Address line 2 ',
  //               style: TextStyle(fontSize: 16, color: Colors.black),
  //             ),
  //             TextSpan(
  //               text: '(optional)',
  //               style: TextStyle(fontSize: 16, color: Colors.grey),
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 8),
  //       Container(
  //         height: 40,
  //         child: TextField(
  //           controller: controller.addressLine2Controller,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             contentPadding: EdgeInsets.symmetric(horizontal: 12),
  //           ),
  //         ),
  //       ),
  //       SizedBox(height: 24),
  //
  //       // City
  //       Text('City', style: TextStyle(fontSize: 16)),
  //       SizedBox(height: 8),
  //       Container(
  //         height: 40,
  //         child: TextField(
  //           controller: controller.cityController,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             contentPadding: EdgeInsets.symmetric(horizontal: 12),
  //           ),
  //         ),
  //       ),
  //       SizedBox(height: 24),
  //
  //       // Postal Code (optional)
  //       RichText(
  //         text: TextSpan(
  //           children: [
  //             TextSpan(
  //               text: 'Postal code ',
  //               style: TextStyle(fontSize: 16, color: Colors.black),
  //             ),
  //             TextSpan(
  //               text: '(optional)',
  //               style: TextStyle(fontSize: 16, color: Colors.grey),
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 8),
  //       Container(
  //         height: 40,
  //         child: TextField(
  //           controller: controller.postalCodeController,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             contentPadding: EdgeInsets.symmetric(horizontal: 12),
  //           ),
  //           keyboardType: TextInputType.number,
  //         ),
  //       ),
  //       SizedBox(height: 32),
  //
  //       // Submit button
  //       SizedBox(
  //         width: double.infinity,
  //         height: 40,
  //         child: Obx(() {
  //           return controller.isLoading.value
  //               ? Center(child: CircularProgressIndicator())
  //               : ElevatedButton(
  //             onPressed: controller.submitBilling,
  //             child: Text('Submit', style: TextStyle(fontSize: 16)),
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.green,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //             ),
  //           );
  //         }),
  //       ),
  //       SizedBox(height: 24),
  //       Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
  //       SizedBox(height: 24),
  //     ],
  //   );
  // }



  Widget _showPaymentCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Card number',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                _buildCardTypeButton('visa', 'VISA'),
                _buildCardTypeButton('mastercard', 'Mastercard'),
                _buildCardTypeButton('amex', 'American Express'),
                _buildCardTypeButton('discover', 'Discover'),
                _buildCardTypeButton('diners-club', 'Diners'),
              ],
            ),
          ],
        ),

        SizedBox(height: 16),

        // Card number input
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CardField(
            controller: controller.cardFieldController,
            decoration: InputDecoration.collapsed(hintText: 'Card details'),
            style: TextStyle(fontSize: 16),
            onCardChanged: (card) {
              controller.cardDetails.value = card;
            },
          ),
          // child: TextField(
          //   onChanged: (value) => controller.validateCardNumber(value),
          //   controller: controller.cardNumberController,
          //   decoration: InputDecoration(
          //     hintText: '1234 5678 9012 3456',
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //       errorText: controller.cardError.value,
          //     prefixIcon: Icon(Icons.credit_card, color: Colors.grey,),
          //     suffixIcon: Icon(Icons.lock, color: Colors.grey,),
          //     contentPadding: EdgeInsets.symmetric(horizontal: 12)
          //   ),
          //   keyboardType: TextInputType.number,
          // ),
        ),

        SizedBox(height: 24),

        // First name
        Text(
          'First name',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Container(
          height: 40,
          child: TextField(
            controller: controller.firstNameController,
            decoration: InputDecoration(
                // hintText: 'Ishita',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12)),
          ),
        ),

        SizedBox(height: 24),

        // Last name
        Text(
          'Last name',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Container(
          height: 40,
          child: TextField(
            controller: controller.lastNameController,
            decoration: InputDecoration(
                // hintText: 'Poshiya',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12)),
          ),
        ),

        SizedBox(height: 24),

        // Expiration date
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiration month',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 40,
                    child: TextField(
                      onChanged: (value) => controller.validateMonth(value),
                      controller: controller.expiryMonthController,
                      decoration: InputDecoration(
                          hintText: 'MM',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorText: controller.monthError.value,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12)),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiration year',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 40,
                    child: TextField(
                      onChanged: (value) => controller.validateYear(value),
                      controller: controller.expiryYearController,
                      decoration: InputDecoration(
                          hintText: 'YY',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorText: controller.yearError.value,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12)),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 24),

        // Security code
        Row(
          children: [
            Text(
              'Security code',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 8),
            GlobalTooltip(
                text:
                    'The 3-digit number located on the back right side of your card.'),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 40,
          child: TextField(
            onChanged: (value) => controller.validateCVC(value),
            controller: controller.securityCodeController,
            decoration: InputDecoration(
                hintText: '3 digits',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: controller.cvcError.value,
                contentPadding: EdgeInsets.symmetric(horizontal: 12)),
            keyboardType: TextInputType.number,
          ),
        ),

        SizedBox(height: 24),

        // Billing address
        Text(
          'Billing address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: 16),

        // Country
        Text(
          'Country',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedCountryCode.value,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  // items: controller.countries.map((String country) {
                  //   return DropdownMenuItem<String>(
                  //     value: country,
                  //     child: Text(country),
                  //   );
                  // }).toList(),
                  items: controller.countries.map((Map<String, String> country) {
                    return DropdownMenuItem<String>(
                      value: country['code'], // Use 2-letter code for value
                      child: Text(country['name'] ?? ''), // Show name in the dropdown
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedCountryCode .value = newValue;
                    }
                  },
                ),
              )),
        ),

        SizedBox(height: 24),

        // Address line 1
        Text(
          'Address line 1',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Container(
          height: 40,
          child: TextField(
            controller: controller.addressLine1Controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12)),
          ),
        ),

        SizedBox(height: 24),

        // Address line 2 (optional)
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Address line 2 ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: '(optional)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 40,
          child: TextField(
            controller: controller.addressLine2Controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12)),
          ),
        ),

        SizedBox(height: 24),

        // City
        Text(
          'City',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Container(
          height: 40,
          child: TextField(
            controller: controller.cityController,
            decoration: InputDecoration(
                hintText: 'Rajkot',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12)),
          ),
        ),

        SizedBox(height: 24),

        // Postal code (optional)
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Postal code ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: '(optional)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 40,
          child: TextField(
            controller: controller.postalCodeController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12)),
            keyboardType: TextInputType.number,
          ),
        ),

        SizedBox(height: 32),

        // Save button
        SizedBox(
          width: double.infinity,
          height: 40,
          child: Obx(() {
            return controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.saveCard,
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        textStyle: TextStyle(fontSize: 16),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  );
          }),
          // ElevatedButton(
          //   onPressed: () {
          //     // Handle save logic
          //     Get.snackbar(
          //       'Success',
          //       'Billing address saved successfully',
          //       snackPosition: SnackPosition.BOTTOM,
          //     );
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.green,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   child: Text(
          //     'Save',
          //     style: TextStyle(
          //       fontSize: 16,
          //       color: Colors.white
          //     ),
          //   ),
          // ),
        ),

        SizedBox(height: 24),

        // Divider
        Divider(height: 1, thickness: 1, color: Colors.grey.shade300),

        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCardTypeButton(String type, String name) {
    return Obx(() => Row(
          children: [
            GestureDetector(
              onTap: () => controller.selectedCardType.value = type,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    // controller.selectedCardType.value == type
                    //     ? Colors.blue
                    //     : Colors.grey.shade300,
                    width: controller.selectedCardType.value == type ? 1 : 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.asset(
                  'assets/icon/$type.png',
                  width: 25,
                  height: 15,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: 4,
            )
          ],
        ));
  }

  Widget _showPayPal() {
    return Column(
      children: [
        Image.asset(
          'assets/icon/card.png',
          height: 70,
          width: 70,
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'You are about to leave Orbitwork',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          'You will be redirected to PayPal so you can connect your PayPal account to Orbitwork.',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 24,
        ),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.blue.shade800,
              minimumSize: const Size(40, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(text: 'Pay with ', style: TextStyle(fontSize: 14)),
              TextSpan(
                  text: 'PayPal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
            ])))
      ],
    );
  }

  Widget _buildPaymentOption(String title, String subtitle, String value,
      {bool paypalLogo = false}) {
    return Obx(() {
      final isSelected = controller.selectedMethod.value == value;

      return InkWell(
        onTap: () => controller.setSelectedMethod(value),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 16),
              paypalLogo
                  ? Image.asset(
                      'assets/icon/paypal.png',
                      height: 25,
                    )
                  : Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (subtitle.isNotEmpty)
                            Text(
                              subtitle,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
                          
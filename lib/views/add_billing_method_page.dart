import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_billing_controller.dart';

class AddBillingMethod extends StatelessWidget {
  final AddBillingController controller = Get.put(AddBillingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Billing & payments',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
            side: BorderSide(color: Colors.grey.shade300,width: 2),
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
        _buildPaymentOption(
          'PayPal',
          '',
          'paypal',
          paypalLogo: true,
        ),
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

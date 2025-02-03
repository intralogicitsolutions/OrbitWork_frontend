import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/billing_and_payment_controller.dart';
import '../routes/app_routes.dart';

class BillingAndPayments extends StatelessWidget {
  final BillingController controller = Get.put(BillingController());

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
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage billing methods',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Add, update, or remove your billing methods.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Primary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Your primary billing method is used for all recurring payments.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: 16),
            // Obx(() => controller.primaryMethod.value.isNotEmpty
            //     ? _buildPrimaryMethodCard()
            //     : SizedBox()),
            // Obx(() => _buildPrimaryMethodCard()),
            _buildPrimaryMethodCard(),
            SizedBox(height: 16),
            _buildAddBillingButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryMethodCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/visa.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 8),
            Text(
              'Visa ending in : 1234',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4,),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // Handle edit
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
           SizedBox(width: 24),
            TextButton(
              onPressed: () {
                controller.removePrimaryMethod();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Remove',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddBillingButton() {
    return TextButton.icon(
      onPressed: () {
        Get.toNamed(AppRoutes.addBillingMethod);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: Icon(
        Icons.add,
        color: Colors.green,
      ),
      label: Text(
        'Add a billing method',
        style: TextStyle(
          color: Colors.green,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
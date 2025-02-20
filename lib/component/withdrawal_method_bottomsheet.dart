import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_paid_controller.dart';
import '../models/withdrawal_method.dart';

class WithdrawalMethodBottomSheet extends StatelessWidget {
  final controller = Get.put(GetPaidController());

  WithdrawalMethodBottomSheet({Key? key}) : super(key: key);

  Widget _buildMethodCard(WithdrawalMethod method) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: method.isBank
              ? Image.asset(
                  'assets/icon/bank.png',
                  width: 40,
                  height: 40,
                )
              : Image.asset(
                  'assets/icon/paypal2.png',
                  width: 50,
                  height: 50,
                ),
          title: Text(
            method.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 82),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: method.details.map((detail) {
              if (detail.contains('additional fees')) {
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'PayPal may charge ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'additional fees',
                        style: TextStyle(
                            color: Colors.green.shade700,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.green),
                      ),
                      TextSpan(
                          text: ' for sending and withdrawing funds',
                          style: TextStyle(color: Colors.black))
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  detail,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: OutlinedButton(
            onPressed: () => controller.setupWithdrawalMethod(method.title),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              side: const BorderSide(color: Colors.green),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Set up',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: const Text(
                    'Add a withdrawal method',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tell us how you want to get your funds. For all account types, it may take up to 3 days to activate.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.brown[400]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style:
                              TextStyle(color: Colors.brown[400], fontSize: 14),
                          children: [
                            const TextSpan(
                              text:
                                  'The name on your withdrawal method and the name on your ',
                            ),
                            TextSpan(
                              text: 'Upwork account',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.brown[400],
                              ),
                            ),
                            const TextSpan(
                              text:
                                  ' need to match exactly to avoid payment failures or delays. ',
                            ),
                            TextSpan(
                              text: 'Learn more in our help article',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.brown[400],
                              ),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Recommended for India',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Image.asset(
                  'assets/icon/global-location.png',
                  width: 50,
                  height: 50,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: const Text('Direct to Local Bank (INR)'),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icon/right.png',
                          width: 20,
                          height: 20,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        const Text('\$0.99 USD per withdrawal'),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icon/right.png',
                          width: 20,
                          height: 20,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: const Text(
                                'Deposit to your local bank account in INR')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.setupWithdrawalMethod('bank'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Set up',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Also Available',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
             ...controller.methods.map(_buildMethodCard).toList(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
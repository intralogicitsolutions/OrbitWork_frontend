import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/get_paid_controller.dart';

import '../component/withdrawal_method_bottomsheet.dart';

class GetPaidPage extends StatelessWidget {
  final GetPaidController controller = Get.put(GetPaidController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Get Paid',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400)),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Available balance'),
                    Text(
                      '\$${controller.price}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: theme.primaryColor),
                    ),
                    Row(
                      children: [
                        Text(
                          '+\$${controller.pending} pending',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Icon(
                          Icons.info_outline,
                          size: 12,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.amber.shade50,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.brown[400],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      'To withdraw earnings, please update your ',
                                  style: TextStyle(color: Colors.brown[400])),
                              TextSpan(
                                text: 'tax information. ',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.brown[400]),
                              ),
                              TextSpan(
                                  text: 'For more details, read our ',
                                  style: TextStyle(color: Colors.brown[400])),
                              TextSpan(
                                  text: 'FAQs.',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.brown[400])),
                            ])),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100]),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'To withdraw earnings, first you need to set up a withdrawal method.',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'It may take up to 3 days to activate your withdrawal method.',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.bottomSheet(WithdrawalMethodBottomSheet(),
                                      isScrollControlled: true,
                                      isDismissible: true);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Add a method',
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400)),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Withdrawal schedule',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'You haven\'t set up a schedule yet. You\'ll be able to set it up once you\'ve added a withdrawal method.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400)),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last withdrawal',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'You haven\'t made any withdrawals yet.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400)),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Withdrawal methods',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          Get.bottomSheet(WithdrawalMethodBottomSheet(),
                              isScrollControlled: true,
                              isDismissible: true);
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40),
                          side: BorderSide(color: Colors.grey.shade400, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Add a method',
                          style: TextStyle(color: theme.primaryColor),
                        )),
                    SizedBox(height: 16,),
                    Text('You haven\'t set up any withdrawal method yet.',
                    style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w300
                    ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

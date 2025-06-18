import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/set_user_rate_controller.dart';
import '../../routes/app_routes.dart';

class SetUserRate extends StatelessWidget {
  final SetUserRateController controller = Get.put(SetUserRateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Now, let\'s set your hourly rate.',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Clients will see this rate on your profile and in search results once you publish your profile. You can adjust your rate every time you submit a proposal.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Hourly rate',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Total amount the client will see.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: controller.hourlyRateController,
                              keyboardType: TextInputType.number,
                              onChanged: controller.calculateFee,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: '\$0.00',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintTextDirection: TextDirection.rtl),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('/hr'),
                        ))
                      ],
                    ),
                    Divider(
                      height: 40,
                      color: Colors.grey[300],
                    ),
                    Text(
                      'Service fee',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'This helps us run the platform and provide services like payment protection and customer support.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300], // Background color
                                borderRadius: BorderRadius.circular(8), // Rounded corners
                              ),
                              // child: TextField(
                              //   decoration: InputDecoration(
                              //     filled: true,
                              //       fillColor: Colors.transparent,
                              //       contentPadding: EdgeInsets.symmetric(
                              //           horizontal: 12, vertical: 0),
                              //       border: InputBorder.none,
                              //       hintText: '\$0.00',
                              //       hintStyle: TextStyle(color: Colors.grey),
                              //       hintTextDirection: TextDirection.rtl),
                              // ),
                              child: Obx(() => Text(
                                '-\$${controller.serviceFee.value.toStringAsFixed(2)} /hr',
                                style: TextStyle(fontSize: 16, color: Colors.redAccent),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('/hr'),
                        )),
                      ],
                    ),
                    Divider(
                      height: 40,
                      color: Colors.grey[300],
                    ),
                    Text(
                      'You\'ll get',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'The estimated amount you\'ll receive after service fees',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            // child: TextField(
                            //   decoration: InputDecoration(
                            //       contentPadding: EdgeInsets.symmetric(
                            //           horizontal: 12, vertical: 0),
                            //       border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(8)),
                            //       hintText: '\$0.00',
                            //       hintStyle: TextStyle(color: Colors.grey),
                            //       hintTextDirection: TextDirection.rtl),
                            // ),
                            child:  Obx(() => Text(
                              '\$${controller.receiveAmount.value.toStringAsFixed(2)} /hr',
                              style: TextStyle(fontSize: 18, color: Colors.green),
                            )),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('/hr'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

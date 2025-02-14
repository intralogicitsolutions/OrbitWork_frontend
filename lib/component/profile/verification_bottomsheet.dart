import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/profile/verification_controller.dart';
import '../../controllers/work_experience_controller.dart';
import '../select_country_bottomsheet.dart';

class VerificationBottomsheet extends StatelessWidget {
  final WorkExperienceController workController = Get.put(WorkExperienceController());
  final VerificationController controller = Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Get.back(),
                        ),
                        const Text(
                          'Upwork',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.cyan[900], // Set background color to green
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16), // Round only top-left corner
                        topRight: Radius.circular(16), // Round only top-right corner
                      ),
                    ),
                    child: Center(
                      child: Lottie.asset(
                        'assets/lottie/medal.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Tell us about your military service history.',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Looking for a way to stand out from the crowd? Military veterans are routinely sought after by clients who are looking to increase their engagement with the veteran business community. ?',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: 24,),
                        const Text(
                          'I served in the military for:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                    height: Get.height * 0.9,
                                    child: CountryBottomsheet()),
                                isScrollControlled: true,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // Center items
                                children: [
                                  Obx(() {
                                    return Text(
                                      // 'Country',
                                      workController.selectedCountry.value.isEmpty
                                          ? 'India'
                                          : workController.selectedCountry.value,
                                    );
                                  }),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.keyboard_arrow_down, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        RadioListTile(
                          value: false,
                          groupValue: controller.hasServed.value,
                          onChanged: (value) => controller.setHasServed(false),
                          title: const Text('I did not serve in the military'),
                        ),
                        RadioListTile(
                          value: true,
                          groupValue: null,
                          onChanged: null,
                          title: const Text("I don't want to disclose this information"),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Cancel', style: TextStyle(color: Colors.green),),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle next action
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

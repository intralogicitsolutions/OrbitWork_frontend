import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/work_experience_controller.dart';

import '../../component/add_work_experience_bottomsheet.dart';
import '../../routes/app_routes.dart';

class AddExperience extends StatelessWidget {
  final WorkExperienceController controller = Get.put(WorkExperienceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      'If you have relevant work experience, add it here.',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Freelancers who add their experience are twice as likely to win work. But if you\'re just starting out, you can still create a great profile. just head on to the next page.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Obx(
                       () {
                        return controller.title.value != '' && controller.company.value != '' ?Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${controller.title.value}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                    Text('${controller.company.value}')
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.green),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                          Icons.edit,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                    ),
                                    onPressed: () {

                                    },
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Container(
                                     padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.green),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                    ),
                                    onPressed: () {

                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ): SizedBox();
                      }
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Get.bottomSheet(
                           Container(
                             height: Get.height * 0.8,
                                 child: WorkExperienceSheet()),
                          isScrollControlled: true,
                          ignoreSafeArea: false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.green, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Add experience',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

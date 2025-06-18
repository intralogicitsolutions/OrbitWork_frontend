import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../component/add_education_history_bottomsheet.dart';
import '../../controllers/education_history_controller.dart';
import '../../routes/app_routes.dart';

class AddEducation extends StatelessWidget{
  final EducationHistoryController controller = Get.put(EducationHistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40,),
                    Text('Clients like to know what you know - add your education here.',
                      style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('You don\'t have to have a degree. Adding any relevant education helps make your profile more visible',
                    style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Obx(
                            () {
                          return controller.school.value != '' ?Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text('${controller.school.value}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
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
                              child: EducationHistoryBottomsheet()),
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
                            'Add education',
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
          ),
        ],
      ),
    );
  }

}
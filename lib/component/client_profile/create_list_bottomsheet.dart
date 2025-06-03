import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../client_profile_controller/talent_controller.dart';

class CreateListBottomsheet extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TalentController controller = Get.put(TalentController());
  @override
  Widget build(context) {
    //final topPadding = MediaQuery.of(context).padding.top * 0.001;

    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: Text('Create List'),
            leading: IconButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              icon: Icon(Icons.close),
            ),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            foregroundColor: Colors.black,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('List name', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 4), // space between field and error
                          Container(
                            height: 16, // fixed height for error text (even when empty)
                            child: Obx(() => Text(
                              controller.errorText.value,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            )),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),
                      Text('How would you describe this list?', style: TextStyle(fontSize: 16)),
                      Text('(Optional)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(height: 12,),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 32),
                      Divider(height: 24,),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                                Get.back();
                              },
                              child: Text('Cancel', style: TextStyle(color: Get.theme.primaryColor)),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                controller.validateAndCreate(nameController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Get.theme.primaryColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                              ),
                              child: Text('Create list', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

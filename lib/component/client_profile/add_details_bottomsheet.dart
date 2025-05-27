import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_controller/add_details_controller.dart';

class AddDetailsBottomsheet extends StatelessWidget{
  final AddDetailsController controller = Get.put(AddDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Post a job'),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.close)),
        actions: [
          IconButton(onPressed: () {},
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Obx(() {
              return Column(
                children: [
                  Text('Add any details you have to start with in a sentence or two.', style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w400, height: 1.3
                  ),),
                  SizedBox(height: 20,),

                      TextField(
                        controller: controller.textController,
                        maxLines: null, // Expand as needed
                        onChanged: controller.onTextChanged,
                        decoration: InputDecoration(
                          hintText:
                          'E.g. I need someone to help me build a Shopify website for my office furniture business.',
                          hintStyle: TextStyle(fontSize: 13),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: controller.errorMessages.isEmpty ? Colors.grey : Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: controller.errorMessages.isEmpty
                                    ? Theme.of(context).primaryColor
                                    : Colors.red),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      ...controller.errorMessages
                          .map((msg) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.red, size: 16),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                msg,
                                style: TextStyle(color: Colors.red, fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      ))
                          .toList(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${controller.remainingChars} characters left',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

}
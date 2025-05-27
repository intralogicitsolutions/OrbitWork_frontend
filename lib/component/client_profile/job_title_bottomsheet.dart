import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../client_profile_controller/job_title_controller.dart';

class JobTitleBottomsheet extends StatelessWidget{
  final JobTitleController controller = Get.put(JobTitleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Headline'),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.close)),
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.blue.shade700),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Just a reminder to publish your job post, you\'ll need to',
                            style: TextStyle(color: Colors.blue.shade700),
                          ),
                          Text('verify your phone number', style: TextStyle(color: Get.theme.primaryColor))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12,),
              Text('Let\'s start with a strong title.', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
              SizedBox(height: 20,),
              Text('This helps your job post stand out to the right candidates. It\'s the first thing they\'ll see, so make it count!',
              style: TextStyle(
                color: Get.theme.hintColor
              ),),
              SizedBox(height: 20,),
              Obx(() {
                final hasError = controller.errors.isNotEmpty;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a title for your job post',
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: hasError ? Colors.red : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: hasError ? Colors.red : Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      onChanged: controller.validateTitle,
                    ),
                    const SizedBox(height: 8),
                    if (hasError)
                      ...controller.errors.map((error) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.red,size: 16,),
                            Text(
                              error,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ],
                        ),
                      )),
                  ],
                );
              }),
              Obx(() => Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Example titles",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    ...controller.exampleTitles.map((title) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("• ", style: TextStyle(fontSize: 16)),
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(fontSize: 15, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

}
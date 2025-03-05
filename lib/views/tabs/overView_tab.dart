import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../comms/url_launcher_helper.dart';
import '../../component/add_todo_bottomsheet.dart';
import '../../component/decrease_rate_bottomsheet.dart';
import '../../component/upload_file_bottomsheet.dart';
import '../../controllers/workroom_timesheet_controller.dart';
import '../../routes/app_routes.dart';

class OverViewPage extends StatelessWidget {
  final TimesheetController controller = Get.put(TimesheetController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTimesheet(context),
            _buildToDos(context),
            _buildRecentFiles(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimesheet(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Earnings this week',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                '\$${controller.earningThisWeek}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: theme.secondaryHeaderColor,
                        height: 1.5,
                        fontSize: 13,
                      ),
                      children: [
                    TextSpan(
                        text:
                            'You will get paid for these hours on Monday.(Orbitwork\'s billing timezone) '),
                    TextSpan(
                        text: 'Learn more',
                        style: TextStyle(color: theme.primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => UrlLauncherHelper.openUrl('https://www.google.com'),
                    )
                  ])),
              Divider(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contract\'s rate'),
                        Text('${controller.contractRate} /hr'),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                height: Get.height * 0.9,
                                  child: DecreaseRateBottomsheet(),
                              ),
                              isScrollControlled: true,
                              enableDrag: true,
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                'Change rate',
                                style: TextStyle(color: theme.primaryColor),
                              ),
                              Icon(
                                Icons.edit_outlined,
                                color: theme.primaryColor,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('This week\'s tracked'),
                        Text(
                          '${controller.sinceStart} hrs',
                        ),
                        Text('of ${controller.weeklylimit} hrs weekly limit')
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.timeSheet, arguments: true);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.green,
                    minimumSize: Size(Get.width, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'View timesheet',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToDos(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'To-dos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.primaryColor,
                    width: 1, // Border thickness
                  ),
                ),
                child: IconButton(onPressed: () {
                  Get.bottomSheet(
                    Container(
                      height: Get.height * 0.9,
                        child: TodoBottomSheet()),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    enableDrag: true,
                  );
                }, icon: Icon(Icons.add, size: 20, color: theme.primaryColor,)),
              )
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icon/checkmark.png',
                    height: 120,
                    width: 120,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Add to-dos to your project with Cofounderslab to organize, prioritize, and track your collaboration.',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentFiles() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Recent files',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.green,
                      )),
                  OutlinedButton(
                      onPressed: () {
                        Get.bottomSheet(
                          Container(
                              height: Get.height * 0.9,
                              child: UploadFileBottomsheet()),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: true,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                        side: BorderSide(color: Colors.grey.shade300, width: 2),
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Upload',
                        style: TextStyle(color: Colors.green),
                      ))
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Image.asset(
                'assets/icon/open-folder.png',
                height: 120,
                width: 120,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Files shared in messages, work submissions, or as part of the requirements, will be shown here',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}

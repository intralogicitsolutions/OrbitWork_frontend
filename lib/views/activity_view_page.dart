import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/activity_controller.dart';

class ActivityView extends StatelessWidget {
  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab-like header for Activity
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       GestureDetector(
          //         onTap: () {}, // Add tab-switching logic for "Activity"
          //         child: Column(
          //           children: [
          //             Text(
          //               "Activity",
          //               style: TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.green,
          //               ),
          //             ),
          //             Container(
          //               height: 3,
          //               width: 50,
          //               color: Colors.green,
          //             ),
          //           ],
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           Get.toNamed("/jobAlerts"); // Navigate to "Job Alerts" page
          //         },
          //         child: Text(
          //           "Job alerts",
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.grey,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: 10),
          // Section Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Most Recent",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (controller.activities.isEmpty) {
                return Center(child: Text("No recent activities"));
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                           color: theme.highlightColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text('No new Notification',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                                ),
                                Expanded(
                                  child: SvgPicture.asset(
                                    'assets/icon/no-notification.svg', // Path to your SVG file
                                    height: 40, // Adjust the size of the SVG icon
                                    width: 40,
                                  ),
                                ),
                              ],
                            ))),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.activities.length,
                      itemBuilder: (context, index) {
                        final activity = controller.activities[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: activity.iconColor.withOpacity(0.2),
                                child: Icon(activity.icon, color: activity.iconColor),
                              ),
                              title: Text(
                                activity.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Text(
                                activity.subtitle,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              trailing: Text(
                                activity.date,
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            Divider()
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
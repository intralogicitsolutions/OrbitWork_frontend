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
                        height: 60,
                        decoration: BoxDecoration(
                           color: theme.hoverColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Center(
                                      child: Text('No new Notification',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SvgPicture.asset(
                                    'assets/icon/no-notification.svg', // Path to your SVG file
                                    height: 50, // Adjust the size of the SVG icon
                                    width: 50,
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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Divider(),
                            )
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
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/activity_controller.dart';
import '../widgets/custom_shimmer.dart';

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
            child:
              // if (controller.activities.isEmpty) {
              //   return Center(child: Text("No recent activities"));
              // }
               Column(
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
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text('No new Notification',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SvgPicture.asset(
                                    'assets/icon/no-notification.svg',
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                              ],
                            ))),
                  ),
                  Expanded(
                    child: Obx(
                       () {
                         if (controller.isLoading.value) {
                           return ListView.builder(
                             itemCount: 4, // Number of shimmer placeholders
                             itemBuilder: (context, index) {
                               return Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                 child: CustomShimmer(
                                   width: MediaQuery.of(context).size.width * 0.9,
                                   height: 40,
                                 ),
                               );
                             },
                           );
                         }
                        return ListView.builder(
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
                        );
                      }
                    ),
                  ),
                ],
              ),

          ),
        ],
      ),
    );
  }
}
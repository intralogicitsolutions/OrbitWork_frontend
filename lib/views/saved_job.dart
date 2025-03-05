import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/jobs_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/job_card.dart';

class SavedJobPage extends StatelessWidget{
  final JobsController controller = Get.put(JobsController());
  final ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orbitwork'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
        ],
      ),
      body: Column(
        children: [
          controller.favoriteJobs.isEmpty
              ? Obx(() {
            return Card(
              //color: Colors.white,
              color: Get.theme
                  .scaffoldBackgroundColor,
              child: Column(
                children: [
                  Padding(
                    padding:
                    EdgeInsets
                        .all(
                        20.0),
                    child: Center(
                      child: themeController
                          .themeMode
                          .value ==
                          ThemeMode
                              .dark
                          ? Image
                          .asset(
                        'assets/icon/touch_light.png',
                        height:
                        60,
                        width:
                        60,
                      )
                          : Image
                          .asset(
                        'assets/icon/touch.png',
                        height:
                        60,
                        width:
                        60,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets
                        .all(
                        20.0),
                    child: Text(
                      "Keep track of jobs you're interested in. Select the heart icon on the job post to save it for later.",
                      textAlign:
                      TextAlign
                          .center,
                      // style: TextStyle(
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.w400,
                      //   color: Colors.grey.shade600
                      // ),
                      style: Theme.of(
                          context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(),
                      //style: theme.textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            );
          })
              : Column(
            children: controller
                .favoriteJobs
                .map((job) =>
                JobCard(
                    job: job))
                .toList(),
          ),
        ],
      ),
    );

  }

}
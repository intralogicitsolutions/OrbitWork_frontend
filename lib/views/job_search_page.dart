import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/filter_by_bottomsheet.dart';
import '../component/save_search_bottomsheet.dart';
import '../controllers/jobs_controller.dart';
import '../models/job_model.dart';
import '../routes/app_routes.dart';
import '../widgets/job_card.dart';

class JobSearch extends StatelessWidget {
  final JobsController controller = Get.put(JobsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Search'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search for jobs",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Get.theme.primaryColor,
                        width: 2, // Border thickness
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.filter_list,
                        color: Get.theme.primaryColor,
                        size: 20,
                        // color: Colors.black,
                      ),
                     onPressed: () {
                        Get.bottomSheet(
                            Container(
                              height: Get.height * 0.7,
                                child: FilterBottomSheet()),
                          isScrollControlled: true,
                          isDismissible: true
                        );
                     },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Advanced search', style: TextStyle(
                color: Get.theme.primaryColor, fontSize: 16, fontWeight: FontWeight.w500
              ),),
            ),
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(onPressed: () {
                      Get.bottomSheet(Container(
                        height: Get.height * 0.5,
                          child: SaveSearchBottomsheet()),
                        isScrollControlled: true,
                      );
                    }, child: Row(
                      children: [
                        Icon(Icons.folder_outlined, color: Get.theme.primaryColor, size: 22,),
                        SizedBox(width: 5,),
                        Text('Save search', style: TextStyle(
                          color: Get.theme.primaryColor, fontSize: 16
                        ),),
                      ],
                    ),),
                  ),
                  Expanded(
                    child: TextButton(onPressed: () {
                      Get.toNamed(AppRoutes.savedJob);
                    }, child: Row(
                      children: [
                        Icon(Icons.favorite_border, color: Get.theme.primaryColor, size: 22,),
                        SizedBox(width: 5,),
                        Text('Saved jobs', style: TextStyle(
                            color: Get.theme.primaryColor, fontSize: 16
                        ),),
                        Obx(() {
                            return controller.favoriteJobs.isNotEmpty ? Text(' (${controller.favoriteJobs.length})', style: TextStyle(
                                color: Get.theme.primaryColor
                            ),): SizedBox();
                          }
                        ),
                      ],
                    ),),
                  ),
                ],
              ),
            ),

            Obx(() {
              if (controller.isLoading.value) {
                // Display shimmer placeholders for job cards
                return Column(
                  children: List.generate(2, (index) {
                    return JobCard(
                      job: Job(
                        title: '',
                        // Placeholder empty data
                        description: '',
                        postedTimeAgo: '',
                        location: '',
                        budget: 0,
                        paymentVerified: '',
                        rating: 0.0,
                        tags: [],
                        hourlyRateMin: '',
                        hourlyRateMax: '',
                        jobType: '',
                        estimatedTime: '',
                        hoursPerWeek: '',
                        isFixedPrice: true,
                      ),
                    );
                  }),
                );
              }

              return Column(
                children: controller.jobs.map((job) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.jobDetails, arguments: job);
                    },
                    child: JobCard(job: job),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/homescreen_controller.dart';
import '../controllers/drawer_controller.dart';
import '../controllers/jobs_controller.dart';
import '../controllers/theme_controller.dart';
import '../models/job_model.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/job_card.dart';

class JobsPage extends StatelessWidget {
  final JobsController controller = Get.put(JobsController());
  final Drawercontroller drawerController = Get.put(Drawercontroller());
  final ThemeController themeController = Get.find<ThemeController>();
  final HomeScreenController homecontroller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Jobs',
      ),

      body: Obx(() =>
      controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
           : RefreshIndicator(
        onRefresh: () async {
          await controller.fetchJobs(isRefresh: true); // Refresh data
        },
             child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Row(
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
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 12),
                                      ),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Obx(() {
                                  bool isAnyJobFavorite =
                                      controller.favoriteJobs.isNotEmpty;
                                  return Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: theme.dividerColor,
                                        width: 1, // Border thickness
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        isAnyJobFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: theme.iconTheme.color,
                                        size: 20,
                                        // color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Get.bottomSheet(
                                          backgroundColor:
                                              theme.scaffoldBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          isScrollControlled: true,
                                          elevation: 10,
                                          Obx(() {
                                            return Container(
                                              height:
                                                  MediaQuery.of(context).size.height *
                                                      0.8,
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      // Align(
                                                      //   alignment: Alignment.topCenter,
                                                      //   child: Container(
                                                      //     width: 30,
                                                      //     height: 4,
                                                      //     decoration: BoxDecoration(
                                                      //       color: theme.dividerColor,
                                                      //       borderRadius:
                                                      //           BorderRadius.circular(
                                                      //               10),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 10,
                                                      // ),
                                                      Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                Alignment.topLeft,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                Get.back(); // Close bottom sheet
                                                              },
                                                              icon: Icon(Icons.close,
                                                                  size: 20),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                Alignment.topCenter,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 10.0),
                                                              child: Text(
                                                                'Saved jobs',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      controller.favoriteJobs.isEmpty
                                                          ? Obx(() {
                                                              return Card(
                                                                //color: Colors.white,
                                                                color: theme
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
                                                ),
                                              ),
                                            );
                                          }),
                                          enableDrag: true,

                                          // ListView.builder(
                                          //   itemCount: controller.favoriteJobs.length,
                                          //   itemBuilder: (context, index) {
                                          //     Job job = controller.favoriteJobs[index];
                                          //     return ListTile(
                                          //       title: Text(job.title),
                                          //       subtitle: Text(job.location),
                                          //     );
                                          //   },
                                          // ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Be the 1st to apply with instant job alerts",
                          style: theme.textTheme.bodyMedium,
                          //style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Button action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            // backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Get for 10 Connects",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  DefaultTabController(
                    length: 3,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: TabBar(
                            isScrollable: true,
                            labelPadding: EdgeInsets.symmetric(horizontal: 16),
                            tabAlignment: TabAlignment.start,
                            labelColor: theme.primaryColor,
                            unselectedLabelColor: theme.unselectedWidgetColor,
                            indicatorColor: theme.primaryColor,
                            tabs: const [
                              Tab(text: "My Feed"),
                              Tab(text: "Best Matches"),
                              Tab(text: "Most Recent"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Job List
                  Obx(() {
                    // if (controller.jobs.isEmpty) {
                    //   return const Center(child: Text("No jobs available"));
                    // }
                    if (controller.isLoading.value) {
                      // Display shimmer placeholders for job cards
                      return Column(
                        children: List.generate(2, (index) {
                          return JobCard(
                            job: Job(
                              title: '',
                              // Placeholder empty data
                              jobDescription: '',
                              location: '',
                              budget: 0,
                              isPaymentVerified: true,
                              rating: 0.0,
                              tags: [],
                              hourlyRateMin: 0.0,
                              hourlyRateMax: 0.0,
                              estimatedTime: '',
                              hoursPerWeek: 0,
                              isFixedPrice: true, id: '', userId: '', proposals: '',
                              createdAt: DateTime(2025), updatedAt: DateTime(2025),
                              deletedAt: DateTime(2025), isDeleted: false,
                            ),
                          );
                        }),
                      );
                    }

                    if (controller.jobs.isEmpty) {
                      return Center(child: Text("No jobs available"));
                    }

                    // if (controller.isLoading.value) {
                    //   return Column(
                    //     children: List.generate(5, (index) { // Simulate 5 shimmer cards
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //         child: CustomShimmer(
                    //           width: MediaQuery.of(context).size.width * 0.9,
                    //           height: 120, // Adjust height to match JobCard
                    //         ),
                    //       );
                    //     }),
                    //   );
                    // }
                    return Column(
                      children: controller.jobs.map((job) {
                       // print("Jobs List Length: ${controller.jobs.length}");
                        for (var job in controller.jobs) {
                          //print("Job: ${job.title}, Budget: ${job.budget}");
                        }
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
           ),

      ),
    );
  }
}

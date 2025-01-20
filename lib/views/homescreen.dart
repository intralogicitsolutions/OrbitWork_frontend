import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/drawer_controller.dart';
import '../controllers/jobs_controller.dart';
import '../controllers/theme_controller.dart';
import '../models/job_model.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/job_card.dart';

class HomeScreen extends StatelessWidget {
  final JobsController controller = Get.put(JobsController());
  final Drawercontroller drawerController = Get.put(Drawercontroller());
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
     // backgroundColor: Colors.white,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.dialog(
                  GestureDetector(
                    onTap: () {
                      drawerController.closeDrawer();
                      Future.delayed(
                          const Duration(milliseconds: 300), () => Get.back());
                    },
                    child: Stack(
                      children: [
                        Container(color: Colors.black.withOpacity(0.5)),
                        // Dim background
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            // Drawer width as 80% of the screen
                            child: SlideTransition(
                              position: drawerController.slideAnimation,
                              child: const CustomDrawer(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  barrierDismissible: false, // Prevent automatic dismissal
                  barrierColor: Colors.transparent,
                );
                drawerController.openDrawer();
              },
              child: CircleAvatar(
                radius: 24,
                // backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                child: const Icon(Icons.account_circle, size: 48),
              ),
            ),
            const SizedBox(width: 16),
            Text("Jobs",
              style: theme.textTheme.bodyLarge,
             //   style: TextStyle(fontSize: 20)
            ),
          ],
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        //backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search for jobs",
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {

                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(() {
                            bool isAnyJobFavorite =
                                controller.favoriteJobs.isNotEmpty;
                            return Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.dividerColor,
                                 // color: Colors.black, // Border color around the circle
                                  width: 1, // Border thickness
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  isAnyJobFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: theme.iconTheme.color,
                                 // color: Colors.black,
                                ),
                                onPressed: () {
                                  // Optionally open a bottom sheet or perform other actions
                                  Get.bottomSheet(
                                   // backgroundColor: Colors.white,
                                    backgroundColor:  theme.scaffoldBackgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    elevation: 10,
                                    Container(
                                      height: MediaQuery.of(context).size.height*0.8,
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  width: 30,
                                                  height: 4,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    theme.dividerColor,
                                                    //color: Colors.grey.shade400,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              controller.favoriteJobs.isEmpty?
                                                  Card(
                                                    //color: Colors.white,
                                                    color: theme.scaffoldBackgroundColor,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(20.0),
                                                          child: Center(
                                                            child: Image.asset(
                                                              'assets/icon/touch.png',
                                                              height: 60,
                                                              width: 60,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(20.0),
                                                          child: Text("Keep track of jobs you're interested in. Select the heart icon on the job post to save it for later.",
                                                           textAlign: TextAlign.center,
                                                            // style: TextStyle(
                                                            //   fontSize: 16,
                                                            //   fontWeight: FontWeight.w400,
                                                            //   color: Colors.grey.shade600
                                                            // ),
                                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                                                            //style: theme.textTheme.bodyMedium,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ):
                                              Column(
                                                children:
                                                controller.favoriteJobs.map((job) => JobCard(job: job)).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
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
                children: [
                  TabBar(
                    labelColor: theme.primaryColor,
                    unselectedLabelColor: theme.unselectedWidgetColor,
                    indicatorColor: theme.primaryColor,
                    // labelColor: Colors.green,
                    // unselectedLabelColor: Colors.grey,
                    // indicatorColor: Colors.green,
                    tabs: const [
                      Tab(text: "My Feed"),
                      Tab(text: "Best Matches"),
                      Tab(text: "Most Recent"),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Job List
            Obx(() {
              if (controller.jobs.isEmpty) {
                return const Center(child: Text("No jobs available"));
              }
              return Column(
                children:
                    controller.jobs.map((job) => JobCard(job: job)).toList(),
              );
            }),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            //color: Colors.grey.shade400,
            color: Theme.of(context).dividerColor,
          ),
          BottomNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Dynamic background
            selectedItemColor: Theme.of(context).primaryColor, // Dynamic selected icon color
            unselectedItemColor: Theme.of(context).iconTheme.color, // Dynamic unselected icon color
            //backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.work,
                  color: Colors.green,
                ),
                label: "Jobs",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description),
                label: "Proposals",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "Profile",
              ),
            ],
            onTap: (index) {
              // Handle navigation here
            },
          ),
        ],
      ),
    );
  }
}

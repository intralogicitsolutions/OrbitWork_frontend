import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/drawer_controller.dart';
import '../controllers/jobs_controller.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/job_card.dart';

class HomeScreen extends StatelessWidget {
  final JobsController controller = Get.put(JobsController());
  final Drawercontroller drawerController = Get.put(Drawercontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Open Custom Drawer
                // Get.bottomSheet(
                //   const CustomDrawer(), // Show custom drawer
                //   isScrollControlled: true,
                //   backgroundColor: Colors.transparent,
                //   shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                //   ),
                // );
                Get.dialog(
                  GestureDetector(
                    onTap: () {
                      drawerController.closeDrawer();
                      Future.delayed(
                          const Duration(milliseconds: 300), () => Get.back());
                    },
                    child: Stack(
                      children: [
                        Container(color: Colors.black.withOpacity(0.5)), // Dim background
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: 0.8, // Drawer width as 80% of the screen
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
                backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                child: const Icon(Icons.account_circle, size: 48),
              ),
            ),
            const SizedBox(width: 16),
            const Text("Jobs", style: TextStyle(fontSize: 20)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Align(
            //     alignment: Alignment.centerLeft,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //       child: const Text("Jobs", style: TextStyle(fontSize: 20)),
            //     )),
            //const SizedBox(height: 10),
            // Sliding Tabs (My Feed, Best Matches, Most Recent)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search for jobs",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      // Optionally implement search functionality here
                    },
                  ),
                  const SizedBox(height: 16),
                  // "Be the 1st to Apply" Text
                  Text(
                    "Be the 1st to apply with instant job alerts",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),

                  ElevatedButton(
                    onPressed: () {
                      // Button action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.green,
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
                children: controller.jobs.map((job) => JobCard(job: job)).toList(),
              );
              // return ListView.builder(
              //   padding: EdgeInsets.zero,
              //   itemCount: controller.jobs.length,
              //   itemBuilder: (context, index) {
              //     return JobCard(job: controller.jobs[index]);
              //   },
              // );
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
            color: Colors.grey.shade400, // Adjust color as needed
          ),
          BottomNavigationBar(
            backgroundColor: Colors.white,
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

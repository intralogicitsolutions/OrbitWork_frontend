import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orbitwork/widgets/custom_appbar.dart';

import '../client_profile_controller/dashboard_controller.dart';
import '../client_profile_model/dashboard_model.dart';
import '../component/client_profile/post_job_bottomsheet.dart';
import '../controllers/drawer_controller.dart';

class DashboardPage extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    Get.put(Drawercontroller());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Your dashboard',
        rightIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert)
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              color: Colors.white,
              child: Text(
                'Last steps before you can hire',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),

            // Content Section
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Dashboard Items
                  ...controller.dashboardItem.asMap().entries.map((entry) {
                    int index = entry.key;
                    DashboardItem item = entry.value;
                    return _buildDashboardCard(item, index);
                  }).toList(),

                ],
              ),
            ),

            Divider(),

            Center(
              child: Column(
                children: [

                  SvgPicture.asset(
                    'assets/icon/briefcase.svg',
                    height: 80,
                    width: 80,
                   // color: Colors.green, // Optional
                  ),

                  SizedBox(height: 32),

                  Text(
                    'No job posts or contracts in\nprogress right now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),

                  SizedBox(height: 32),

                  // Post a job button
                  Container(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: controller.postJob,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        side: BorderSide(color: Colors.green, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.green, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Post a job',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(),

            SizedBox(height: 60),

            // Navigation Links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.viewJobPosts();
                  },
                  child: Text(
                    'View all job posts',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: 1,
                  height: 16,
                  color: Colors.grey[400],
                ),
                GestureDetector(
                  onTap:() {
                    controller.viewContracts();
                  },
                  child: Text(
                    'View all contracts',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 80),

            // Consultation Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find experts by category and\nbook consultations',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),

                  SizedBox(height: 24),

                  GestureDetector(
                    onTap: controller.browseConsultations,
                    child: Row(
                      children: [
                        Text(
                          'Browse consultations',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.green,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30,),

            // Guided Tour Card
            Obx(() => controller.isLoading.value
                ? Center(child: CircularProgressIndicator()) :
            controller.showGuidedTour.value
                ? Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xFF2F5D62), // Dark teal color
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Guided tour',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.closeGuidedTour,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Book a consultation with an expert to review your project\'s budget, timeline, and scope one-on-one.',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),

                  SizedBox(height: 32),

                  Row(
                    children: [
                      // Learn More Button
                      Container(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: controller.learnMore,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(horizontal: 24),
                          ),
                          child: Text(
                            'Learn more',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      Spacer(),

                      // Computer Illustration
                      SvgPicture.asset(
                        'assets/icon/illustration.svg',
                        height: 80,
                        width: 80,
                        // color: Colors.green, // Optional
                      ),
                    ],
                  ),
                ],
              ),
            )
                : SizedBox.shrink()),

            SizedBox(height: 40),

            // ...controller.categoryItems.map((category) => Padding(
            //   padding: EdgeInsets.only(bottom: 20),
            //   child: _buildCategoryCard(category, controller),
            // )).toList(),

            // Category Slider
            _buildCategorySlider(controller),
            SizedBox(height: 20),

            // Help and Resources Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Help and resources',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.viewAllHelp,
                    child: Row(
                      children: [
                        Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.green,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            _buildGetStartedCard(controller),
            SizedBox(height: 20),

            // Payments Cards
            ...controller.dashboardItems
                .where((item) => item.category == "Payments")
                .map((item) => Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _buildPaymentCard(item),
            ))
                .toList(),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            PostJobBottomsheet(),
            isScrollControlled: true,
            ignoreSafeArea: false,
          );
        },
        mini: true,
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }


  Widget _buildDashboardCard(DashboardItem item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.requirement,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () => controller.completeItem(index),
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              item.icon,
              color:  Colors.grey[600],
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetStartedCard(DashboardController controller) {
    if (controller.dashboardItems.isEmpty) {
      return const SizedBox(); // Or show placeholder/empty message
    }
    final item = controller.dashboardItems.firstWhere(
          (item) => item.category == "Get started",
      orElse: () => controller.dashboardItems.first,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.subtitle,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: controller.onLearnMoreTap,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.green),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        item.buttonText ?? "Learn more",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              // Rocket Icon Illustration
              SvgPicture.asset(
                'assets/icon/connect-talent.svg',
                height: 80,
                width: 80,
                // color: Colors.green, // Optional
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(item) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          // Payment Cards Illustration
        // _buildPaymentIcon(item.title.contains("billing")),
          SvgPicture.asset(
            item.iconPath,
            height: 60,
            width: 60,
            // color: Colors.green, // Optional
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySlider(DashboardController controller) {
    return Container(
      height: 180,
      child: Obx(() => PageView.builder(
        onPageChanged: controller.onCategorySelect,
        itemCount: controller.categoryItems.length,
        itemBuilder: (context, index) {
          final category = controller.categoryItems[index];
          final isSelected = controller.selectedCategoryIndex.value == index;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: _buildCategoryCard(category, controller, isSelected: isSelected),
          );
        },
      )),
    );
  }

  Widget _buildCategoryCard(CategoryItem category, DashboardController controller, {bool isSmall = false, bool isSelected = false}) {
    return GestureDetector(
      onTap: () => controller.onCategoryTap(category.title),
      child: Container(
        width: double.infinity,
        height: isSmall ? 180 : 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: Colors.green, width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Category Icon Illustration
            // Container(
            //   width: isSmall ? 80 : 120,
            //   height: isSmall ? 60 : 100,
            //   child: _buildCategoryIcon(category.imagePath, isSmall),
            // ),
             SvgPicture.asset(
                    category.imagePath,
                    height: 60,
                    width: 60,
                    // color: Colors.green, // Optional
                  ),
            SizedBox(height: isSmall ? 12 : 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                category.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isSmall ? 16 : 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

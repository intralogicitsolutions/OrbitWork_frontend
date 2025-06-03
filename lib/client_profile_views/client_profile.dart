import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_controller/client_profile_controller.dart';

class ClientProfilePage extends StatelessWidget {
  final ClientProfileController controller = Get.put(ClientProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile Image and Status
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        // backgroundImage: NetworkImage(
                        //   'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
                        // ),
                      ),
                      // Online status indicator
                      Positioned(
                        bottom: 5,
                        left: 5,
                        child: Obx(() => Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: controller.isOnline.value ? Colors.green : Colors.grey,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        )),
                      ),
                      // Favorite button
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Obx(() => GestureDetector(
                          onTap: controller.toggleFavorite,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: controller.isFavorite.value ? Colors.green : Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: controller.isFavorite.value ? Colors.green : Colors.grey[400],
                              size: 20,
                            ),
                          ),
                        )),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  // Available now indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.electric_bolt_outlined, color: Colors.blue, size: 20),
                      SizedBox(width: 5),
                      Text(
                        'Available now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  // Name and verification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Rahul B.',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.verified, color: Colors.blue, size: 20),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Description
                  Text(
                    'Top 1 percent Google ads, Fb Ads, Paid Ads, PPC Expert',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('95%', '', Icons.thumb_up, Colors.blue),
                      _buildStatItem('Top Rated Plus', '', Icons.star, Colors.pink),
                      _buildStatItem('4.7 (480)', '', Icons.star, Colors.amber),
                    ],
                  ),

                  SizedBox(height: 15),

                  // Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.grey[600], size: 18),
                      SizedBox(width: 5),
                      Text(
                        'Ballabgarh, India - 5:36 pm local time',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Stats Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLargeStatItem('\$900K+', 'Total earnings'),
                  _buildLargeStatItem('891', 'Total jobs'),
                  _buildLargeStatItem('72,651', 'Total hours'),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Action Buttons
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.more_horiz, color: Colors.green),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Hire',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          //  SizedBox(height: 20),

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16.0),
             child: Container(
               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
               decoration: BoxDecoration(
                 shape: BoxShape.rectangle,
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(color: Colors.grey.shade300, width: 2)
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Icon(Icons.perm_contact_calendar_outlined, color: Get.theme.primaryColor,),
                   Text('Book a consultation', style: TextStyle(
                     color: Get.theme.primaryColor
                   ),),
                 ],
               ),
             ),
           ),
            SizedBox(height: 10,),
            Text('\$10 per 30 mon Zoom meeting', style: TextStyle(
              fontSize: 12,
            ),),

            SizedBox(height: 20),

            // Tab Section
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Tab Bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        _buildTab('About', 0),
                        SizedBox(width: 30),
                        _buildTab('Client feedback', 1),
                        SizedBox(width: 30),
                        _buildTab('Work history', 2),
                      ],
                    ),
                  ),

                  // Tab Content
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Rahul B.',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),

                        // About Details
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoItem('\$15.00/hr', 'Rate'),
                            ),
                            Expanded(
                              child: _buildInfoItem('English', 'Language'),
                            ),
                            Expanded(
                              child: _buildInfoItem('Softtrix T...', 'Agency'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 12),
            ),
            SizedBox(width: 5),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        if (label.isNotEmpty) ...[
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLargeStatItem(String value, String label) {
    return Container(
      height: 90,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1
              ),
            ),
           SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return Obx(() => GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: controller.selectedTab.value == index
                  ? Colors.black
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: controller.selectedTab.value == index
                ? FontWeight.w600
                : FontWeight.normal,
            color: controller.selectedTab.value == index
                ? Colors.black
                : Colors.grey[600],
          ),
        ),
      ),
    ));
  }

  Widget _buildInfoItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: value.contains('Softtrix') ? Colors.green : Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_controller/portfolio_controller.dart';
import 'package:orbitwork/client_profile_controller/work_history_controller.dart';
import 'package:orbitwork/component/client_profile/client_feedback_bottomsheet.dart';
import 'package:orbitwork/component/client_profile/select_profile_bottomsheet.dart';
import 'package:video_player/video_player.dart';

import '../client_profile_controller/client_profile_controller.dart';
import '../component/client_profile/work_experience_bottomsheet.dart';
import '../routes/app_routes.dart';

class ClientProfilePage extends StatelessWidget {
  final ClientProfileController controller = Get.put(ClientProfileController());
  final WorkHistoryController workHistoryController = Get.put(WorkHistoryController());
  final PortfolioController portfolioController = Get.put(PortfolioController());

  //@override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       leading: IconButton(
  //         icon: Icon(Icons.arrow_back, color: Colors.black),
  //         onPressed: () => Get.back(),
  //       ),
  //       title: Text(
  //         'Profile',
  //         style: TextStyle(
  //           color: Colors.black,
  //           fontSize: 20,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.more_vert, color: Colors.black),
  //           onPressed: () {},
  //         ),
  //       ],
  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Container(
  //             padding: EdgeInsets.all(20),
  //             child: Column(
  //               children: [
  //                 // Profile Image and Status
  //                 Stack(
  //                   children: [
  //                     CircleAvatar(
  //                       radius: 50,
  //                       backgroundColor: Colors.grey[300],
  //                       // backgroundImage: NetworkImage(
  //                       //   'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
  //                       // ),
  //                     ),
  //                     // Online status indicator
  //                     Positioned(
  //                       bottom: 5,
  //                       left: 5,
  //                       child: Obx(() => Container(
  //                         width: 18,
  //                         height: 18,
  //                         decoration: BoxDecoration(
  //                           color: controller.isOnline.value ? Colors.green : Colors.grey,
  //                           shape: BoxShape.circle,
  //                           border: Border.all(color: Colors.white, width: 2),
  //                         ),
  //                       )),
  //                     ),
  //                     // Favorite button
  //                     Positioned(
  //                       top: 0,
  //                       right: 0,
  //                       child: Obx(() => GestureDetector(
  //                         onTap: controller.toggleFavorite,
  //                         child: Container(
  //                           padding: EdgeInsets.all(8),
  //                           decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             shape: BoxShape.circle,
  //                             border: Border.all(
  //                               color: controller.isFavorite.value ? Colors.green : Colors.grey[300]!,
  //                               width: 2,
  //                             ),
  //                           ),
  //                           child: Icon(
  //                             Icons.favorite,
  //                             color: controller.isFavorite.value ? Colors.green : Colors.grey[400],
  //                             size: 20,
  //                           ),
  //                         ),
  //                       )),
  //                     ),
  //                   ],
  //                 ),
  //
  //                 SizedBox(height: 15),
  //
  //                 // Available now indicator
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(Icons.electric_bolt_outlined, color: Colors.blue, size: 20),
  //                     SizedBox(width: 5),
  //                     Text(
  //                       'Available now',
  //                       style: TextStyle(
  //                         color: Colors.blue,
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //
  //                 SizedBox(height: 15),
  //
  //                 // Name and verification
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'Rahul B.',
  //                       style: TextStyle(
  //                         fontSize: 28,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                     SizedBox(width: 8),
  //                     Icon(Icons.verified, color: Colors.blue, size: 20),
  //                   ],
  //                 ),
  //
  //                 SizedBox(height: 10),
  //
  //                 // Description
  //                 Text(
  //                   'Top 1 percent Google ads, Fb Ads, Paid Ads, PPC Expert',
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: Colors.grey[600],
  //                     height: 1.4,
  //                   ),
  //                 ),
  //
  //                 SizedBox(height: 20),
  //
  //                 // Stats Row
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     _buildStatItem('95%', '', Icons.thumb_up, Colors.blue),
  //                     _buildStatItem('Top Rated Plus', '', Icons.star, Colors.pink),
  //                     _buildStatItem('4.7 (480)', '', Icons.star, Colors.amber),
  //                   ],
  //                 ),
  //
  //                 SizedBox(height: 15),
  //
  //                 // Location
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(Icons.location_on, color: Colors.grey[600], size: 18),
  //                     SizedBox(width: 5),
  //                     Text(
  //                       'Ballabgarh, India - 5:36 pm local time',
  //                       style: TextStyle(
  //                         color: Colors.grey[600],
  //                         fontSize: 14,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //           SizedBox(height: 20),
  //
  //           // Stats Section
  //           Container(
  //             color: Colors.white,
  //             padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 _buildLargeStatItem('\$900K+', 'Total earnings'),
  //                 _buildLargeStatItem('891', 'Total jobs'),
  //                 _buildLargeStatItem('72,651', 'Total hours'),
  //               ],
  //             ),
  //           ),
  //
  //           SizedBox(height: 20),
  //
  //           // Action Buttons
  //           Container(
  //             color: Colors.white,
  //             padding: EdgeInsets.all(20),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   width: 50,
  //                   height: 50,
  //                   decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.green, width: 2),
  //                     shape: BoxShape.circle,
  //                   ),
  //                   child: Icon(Icons.more_horiz, color: Colors.green),
  //                 ),
  //                 SizedBox(width: 15),
  //                 Expanded(
  //                   child: ElevatedButton(
  //                     onPressed: () {},
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.green,
  //                       padding: EdgeInsets.symmetric(vertical: 4),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       elevation: 0,
  //                     ),
  //                     child: Text(
  //                       'Hire',
  //                       style: TextStyle(
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.w600,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //         //  SizedBox(height: 20),
  //
  //          Padding(
  //            padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //            child: Container(
  //              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //              decoration: BoxDecoration(
  //                shape: BoxShape.rectangle,
  //                borderRadius: BorderRadius.circular(12),
  //                border: Border.all(color: Colors.grey.shade300, width: 2)
  //              ),
  //              child: Row(
  //                mainAxisAlignment: MainAxisAlignment.center,
  //                children: [
  //                  Icon(Icons.perm_contact_calendar_outlined, color: Get.theme.primaryColor,),
  //                  Text('Book a consultation', style: TextStyle(
  //                    color: Get.theme.primaryColor
  //                  ),),
  //                ],
  //              ),
  //            ),
  //          ),
  //           SizedBox(height: 10,),
  //           Text('\$10 per 30 mon Zoom meeting', style: TextStyle(
  //             fontSize: 12,
  //           ),),
  //
  //           SizedBox(height: 20),
  //
  //           // Tab Section
  //           Container(
  //             padding: EdgeInsets.symmetric(horizontal: 20),
  //             child: Obx(() => SingleChildScrollView(
  //               scrollDirection: Axis.horizontal,
  //               child: Row(
  //                 children: List.generate(_tabs.length, (index) {
  //                   return GestureDetector(
  //                     onTap: () => controller.scrollToSection(index),
  //                     child: Container(
  //                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //                       decoration: BoxDecoration(
  //                         border: Border(
  //                           bottom: BorderSide(
  //                             color: controller.selectedTab.value == index
  //                                 ? Colors.blue
  //                                 : Colors.transparent,
  //                             width: 2,
  //                           ),
  //                         ),
  //                       ),
  //                       child: Text(
  //                         _tabs[index],
  //                         style: TextStyle(
  //                           color: controller.selectedTab.value == index
  //                               ? Colors.blue
  //                               : Colors.grey,
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }),
  //               ),
  //             )),
  //
  //             // Obx(() {
  //             //     return SingleChildScrollView(
  //             //       scrollDirection: Axis.horizontal,
  //             //       child: Row(
  //             //         children: [
  //             //           _buildTab('About', 0),
  //             //           SizedBox(width: 30),
  //             //           _buildTab('Client feedback', 1),
  //             //           SizedBox(width: 30),
  //             //           _buildTab('Work history', 2),
  //             //           SizedBox(width: 30),
  //             //           _buildTab('Portfolio', 3),
  //             //           SizedBox(width: 30),
  //             //           _buildTab('Employment history', 4),
  //             //           SizedBox(width: 30),
  //             //           _buildTab('Skills', 5),
  //             //           SizedBox(width: 30),
  //             //           _buildTab('Certification', 6),
  //             //           SizedBox(width: 30),
  //             //           _buildTab('Education', 7),
  //             //         ],
  //             //       ),
  //             //     );
  //             //   }
  //             // ),
  //           ),
  //
  //           SizedBox(
  //             height: 1000,
  //             child: SingleChildScrollView(
  //               controller: controller.scrollController,
  //               child: Column(
  //                 children: [
  //                   _buildPlaceholderSection('About Section', controller.sectionKeys[0]),
  //                   Divider(),
  //                   _buildPlaceholderSection('Client Feedback', controller.sectionKeys[1]),
  //                   Divider(),
  //                   _buildPlaceholderSection('Work History', controller.sectionKeys[2]),
  //                   Divider(),
  //                   _buildPlaceholderSection('Portfolio', controller.sectionKeys[3]),
  //                   Divider(),
  //                   _buildPlaceholderSection('Employment History', controller.sectionKeys[4]),
  //                   Divider(),
  //                   _buildPlaceholderSection('Skills', controller.sectionKeys[5]),
  //                   Divider(),
  //                   _buildPlaceholderSection('Certifications', controller.sectionKeys[6]),
  //                   Divider(),
  //                   _buildPlaceholderSection('Education', controller.sectionKeys[7]),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           // SizedBox(height: 16,),
  //           // _buildAboutSection(),
  //           // Divider(),
  //           // _buildClientFeedbackSection(),
  //           // Divider(),
  //           // _buildWorkHistorySection(),
  //           // Divider(),
  //           // _buildEmploymentHistorySection(),
  //           // Divider(),
  //           // _buildCertificationsSection(),
  //           // Divider(),
  //           // _buildEducationSection(),
  //         ],
  //       ),
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SafeArea(
        child: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Container(
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
                          child: Icon(Icons.person, size: 50, color: Colors.grey[600]),
                        ),
                        // Online status indicator
                        Positioned(
                          top: 5,
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
                                  color:  Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              child: Icon( controller.isFavorite.value
                                  ? Icons.favorite_border
                                  :
                              Icons.favorite_border,
                                color: Colors.grey[400],
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
                          'Rahul K.',
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
            ),

            // Stats Section
            SliverToBoxAdapter(
              child: Container(
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
            ),

            // Action Buttons
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(onPressed: () {
                            Get.bottomSheet(
                             ClipRRect(
                               borderRadius: BorderRadius.only(
                                 topRight: Radius.circular(20),
                                 topLeft: Radius.circular(20)
                               ),
                               child: Container(
                                 height: Get.height * 0.3,
                                   child: SelectProfileBottomsheet()),
                             ),
                            );
                          }, icon: Icon(Icons.more_horiz, color: Colors.green)),
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
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.consultationPage);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.perm_contact_calendar_outlined, color: Get.theme.primaryColor),
                            SizedBox(width: 8),
                            Text(
                              'Book a consultation',
                              style: TextStyle(color: Get.theme.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\$10 per 30 min Zoom meeting',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            // Fixed Tab Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 60,
                maxHeight: 60,
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: List.generate(
                        controller.tabTitles.length,
                            (index) => Padding(
                          padding: EdgeInsets.only(right: index == controller.tabTitles.length - 1 ? 0 : 30),
                          child: _buildTab(controller.tabTitles[index], index),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Content Sections
            SliverList(
              delegate: SliverChildListDelegate([
                _buildAboutSection(),
                Divider(height: 1),
                _buildClientFeedbackSection(),
                Divider(height: 1),
                _buildWorkHistorySection(),
                Divider(height: 1),
                _buildPortfolioSection(),
                Divider(height: 1),
                _buildEmploymentHistorySection(),
                Divider(height: 1),
                _buildSkillsSection(),
                Divider(height: 1),
                _buildSkillSection(),
                Divider(height: 1),
                _buildCertificationsSection(),
                Divider(height: 1),
                _buildEducationSection(),
                SizedBox(height: 50), // Bottom spacing
              ]),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildPlaceholderSection(String title, Key key) {
  //   return Container(
  //     key: key,
  //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  //         SizedBox(height: 10),
  //         Text(
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
      //onTap: () => controller.changeTab(index),
      onTap: () => controller.scrollToSection(index),
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

  Widget _buildAboutSection(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
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
          SizedBox(height: 16,),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: Obx(() {
              if (controller.isVideoInitialized.value) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: controller.videoPlayerController!.value.size.width,
                            height: controller.videoPlayerController!.value.size.height,
                            child: VideoPlayer(controller.videoPlayerController!),
                          ),
                        ),
                      ),
                      // Play/Pause Overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                            ),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: controller.toggleVideoPlayback,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  controller.isPlaying.value
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                  ),
                  child: Center(
                    // child: CircularProgressIndicator(
                    //   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    // ),
                    child: Icon(Icons.stop_circle_rounded),
                  ),
                );
              }
            }),
          ),

          SizedBox(height: 20),

          // Achievement Badges
          Column(
            children: [
              _buildAchievementRow(
                icon: '🏆',
                text: 'Top-Rated Plus+ Freelancer',
              ),
              SizedBox(height: 8),
              _buildAchievementRow(
                icon: '🏅',
                text: '6+ years of experience',
              ),
            ],
          ),

          SizedBox(height: 20),

          // Description
          Text(
            'I\'m a Senior UI/UX and Web Designer creating user-centered designs for brands like "PaySafe", "Michael\'s", and "Mayo Clinic". I\'m proficient in Interaction Design, Visual Design, and Creative Direction by using',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          //Text('Looking for real SEO results and not just rankings?')
        ],
      ),
    );
  }

  Widget _buildAchievementRow({required String icon, required String text}) {
    return Row(
      children: [
        Text(
          icon,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Widget _buildClientFeedbackSection(){
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('Client feedback (117)', style: TextStyle(
  //             fontSize: 20, fontWeight: FontWeight.w500
  //         ),),
  //         SizedBox(height: 24,),
  //         Container(
  //           padding: EdgeInsets.all(16),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(width: 1, color: Colors.grey.shade300)
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //             Text('Local SEO citations consultant'),
  //             SizedBox(height: 16,),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Icon(Icons.calendar_month_outlined, size: 12,),
  //                     SizedBox(width: 12,),
  //                     Text('March 18,2025', style: TextStyle(fontSize: 12, color: Colors.grey),),
  //                   ],
  //                 ),
  //                 Row(
  //                   children: [
  //                     Icon(Icons.star, color: Colors.amber, size: 12,),
  //                     Icon(Icons.star, color: Colors.amber, size: 12,),
  //                     Icon(Icons.star, color: Colors.amber, size: 12,),
  //                     Icon(Icons.star, color: Colors.amber, size: 12,),
  //                     Icon(Icons.star, color: Colors.amber, size: 12,),
  //                     SizedBox(width: 8.0,),
  //                     Text(' 5.0'),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 20,),
  //             Text('"It Was a good experience overall, however our corrections and feedback about our company name were not implemented. It\'d be important to agree on a system to revisit citations / ..."'),
  //             GestureDetector(
  //               onTap: () {
  //                 Get.bottomSheet(
  //                   Container(
  //                       height: Get.height * 0.7,
  //                       child: ClientFeedbackBottomsheet()),
  //                   isScrollControlled: true,
  //                   ignoreSafeArea: false
  //                 );
  //               },
  //               child: Text('View more',style: TextStyle(
  //                 color: Get.theme.primaryColor
  //               ),),
  //             ),
  //             SizedBox(height: 18,),
  //             Row(
  //               children: [
  //                 Icon(Icons.account_circle_outlined),
  //                 SizedBox(width: 8.0,),
  //                 Text('Remote Roofing A.'),
  //               ],
  //             )
  //           ],),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildClientFeedbackSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client feedback (117)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 24),

          // Horizontal scroll of feedback cards
          SizedBox(
            height: 240, // Adjust based on content height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.feedbackList.length, // ← From GetX controller
              itemBuilder: (context, index) {
                final feedback = controller.feedbackList[index];
                final double rating = feedback.rating.toDouble();
                return Container(
                  width: 300, // Fixed width for horizontal card
                  margin: EdgeInsets.only(right: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(feedback.title), // e.g. "Local SEO citations consultant"
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_month_outlined, size: 12),
                              SizedBox(width: 12),
                              Text(
                                feedback.date, // e.g. "March 18, 2025"
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [

                              Row(
                                children: List.generate(5, (i) {
                                  if (i < rating.floor()) {
                                    // Full star
                                    return Icon(Icons.star, color: Colors.amber, size: 12);
                                  } else if (i < rating && rating - i >= 0.5) {
                                    // Half star
                                    return Icon(Icons.star_half, color: Colors.amber, size: 12);
                                  } else {
                                    // Empty star
                                    return Icon(Icons.star_border, color: Colors.grey[300], size: 12);
                                  }
                                }),
                              ),
                              SizedBox(width: 8,),
                              Text('${feedback.rating}')
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        '"${feedback.comment}"',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            SizedBox(
                              height: Get.height * 0.7,
                              child: ClientFeedbackBottomsheet(),
                            ),
                            isScrollControlled: true,
                            ignoreSafeArea: false,
                          );
                        },
                        child: Text(
                          'View more',
                          style: TextStyle(color: Get.theme.primaryColor),
                        ),
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: [
                          Icon(Icons.account_circle_outlined),
                          SizedBox(width: 8.0),
                          Text(feedback.clientName), // e.g. "Remote Roofing A."
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkHistorySection() {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Important for unbounded height
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Work experience on Upwork",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    WorkExperienceBottomsheet(),
                    backgroundColor: Colors.transparent,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Get.theme.primaryColor, width: 2),
                    shape: BoxShape.circle
                  ),
                    child: Icon(Icons.swap_vert, color: Get.theme.primaryColor,)),
              )
            ],
          ),
          const SizedBox(height: 12),

          // ✅ Fix: Remove Expanded, wrap with SizedBox or use shrinkWrap: true
          ListView.builder(
            shrinkWrap: true, // ✅ Makes ListView fit its content
            physics: NeverScrollableScrollPhysics(), // ✅ Prevents inner scrolling
            itemCount: workHistoryController.paginatedItems.length,
            itemBuilder: (context, index) {
              final item = workHistoryController.paginatedItems[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              ...List.generate(5, (i) {
                                return Icon(Icons.star,
                                    size: 16,
                                    color: i < item.rating
                                        ? Colors.amber
                                        : Colors.grey.shade300);
                              }),
                              SizedBox(width: 4),
                              Text(item.rating.toStringAsFixed(1))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.attach_money, size: 14),
                          SizedBox(width: 4),
                          Text(item.price),
                          SizedBox(width: 16),
                          Icon(Icons.calendar_month, size: 14),
                          SizedBox(width: 4),
                          Text(item.dateRange,
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: item.tags
                            .map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Colors.grey.shade100,
                        ))
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      Text(item.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          // Pagination
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: workHistoryController.prevPage,
                  child: Text("Back")),
              Text(
                  "Page ${workHistoryController.currentPage.value + 1} / ${workHistoryController.totalPages}"),
              TextButton(
                  onPressed: workHistoryController.nextPage,
                  child: Text("Next")),
            ],
          ),
        ],
      ),
    ));
  }


  Widget _buildPortfolioSection() {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Portfolio (${portfolioController.allItems.length})",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),

          // Grid view (2x2)
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: portfolioController.paginatedItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.65, // Adjust if needed
            ),
            itemBuilder: (context, index) {
              final item = portfolioController.paginatedItems[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(item.imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),

                    // Limit tag display height or make it scrollable to avoid overflow
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 6,
                          children: item.tags
                              .map((tag) => Chip(
                            label: Text(tag,
                                style: TextStyle(fontSize: 12)),
                            backgroundColor: Colors.grey.shade100,
                          ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: 12),

          // Pagination buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: portfolioController.prevPage,
                  child: Text("Back")),
              Text(
                  "Page ${portfolioController.currentPage.value + 1} / ${portfolioController.totalPages}"),
              TextButton(
                  onPressed: portfolioController.nextPage,
                  child: Text("Next")),
            ],
          ),
        ],
      ),
    ));
  }


  Widget _buildEmploymentHistorySection(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Employment history', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 20,),
          Text('Technical SEO Manager | SoftPrudence', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 20,),
          Text('May 2024 - present', style: TextStyle(
            fontSize: 12, color:Colors.grey
          ),),
          SizedBox(height: 20,),
          Text('Key Responsibilities: Technical SEO Strategy: Developed and executed a comprehensive technical SEO strategy to improve website performance and search engine...'),
          SizedBox(height: 24,),
          ElevatedButton(
              onPressed: () {Get.toNamed(AppRoutes.clientFreelancerProfile);},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                side: BorderSide(color: Get.theme.primaryColor),
                backgroundColor: Get.theme.scaffoldBackgroundColor,
                elevation: 0
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('View full profile', style: TextStyle(
                              color: Get.theme.primaryColor
                            ),),
                  SizedBox(width: 8,),
                  Icon(Icons.open_in_new, color: Get.theme.primaryColor,)
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildSkillsSection(){
    return Column(
      children: [

      ],
    );
  }

  Widget _buildCertificationsSection(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Certifications', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 24,),
          Row(
            children: [
               Image.asset(
                'assets/icon/certificate.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Google Ads Display Certification', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500
                    ),),
                    Text('Provider: Skill Pro Institute', style: TextStyle(
                      fontSize: 16
                    ),)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildSkillSection() {
    return Obx(() {
      final skills = controller.allSkills;
      final isExpanded = controller.expanded.value;

      final maxVisible = 10;
      final showingSkills = isExpanded
          ? skills
          : skills.length > maxVisible
          ? skills.sublist(0, maxVisible)
          : skills;

      final remainingCount = skills.length - showingSkills.length;

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Skills',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 1,
              children: [
                ...showingSkills.map((skill) => Chip(
                  label: Text(skill, style: TextStyle(fontSize: 13)),
                  backgroundColor: Colors.grey.shade200,
                  labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.transparent, width: 0),
                  ),
                )),
                if (remainingCount > 0 && !isExpanded)
                  ActionChip(
                    label: Text("+ $remainingCount more",
                        style: TextStyle(fontSize: 13)),
                    onPressed: () => controller.expanded.value = true,
                    backgroundColor: Colors.grey.shade200,
                    labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.transparent, width: 0),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }


  Widget _buildEducationSection(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Education', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 18,),
          Text('Punjab University Chandigarh', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 18,),
          Text('Master of Computer Science (MSCS), Computer Sciences | 2009-2011', style: TextStyle(
            color: Colors.grey
          ),),
          SizedBox(height: 20,),

          ElevatedButton(
            onPressed: () {Get.toNamed(AppRoutes.clientFreelancerProfile);},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                  BorderRadius.circular(8)
              ),
              side: BorderSide(color: Get.theme.primaryColor)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
            children: [
              Text('View full profile', style: TextStyle(
                  color: Get.theme.primaryColor
              ),),
              SizedBox(width: 8.0,),
              Icon(Icons.open_in_new, color: Get.theme.primaryColor,)
            ],
          ),)
        ],
      ),
    );
  }
}


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
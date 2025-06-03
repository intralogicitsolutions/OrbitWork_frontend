import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/component/client_profile/advanced_search_bottomsheet.dart';

import '../client_profile_controller/freelancer_controller.dart';
import '../client_profile_controller/talent_filters_controller.dart';
import '../component/client_profile/talent_filters_bottomsheet.dart';
import '../routes/app_routes.dart';

class TalentSearchScreen extends StatelessWidget {
  final TalentFiltersController controller = Get.put(TalentFiltersController());
  final FreelancerController freelancerController = Get.put(FreelancerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Talent Search',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar section
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 44,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0,),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                              child: Container(
                                  height: Get.height * 0.7,
                                  color: Get.theme.scaffoldBackgroundColor ,
                                  child: AdvancedSearchBottomsheet()),
                            ),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            ignoreSafeArea: false
                        );
                      },
                      child: Text(
                        'Advanced',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          // Filter button
          Container(
            padding: EdgeInsets.only(left: 16, bottom: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => _showFiltersBottomSheet(context),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.tune,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          // Main content area
          Expanded(
            child: _buildClientProfile(),
          ),
        ],
      ),
    );
  }

  Widget _buildClientProfile(){
    return Obx(() => ListView.builder(
      itemCount: freelancerController.freelancers.length,
      itemBuilder: (context, index) {
        final f = freelancerController.freelancers[index];
        return GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.clientProfilePage);
          },
          child: Card(
            color: Get.theme.scaffoldBackgroundColor,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                     backgroundColor: Colors.grey.shade300,
                     //   backgroundImage: NetworkImage(f.profileImage),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(f.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 8,),
                                if (f.isBoosted)
                                  Container(
                                    padding: EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(28),
                                      color: Colors.purple.shade50
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 6.0),
                                          child: Icon(Icons.electric_bolt_outlined, color: Colors.purple, size: 16),
                                        ),
                                        SizedBox(width: 5,),
                                        Text('Boosted', style: TextStyle(color: Colors.purple, fontSize: 12),),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            Text(f.title,),
                            Text(f.country, style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Get.theme.primaryColor, width: 2)
                          ),
                          child: Icon(Icons.favorite_border, color: Get.theme.primaryColor, size: 20,)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('\$${f.rate}/hr'),
                      SizedBox(width: 10),
                      Icon(Icons.verified, color: Colors.blue, size: 16),
                      Text('${f.jobSuccess}% Job Success'),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Text('${f.earnings >= 1000 ? '\$${(f.earnings / 1000).floor()}K+' : '\$${f.earnings}'} earned'),
                      SizedBox(width: 10),
                      if (f.isAvailable)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.purple.shade50
                          ),
                            child: Row(
                              children: [
                                Icon(Icons.electric_bolt_outlined, size: 16,color: Colors.purple,),
                                SizedBox(width: 5,),
                                Text('Available now', style: TextStyle(color: Colors.purple, fontSize: 12),),
                              ],
                            ))
                        // Chip(
                        //     label: Text("Available now"),
                        //     backgroundColor: Colors.purple.shade100
                        // ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: f.skills.map((s) =>
                        Chip(
                            label: Text(s),
                          backgroundColor: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          padding: EdgeInsets.all(2),
                          side: BorderSide.none,
                        )).toList(),
                  ),
                  if (f.agencyName.isNotEmpty)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.business),
                      title: Text("Associated with ${f.agencyName}"),
                      subtitle: Text('\$${(f.agencyEarnings / 1000).floor()}K+ earned'),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }

  void _showFiltersBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TalentFiltersBottomSheet(),
    );
  }
}

class TalentSearchPage extends StatelessWidget {
  final controller = Get.put(FreelancerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Talent Search')),
      body: Obx(() => ListView.builder(
        itemCount: controller.freelancers.length,
        itemBuilder: (context, index) {
          final f = controller.freelancers[index];
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(f.profileImage),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(f.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                if (f.isBoosted)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child: Icon(Icons.flash_on, color: Colors.purple, size: 16),
                                  ),
                              ],
                            ),
                            Text(f.title, overflow: TextOverflow.ellipsis),
                            Text(f.country, style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Icon(Icons.favorite_border, color: Colors.green),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('\$${f.rate}/hr'),
                      SizedBox(width: 10),
                      Icon(Icons.verified, color: Colors.blue, size: 16),
                      Text('${f.jobSuccess}% Job Success'),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Text('${f.earnings >= 1000 ? '\$${(f.earnings / 1000).floor()}K+' : '\$${f.earnings}'} earned'),
                      SizedBox(width: 10),
                      if (f.isAvailable)
                        Chip(label: Text("Available now"), backgroundColor: Colors.purple.shade100),
                    ],
                  ),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: f.skills.map((s) => Chip(label: Text(s))).toList(),
                  ),
                  if (f.agencyName.isNotEmpty)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.business),
                      title: Text("Associated with ${f.agencyName}"),
                      subtitle: Text('\$${(f.agencyEarnings / 1000).floor()}K+ earned'),
                    ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}

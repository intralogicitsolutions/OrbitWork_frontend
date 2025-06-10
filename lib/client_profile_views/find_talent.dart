import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_views/recently_viewed.dart';

import '../client_profile_controller/talent_controller.dart';
import '../client_profile_model/talent_model.dart';
import '../component/client_profile/talent_list_bottomsheet.dart';
import '../routes/app_routes.dart';
import '../widgets/hexagon_clipper.dart';

class FindTalent extends StatelessWidget{
  final TalentController controller = Get.put(TalentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Talent'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSearchbar(),
              SizedBox(height: 12,),
              _buildList(context),
              Divider(height: 40,),
              RecentlyViewedPage()
              // _buildRecentlyViewedSection(),
              // SizedBox(height: 24,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchbar(){
    return  Container(
      height: 40,
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
            hintText: 'Search',
            hintStyle: TextStyle(
                color: Colors.grey
            ),
            suffixIcon: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8))
              ),
              child: IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.talentSearchScreen);
                },
                icon: Icon(Icons.search, color: Colors.white,),
              ),
            )
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context){
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            child: Container(
              height: Get.height * 0.7,
              color: Get.theme.scaffoldBackgroundColor,
              child: TalentListBottomsheet(),
            ),
          ),
          isScrollControlled: true,
          backgroundColor: Colors.transparent, // Important
          ignoreSafeArea: false,
        );
      },

      child: Container(
        height: 40,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Colors.grey.shade600),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Text('Discover'),
              Obx(() => Text(controller.selectedListName.value)),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        ),
      ),
    );
  }


}
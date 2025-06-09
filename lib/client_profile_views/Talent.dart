import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../client_profile_controller/browse_category_controller.dart';
import '../client_profile_controller/talent_controller.dart';
import '../client_profile_model/category_model.dart';
import '../client_profile_model/talent_model.dart';
import '../component/client_profile/talent_list_bottomsheet.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_appbar.dart';

class TalentPage extends StatelessWidget{
  final TalentController controller = Get.put(TalentController());
  final BrowseCategoryController browseController = Get.put(BrowseCategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //appBar: AppBar(title: Text('Talent'),),
      appBar: CustomAppBar(
        title: 'Talent',
        rightIcon: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      ),

      body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchbar(),
                  SizedBox(height: 12,),
                  _buildList(context),
                  Divider(height: 40,),
                  _buildTitleSearch('Recently viewed', 'See all recently viewed'),

                  if (controller.recentlyViewed.isNotEmpty)
                  _buildRecentlyViewedSection(),
                  SizedBox(height: 24,),


                  _buildTitleSearch('Talent to check out', 'See more like this', onTap: () {

                    Get.toNamed(AppRoutes.talentSearchScreen);
                  },),

                  _buildTalentToCheckOutSection(),
                  SizedBox(height: 24,),


                  _buildTitleSearch('Talent in India', 'See more from this area'),

                  _buildSeeMoreFromAreaSection(),
                  SizedBox(height: 24),


                  _buildTitleSearch('Projects you may like', 'Find more projects'),

                  _buildProjectsYouMayLikeSection(),
                  SizedBox(height: 24),

                  Text('Browse by category', style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w500
                  ),),

                  SizedBox(height: 24,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: browseController.categories.length,
                    itemBuilder: (context, index) {
                      return _buildCategoryItem(browseController.categories[index]);
                    },
                  ),

                ],
              ),
            ),
          );
        }
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

  Widget _buildTitleSearch(String title, String searchText,{ VoidCallback? onTap}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w500
        ),),
        SizedBox(height: 12,),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 2,color: Colors.grey.shade300)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search,color: Get.theme.primaryColor,size: 20,),
                SizedBox(width: 10,),
                Text(searchText, style: TextStyle(
                    fontSize: 16,
                    color: Get.theme.primaryColor
                ),),
              ],
            ),
          ),
        ),
        SizedBox(height: 24,),
      ],
    );
  }

  Widget _buildRecentlyViewedSection() {
    return Column(
      children: [
        SizedBox(height: 16),
        Container(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.recentlyViewed.length,
            itemBuilder: (context, index) {
              return _buildTalentCard(controller.recentlyViewed[index], true);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTalentToCheckOutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Container(
         height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.talentToCheckOut.length,
            itemBuilder: (context, index) {
              return _buildTalentCard(controller.talentToCheckOut[index], false);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTalentCard(TalentModel talent, bool isCompact) {
    return GestureDetector(
      onTap: () => controller.viewTalentProfile(talent),
      child: Container(
        width: isCompact ? 280 : 300,
        margin: EdgeInsets.only(right: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(talent.profileImage),
                    ),
                    if (talent.isOnline)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        talent.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${talent.location} | ${talent.specialization}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.grey[400]),
                  onPressed: () => controller.addToFavorites(talent.id),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '\$${talent.hourlyRate.toStringAsFixed(2)}/hr',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Spacer(),
                if (talent.isTopRated)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.blue, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'TOP RATED',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              '${talent.jobSuccessRate}% Job Success',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSeeMoreFromAreaSection() {
    return Column(
      children: [
        Container(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.talentFromArea.length,
            itemBuilder: (context, index) {
              return _buildTalentIndiaCard(controller.talentFromArea[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsYouMayLikeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.projectsYouMayLike.length,
                itemBuilder: (context, index) {
                  return _buildProjectCard(controller.projectsYouMayLike[index]);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTalentIndiaCard(TalentModel talent) {
    return GestureDetector(
      onTap: () => controller.viewTalentProfile(talent),
      child: Container(
        width: 280,
        margin: EdgeInsets.only(right: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(talent.profileImage),
                    ),
                    if (talent.isOnline)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        talent.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[700],
                        ),
                      ),
                      Text(
                        talent.specialization,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.grey[400]),
                  onPressed: () => controller.addToFavorites(talent.id),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '\$${talent.hourlyRate.toStringAsFixed(2)}/hr',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Spacer(),
                if (talent.isTopRated)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.blue, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'TOP RATED',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (!talent.isTopRated) SizedBox(height: 8),
            if (!talent.isTopRated)
              Text(
                '${talent.jobSuccessRate}% Job Success',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(ProjectModel project) {
    return GestureDetector(
      onTap: () => controller.viewProject(project),
      child: Container(
        width: 250,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                // image: DecorationImage(
                //   image: NetworkImage(project.projectImage),
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'From \$${project.startingPrice.toInt()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Spacer(),
                      Obx(() => GestureDetector(
                        onTap: () => controller.toggleFavorite(project.id),
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: controller.favoriteProjects.contains(project.id)
                                ? Colors.green
                                : Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: 16,
                            color: controller.favoriteProjects.contains(project.id)
                                ? Colors.white
                                : Colors.grey[400],
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                       // backgroundImage: NetworkImage(project.freelancerImage),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          project.freelancerName,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '${project.rating} (${project.reviewCount})',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (project.isTopRated) ...[
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.blue, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'Top Rated',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(CategoryModel category) {
    return Obx(() {
      bool isExpanded = browseController.expandedCategoryId.value == category.id;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Header
            InkWell(
              onTap: () => browseController.toggleCategory(category.id),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        category.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isExpanded ? Colors.green[700] : Colors.black87,
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: isExpanded ? Colors.green[700] : Colors.grey[600],
                    ),
                  ],
                ),
              ),
            ),

            // Subcategories (Expandable)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: isExpanded ? null : 0,
              child: isExpanded ? _buildSubcategories(category) : SizedBox.shrink(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSubcategories(CategoryModel category) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: category.subcategories.map((subcategory) {
          return _buildSubcategoryChip(category.title, subcategory);
        }).toList(),
      ),
    );
  }

  Widget _buildSubcategoryChip(String categoryTitle, String subcategory) {
    return GestureDetector(
      onTap: () => browseController.selectSubcategory(categoryTitle, subcategory),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          subcategory,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }


}
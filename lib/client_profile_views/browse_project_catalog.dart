import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_controller/project_catalog_controller.dart';
import '../client_profile_model/project_model.dart';
import '../widgets/hexagon_clipper.dart';

class BrowseProjectCatalog extends StatelessWidget {
  final ProjectCatalogController controller = Get.put(ProjectCatalogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Browse Project Catalog',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
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
      body: Column(
        children: [
          // Search bar
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                onChanged: controller.onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search projects',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          // Project count
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              '1,094,507 projects available',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Projects list
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.projects.length,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemBuilder: (context, index) {
                final project = controller.projects[index];
                return ProjectCard(project: project, controller: controller);
              },
            )),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            // Filter button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: controller.showFilterBottomSheet,
                icon: Icon(Icons.tune, color: Colors.white),
                label: Text(
                  'Filter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            SizedBox(width: 15),

            // Saved button
            Expanded(
              child: Obx(() => OutlinedButton.icon(
                onPressed: controller.showSavedProjects,
                icon: Icon(Icons.favorite_border, color: Colors.green[600]),
                label: Text(
                  'Saved (${controller.savedCount.value})',
                  style: TextStyle(
                    color: Colors.green[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.green[600]!),
                  padding: EdgeInsets.symmetric(vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

// Project Card Widget
class ProjectCard extends StatelessWidget {
  final Project project;
  final ProjectCatalogController controller;

  const ProjectCard({
    Key? key,
    required this.project,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project images
              Container(
                width: 100,
                height: 80,
                child: project.projectImages.length == 1
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    project.projectImages[0],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.image, color: Colors.blue[300]),
                      );
                    },
                  ),
                )
                    : GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: project.projectImages.length > 4 ? 4 : project.projectImages.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        project.projectImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.blue[100],
                            child: Icon(Icons.image, color: Colors.blue[300], size: 20),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              SizedBox(width: 15),

              // Project details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      project.price,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // Favorite button
              Obx(() => GestureDetector(
                onTap: () => controller.toggleFavorite(project.id),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.favoriteProjects.contains(project.id)
                        ? Colors.green[100]
                        : Colors.grey[100],
                  ),
                  child: Icon(
                    controller.favoriteProjects.contains(project.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: controller.favoriteProjects.contains(project.id)
                        ? Colors.green[600]
                        : Colors.grey[600],
                    size: 20,
                  ),
                ),
              )),
            ],
          ),

          SizedBox(height: 15),

          // Provider info
          Row(
            children: [
              // Profile image
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: ClipOval(
                  child: Image.asset(
                    project.profileImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.person, color: Colors.grey[400]),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(width: 12),

              // Name and badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.providerName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                   // if (project.isTopRatedPlus)
                      // Container(
                      //   margin: EdgeInsets.only(top: 4),
                      //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      //   decoration: BoxDecoration(
                      //     color: Colors.pink[100],
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Icon(Icons.star, color: Colors.pink, size: 12),
                      //       SizedBox(width: 4),
                      //       Text(
                      //         'Top Rated Plus',
                      //         style: TextStyle(
                      //           fontSize: 10,
                      //           color: Colors.pink[700],
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Row(
                        children: [
                          ClipPath(
                            // clipper: HexagonClipper(),
                            clipper: HexagonClipper(cornerRadius: 4.0),
                            child: Container(
                              // padding: EdgeInsets.all(4),
                              // decoration: BoxDecoration(
                                width: 25,
                                height: 25,
                                color: project.isTopRatedPlus  ? Colors.pink.shade300 : Colors.blue.shade700,
                                alignment: Alignment.center,
                                //   shape: BoxShape.circle,
                                // ),
                                child: Icon(
                                  Icons.star_border,
                                  color: Colors.white,
                                  size: 16,
                                )),
                          ),
                          SizedBox(width: 8),
                          Text(
                            project.isTopRatedPlus  ?    'Top Rated Plus' : 'Top Rated',
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              // Rating
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  SizedBox(width: 4),
                  Text(
                    '${project.rating} (${project.reviewCount})',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
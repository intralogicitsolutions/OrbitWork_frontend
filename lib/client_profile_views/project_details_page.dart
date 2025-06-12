import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_controller/project_details_controller.dart';

import '../client_profile_controller/client_freelancer_profile_controller.dart';
import '../client_profile_controller/client_profile_controller.dart';
import '../client_profile_controller/consultation_controller.dart';
import '../client_profile_model/consultation_project_model.dart';
import '../comms/global/global_tooltip.dart';
import '../component/profile/share_project_bottomsheet.dart';
import '../routes/app_routes.dart';
import '../widgets/hexagon_clipper.dart';

class ProjectDetailsPage extends StatelessWidget {
  final ClientProfileController profileController = Get.put(ClientProfileController());
  final ProjectDetailsController controller = Get.put(ProjectDetailsController());
  final ClientFreelancerProfileController freelancerProfileController = Get.put(ClientFreelancerProfileController());
  final ConsultationController consultationController = ConsultationController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project details'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'You will get Amazon A+ Content, A+ Premium & Product Images - High-Quality Design',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.person,
                                size: 20, color: Colors.grey[600]),
                          ),
                          Positioned(
                              child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: profileController.isOnline.value
                                  ? Colors.green
                                  : Colors.grey,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Rahul K.',
                          style: TextStyle(
                              fontSize: 16, color: Get.theme.primaryColor),
                        ),
                      ),
                      ClipPath(
                        clipper: HexagonClipper(cornerRadius: 4.0),
                        child: Container(
                            // padding: EdgeInsets.all(4),
                            // decoration: BoxDecoration(
                            width: 28,
                            height: 30,
                            color: Colors.pink.shade300,
                            alignment: Alignment.center,
                            //   shape: BoxShape.circle,
                            // ),
                            child: Icon(
                              Icons.star_border,
                              color: Colors.white,
                              size: 16,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '5.0',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        '(158)',
                        style:
                            TextStyle(color: Colors.grey.shade600, fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: controller.pageController,
                            itemCount: controller.images.length,
                            onPageChanged: controller.onPageChanged,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                // borderRadius: BorderRadius.vertical(
                                //     top: Radius.circular(12)),
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  controller.images[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                        // SizedBox(height: 8),
                        // Obx(() => Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: List.generate(controller.images.length,
                        //           (index) {
                        //         bool isSelected =
                        //             controller.currentPage.value == index;
                        //         return Container(
                        //           margin: EdgeInsets.symmetric(horizontal: 4),
                        //           width: isSelected ? 12 : 8,
                        //           height: isSelected ? 12 : 8,
                        //           decoration: BoxDecoration(
                        //             color:
                        //                 isSelected ? Colors.green : Colors.grey,
                        //             shape: BoxShape.circle,
                        //           ),
                        //         );
                        //       }),
                        //     )),
                        // SizedBox(height: 12),
                      ],
                    ),
                    Positioned(
                        top: 5,
                        right: 10,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(
                                  ShareProjectBottomsheet(),
                                );
                              },
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Colors.grey, width: 2)),
                                  child: Icon(
                                    Icons.share_outlined,
                                    color: Get.theme.primaryColor,
                                    size: 16,
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Obx(() {
                                return GestureDetector(
                                  onTap: controller.toggleSave,
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.grey, width: 2)),
                                      child: Icon(
                                        controller.isSaved.value
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Get.theme.primaryColor,
                                        size: 16,
                                      )),
                                );
                              }
                            ),
                          ],
                        )),
                    Obx(() => Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(controller.images.length,
                                (index) {
                              bool isSelected =
                                  controller.currentPage.value == index;
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                width: isSelected ? 12 : 8,
                                height: isSelected ? 12 : 8,
                                decoration: BoxDecoration(
                                  color:
                                  isSelected ? Colors.green : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Let a pro handle the details', style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500,
                      ),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: RichText(text: TextSpan(
                          style: TextStyle(color: Get.theme.secondaryHeaderColor),
                          children: [
                            TextSpan(
                              text: 'Buy '
                            ),
                            TextSpan(
                              text: 'Product Photography',
                              style: TextStyle(
                                color: Get.theme.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: Get.theme.primaryColor
                              )
                            ),
                            TextSpan(
                              text: ' Services from Mar, priced and ready to go.'
                            ),
                          ]
                        )),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          side: BorderSide(color: Get.theme.primaryColor)
                        ),
                          onPressed: () {}, child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('How it works', style: TextStyle(
                            color: Get.theme.primaryColor,
                            fontSize: 16
                          ),),
                          SizedBox(width: 8,),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Get.theme.primaryColor)
                            ),
                              child: Icon(Icons.play_arrow_outlined, color: Get.theme.primaryColor,))
                        ],
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.monetization_on_outlined),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Upwork Payment Protection', style: TextStyle(
                          fontSize: 16
                        ),),
                        Text('Fund the project upFront. Mar gets paid once you are satisfied with the work.')
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              // _buildServiceTypeSelection(),
              // controller.selectedServiceType.value == 'project_rates' ? _buildServiceTierSelection():
              // _buildCustomWork(),
              _selectServiceContainer(),

              SizedBox(height: 20,),
              _buildProjectDetail(),
              SizedBox(height: 20,),
              _buildServiceTiersTable(),
              SizedBox(height: 20,),
              _buildCustomWork(),
              SizedBox(height: 20,),
              _buildPortfolio(),
              Row(
                children: [
                  Icon(Icons.flag_outlined, color: Colors.grey,),
                  Text('Report this project', style: TextStyle(
                    color: Colors.grey
                  ),)
                ],
              ),
              SizedBox(height: 20,),
              _buildRatingInfo(),
              SizedBox(height: 24,),
              _buildRatingBreakDown(),
              SizedBox(height: 24,),
              _buildProjectSection(),
              SizedBox(height: 24,),
              _buildProfile(),
              SizedBox(height: 24,),
              _buildStepsCompletingProject(),
              SizedBox(height: 24,),
              _buildPeopleViewed(),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildCustomWork(){
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
       borderRadius: BorderRadius.circular(12)
      ) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SvgPicture.asset(
              'assets/icon/customize-project.svg',
              height: 120,
              width: 120,
            ),
          ),
          Text('Customize this project', style: TextStyle(
           fontSize: 20, fontWeight: FontWeight.w500
          ),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text('If you\'re not seeing exactly what you need here, send Mar a custom request. You can talk about the price and timeline to create a personalized project.'),
          ),
          SizedBox(
            width: Get.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
                backgroundColor: Colors.grey.shade300
              ),
                onPressed: () {},
                child: Text('Send a request', style: TextStyle(
                  color: Colors.grey
                ),)),
          )
        ],
      ),
    );
  }

  Widget _buildProjectDetail(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Project details', style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500
        ),),
        SizedBox(height: 16,),
        Text('I will create impactful EBC/A+ content or images.'),
        Text('I am a professional graphic designer with in-depth knowledge. I guarantee fantastic design and real value.'),
        SizedBox(height: 10,),
        Text('File Format', style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500
        ),),
        SizedBox(height: 8.0,),
        Text('JPG, PNG, RAW, PSD,TIFF'),
        SizedBox(height: 10,),
        Text('Photo Setting', style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500
        ),),
        Text('360°'),
        SizedBox(height: 10,),
        Text('Product Type',style: TextStyle(
          fontSize: 20,  fontWeight: FontWeight.w500
        ),),
        SizedBox(height: 10,),
        Text('Beauty & Health, Food, Pet Supplies')
      ],
    );
  }

  Widget _buildPortfolio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Portfolio',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 12),
        Obx(() {
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 0.8,
            padding: EdgeInsets.all(16),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: freelancerProfileController.items.map((item) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8), // Rounded image
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Image.asset(
                        item.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Get.theme.primaryColor),
                  ),
                ],
              );
            }).toList(),
          );
        })


      ],
    );
  }

  Widget _buildRatingInfo() {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 22,
                );
              }),
            ),
            const SizedBox(width: 8),
            const Text(
              '5.0 ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              '(156)',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Obx(() {
          return Column(
              children: List.generate(5, (index) {
                int star = 5 - index;
                int count = consultationController.ratings[index];
                double percent =
                consultationController.totalVotes == 0 ? 0 : count / consultationController.totalVotes;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          '$star ${star == 1 ? "star" : "stars"}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: percent,
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text('($count)',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.blue))),
                    ],
                  ),
                );
              }));
        }),
      ],
    );
  }

  Widget _buildRatingBreakDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rating breakdown'),
        SizedBox(
          height: 12,
        ),
        _ratingRowWidget('Availability', 'Deadlines'),
        _ratingRowWidget('Skills', 'Cooperation'),
        _ratingRowWidget('Quality', 'Communication'),
      ],
    );
  }

  Widget _ratingRowWidget(String title, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Title
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(fontSize: 12),
            ),
          ),

          // Center: Star + Rating + Text (center aligned)
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(Icons.star, size: 18, color: Colors.amber),
                SizedBox(width: 4),
                Text(
                  '5.0',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Right: Another Star + Rating
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.star, size: 18, color: Colors.amber),
                SizedBox(width: 4),
                Text(
                  '5.0',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildProjectSection() {
    return Obx(() {
      final displayedItems = consultationController.getDisplayedItems();
      final shouldShowMore = consultationController.shouldShowMoreButton();

      return SingleChildScrollView(
        // padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Tab Bar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabButton(0, consultationController.getTabTitle(0)),
                  const SizedBox(width: 32),
                  _buildTabButton(1, consultationController.getTabTitle(1)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // List items
            ...displayedItems.map((item) => _buildConsultationItem(item)).toList(),

            // Show More Button (if needed)
            if (shouldShowMore) _buildShowMoreButton(),
          ],
        ),
      );
    });
  }

  Widget _buildTabButton(int index, String title) {
    final isSelected = consultationController.selectedTab.value == index;

    return GestureDetector(
      onTap: () => consultationController.changeTab(index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            width: title.length * 8.0,
            color: isSelected ? Colors.black : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildConsultationItem(ConsultationItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                item.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and rating
                Row(
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),

                const SizedBox(height: 4),

                // Rating and date
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.rating.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      item.date,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Duration
                Text(
                  item.duration,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),

                // Description (if available)
                if (item.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowMoreButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Center(
        child: GestureDetector(
          onTap: () => consultationController.toggleShowMore(consultationController.selectedTab.value),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              'Show more feedback',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildProfile() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 46,
                    backgroundColor: Colors.grey[300],
                    child:
                    Icon(Icons.person, size: 50, color: Colors.grey[600]),
                  ),
                  //Online status indicator
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Obx(() =>
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: profileController.isOnline.value
                                ? Colors.green
                                : Colors.grey,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                width: 28,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'About Rahul',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Icon(
                          Icons.verified,
                          color: Colors.blue.shade700,
                          size: 20,
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.clientFreelancerProfile);
                      },
                      child: Row(
                        children: [
                          Text(
                            'View profile',
                            style: TextStyle(
                                color: Get.theme.primaryColor, fontSize: 16),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.open_in_new,
                            color: Get.theme.primaryColor,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.clientFreelancerProfile);
                      },
                      child: Row(
                        children: [
                          Text(
                            'View portfolio',
                            style: TextStyle(
                                color: Get.theme.primaryColor, fontSize: 16),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.open_in_new,
                            color: Get.theme.primaryColor,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'Top 1 percent Google ads, Fb Ads, Paid Ads, PPC Expert',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 24,
          ),
          GlobalTooltip(
            content: RichText(text: TextSpan(
                style: TextStyle(
                    color: Get.theme.secondaryHeaderColor,
                    height: 1.5,
                    fontSize: 16
                ),
                children: [
                  TextSpan(text: 'Top Rated Plus', style: TextStyle(
                      fontWeight: FontWeight.w500
                  )),
                  TextSpan(text: ' talent is highly rated for work on large contracts. '),
                  TextSpan(text: 'Learn more', style: TextStyle(color: Get.theme.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: Get.theme.primaryColor
                  ))
                ]
            )),
            child:Row(
              children: [
                ClipPath(
                  clipper: HexagonClipper(cornerRadius: 4.0),
                  child: Container(
                    // padding: EdgeInsets.all(4),
                    // decoration: BoxDecoration(
                      width: 28,
                      height: 30,
                      color: Colors.pink,
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
                  'Top Rated Plus',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 28,
          ),
          GlobalTooltip(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('The Job Success Score reflects a combination of factors.'),
                Text('Learn more', style: TextStyle(
                    color: Get.theme.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: Get.theme.primaryColor
                ),)
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  color: Colors.blue.shade700,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  '95% Job Success',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),

          Divider(
            height: 48,
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text('4.7', style: TextStyle(fontSize: 16)),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '(480 reviews)',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Text(
                    'Ballabgarh, India',
                    style: TextStyle(fontSize: 16),
                  )),
              SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Text(
                    '- 5:36 pm local time',
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            'I\'m a Senior UI/UX and Web Designer creating user-centered designs for brands like "PaySafe", "Michael\'s", and "Mayo Clinic". I\'m proficient in Interaction Design, Visual Design, and Creative Direction by using',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPeopleViewed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'People like you also viewed',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16,),
        ListView.builder(
          // padding: const EdgeInsets.symmetric(horizontal: 24),
          shrinkWrap: true, // Important
          physics: NeverScrollableScrollPhysics(), // Prevent nested scrolling
          itemCount: consultationController.serviceProviders.length,
          itemBuilder: (context, index) {
            return _buildServiceProviderCard(consultationController.serviceProviders[index]);
          },
        ),
      ],
    );
  }

  Widget _buildServiceProviderCard(ServiceProvider provider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service image
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    provider.name.contains('Steve') ? 'CREATIVE\nVISUAL\nDESIGN\nSTUDIO' :
                    provider.name.contains('Mariusz') ? 'total jobs\n4,000' :
                    'THE ENTERPRISE\nDISCOVERY SERVICE',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            provider.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Obx(() {
                          return GestureDetector(
                            onTap: () => provider.isSaved.value = !provider.isSaved.value,
                            child: Icon(
                              provider.isSaved.value  ? Icons.favorite :  Icons.favorite_border,
                              size: 20,
                            ),
                          );
                        }
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.videocam,
                          size: 16,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Zoom meeting ${provider.price}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Profile section
          Row(
            children: [
              // Profile image
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: provider.name.contains('Steve') ? Colors.grey[400] :
                    provider.name.contains('Mariusz') ? Colors.orange[300] :
                    Colors.grey[600],
                    shape: BoxShape.circle
                ),
                child: Center(
                  child: Text(
                    provider.name.split(' ').map((e) => e[0]).join(''),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12,),
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
                            color: provider.isTopRatedPlus  ? Colors.pink.shade300 : Colors.blue.shade700,
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
                        provider.badge,
                      ),
                    ],
                  ),
                ],
              ),

              const Spacer(),

              // Rating
              const Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
              const SizedBox(width: 4),
              Text(
                '${provider.rating} (${provider.reviews})',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }



  Widget _buildStepsCompletingProject(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'Steps for completing your project',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 30),

        // Step 1
        _buildStep(
          stepNumber: 1,
          title: 'After purchasing the project, send requirements so Mar can start the project.',
          subtitle: 'Delivery time starts when Mar receives requirements from you.',
          hasExpandable: true,
          expandableText: 'View requirements',
          isExpanded: controller.isRequirementsExpanded,
          onExpandTap: controller.toggleRequirements,
        ),

        SizedBox(height: 30),

        // Step 2
        _buildStep(
          stepNumber: 2,
          title: 'Mar works on your project following the steps below.',
          subtitle: 'Revisions may occur after the delivery date.',
          hasExpandable: true,
          expandableText: 'Show all',
          isExpanded: controller.isStepsExpanded,
          onExpandTap: controller.toggleSteps,
          expandableContent: _buildStepContent(),
        ),

        SizedBox(height: 30),

        // Step 3
        _buildStep(
          stepNumber: 3,
          title: 'Review the work, release payment, and leave feedback to Mar.',
          subtitle: '',
          hasExpandable: true,
          expandableText: 'What if I\'m not happy with the work?',
          isExpanded: controller.isGuaranteeExpanded,
          onExpandTap: controller.toggleGuarantee,
        ),

        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStep({
    required int stepNumber,
    required String title,
    required String subtitle,
    bool hasExpandable = false,
    String? expandableText,
    RxBool? isExpanded,
    VoidCallback? onExpandTap,
    Widget? expandableContent,
  }) {return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step number circle
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              stepNumber.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              if (subtitle.isNotEmpty) ...[
                SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],

              // Expandable section
              if (hasExpandable && expandableText != null) ...[
                SizedBox(height: 12),
                GestureDetector(
                  onTap: onExpandTap,
                  child: Row(
                    children: [
                      Text(
                        expandableText,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4),
                      Obx(() => Icon(
                        isExpanded?.value == true
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.green,
                        size: 20,
                      )),
                    ],
                  ),
                ),
              ],

              // Expandable content
              if (expandableContent != null)
                Obx(() => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: isExpanded?.value == true ? null : 0,
                  child: isExpanded?.value == true
                      ? Column(
                    children: [
                      SizedBox(height: 12),
                      expandableContent,
                    ],
                  )
                      : SizedBox.shrink(),
                )),
            ],
          ),
        ),
      ],
    );}

  Widget _buildStepContent() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check, color: Colors.green, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Revisions may occur after the delivery date.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text(
              '*Gather requirement *Deliver first draft *Incorporate edits *Deliver final draft',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _selectServiceContainer(){
    return Obx(() {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey)
          ),
          child: Column(
            children: [
              _buildServiceTypeSelection(),
              SizedBox(height: 10,),
              controller.selectedServiceType.value == 'project_rates' ? _buildServiceTierSelection():
              _buildCustomWork(),
            ],
          ),
        );
      }
    );
  }

  Widget _buildServiceTypeSelection() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => _buildServiceCard(
            icon: Icons.local_offer_outlined,
            title: 'Project rates',
            isSelected: controller.selectedServiceType.value == 'project_rates',
            onTap: () => controller.selectServiceType('project_rates'),
          )),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Obx(() => _buildServiceCard(
            icon: Icons.chat_bubble_outline,
            title: 'Custom work',
            isSelected: controller.selectedServiceType.value == 'custom_work',
            onTap: () => controller.selectServiceType('custom_work'),
          )),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey[300]!,
            width: isSelected ? 1 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          children: [
            if (isSelected)
              Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.check, color: Colors.green, size: 20),
              ),
            SizedBox(height: isSelected ? 8 : 20),
            Icon(icon, size: 32, color: Colors.black),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTierSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select service tier',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              'Compare tiers',
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        // Service Tier Options
        Row(
          children: [
            _buildTierOption('Starter', '\$200'),
            _buildTierOption('Standard', '\$220'),
            _buildTierOption('Advanced', '\$460'),
          ],
        ),
        SizedBox(height: 30),

        // Project Details
        _buildProjectDetails(),
      ],
    );
  }

  Widget _buildTierOption(String tier, String price) {
    return Expanded(
      child: Obx(() => GestureDetector(
        onTap: () => controller.selectTier(tier),
        child: Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: controller.selectedTier.value == tier
                      ? Colors.green
                      : Colors.grey[400]!,
                  width: 2,
                ),
                color: controller.selectedTier.value == tier
                    ? Colors.green
                    : Colors.transparent,
              ),
              child: controller.selectedTier.value == tier
                  ? Icon(Icons.circle, color: Colors.white, size: 12)
                  : null,
            ),
            SizedBox(height: 8),
            Text(
              tier,
              style: TextStyle(
                fontSize: 16,
               // fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildProjectDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '5 Module Listing/ A+ (Image)',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Design 5 Module Section of EBC/A+ Content or Listing Images',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24),

        // Project specifications
        _buildSpecRow('Delivery Time', '4 days'),
        _buildSpecRow('Number of Products', '1'),
        _buildSpecRow('Number of Photos Per Product', '5'),
        _buildSpecRow('Number of Revisions', '2'),
        _buildSpecRow('Retouching', '', hasCheck: true),
        _buildSpecRow('Background Removal', '', hasCheck: true),
        _buildSpecRow('Lifestyle Staging', '', hasCheck: true),
        _buildSpecRow('Infographic', '', hasCheck: true),

        SizedBox(height: 20,),
        Align(
          alignment: Alignment.center,
          child: Text('4 days delivery - Jun 13,2025', style: TextStyle(
            fontSize: 16
          )),
        ),
        Row(
          children: [
            Icon(Icons.access_time),
            SizedBox(width: 8,),
            Text('Revisions may occur after this date.'),
          ],
        ),
        SizedBox(height: 20,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.error_outline, color: Colors.amber,),
            SizedBox(width: 8,),
            Expanded(
              child: Text('Sorry, you cannot purchase projects in Project Catalog using this account.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey
              ),),
            ),
          ],
        ),
        SizedBox(height: 16,),
        SizedBox(
          width: Get.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
            ),
              onPressed: () {},
              child: Text('Continue(\$200)', style: TextStyle(
                color: Colors.grey
              ),)),
        ),

        SizedBox(height: 12,),

        SizedBox(
          width: Get.width,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              onPressed: () {},
              child: Text('Message Mar', style: TextStyle(
                  color: Colors.grey
              ),)),
        )
      ],
    );
  }

  Widget _buildSpecRow(String label, String value, {bool hasCheck = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              decoration: hasCheck ? TextDecoration.underline : TextDecoration.none,
              decorationStyle: TextDecorationStyle.dotted,
            ),
          ),
          if (hasCheck)
            Icon(Icons.check, color: Colors.green, size: 18)
          else
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }



  Widget _buildServiceTiersTable() {
    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          child: Row(
            children: [
              // Service Tiers label
              Container(
                width: 150,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Service Tiers',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              // Horizontal scrollable tier columns
              Expanded(
                child: SingleChildScrollView(
                  controller: controller.horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildTierColumn('Starter', '\$200'),
                      _buildTierColumn('Standard', '\$220'),
                      _buildTierColumn('Advanced', '\$460'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Table rows
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildTableRow('Delivery Time', ['4 days', '5 days', '6 days']),
              _buildTableRow('Number of Products', ['1', '1', '1']),
              _buildTableRow('Number of Photos Per Product', ['5', '6', '8']),
              _buildTableRow('Number of Revisions', ['2', '5', 'Unlimited']),
              _buildTableRow('Retouching', [true, true, true]),
              _buildTableRow('Model/Live Subject', [false, false, true]),
              _buildTableRow('Background Removal', [true, true, true]),
              _buildTableRow('Lifestyle Staging', [true, true, true]),
              _buildTableRow('Infographic', [true, true, true]),
              _buildTableRow('Product Prep', [false, false, true]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTierColumn(String tierName, String price) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Text(
            tierName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(String label, List<dynamic> values) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Label column
          Container(
            width: 150,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                decoration: (label == 'Number of Products' ||
                    label == 'Number of Photos Per Product' ||
                    label == 'Number of Revisions' ||
                    label == 'Retouching' ||
                    label == 'Model/Live Subject' ||
                    label == 'Background Removal' ||
                    label == 'Lifestyle Staging' ||
                    label == 'Infographic' ||
                    label == 'Product Prep')
                    ? TextDecoration.underline
                    : TextDecoration.none,
                decorationStyle: TextDecorationStyle.dotted,
              ),
            ),
          ),
          // Values columns with horizontal scroll
          Expanded(
            child: SingleChildScrollView(
              controller: controller.horizontalScrollController,
             scrollDirection: Axis.horizontal,
              child: Row(
                children: values.asMap().entries.map((entry) {
                  return Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: _buildTableCell(entry.value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(dynamic value) {
    if (value is bool) {
      return value
          ? Icon(Icons.check, color: Colors.green, size: 18)
          : Text('-', style: TextStyle(fontSize: 16, color: Colors.grey[500]));
    } else {
      return Text(
        value.toString(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      );
    }
  }
}

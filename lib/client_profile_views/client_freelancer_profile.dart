import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../client_profile_controller/client_freelancer_profile_controller.dart';
import '../client_profile_controller/client_profile_controller.dart';
import '../comms/global/global_tooltip.dart';
import '../component/client_profile/select_like_bottomsheet.dart';
import '../component/client_profile/select_profile_bottomsheet.dart';
import '../component/client_profile/work_experience_bottomsheet.dart';
import '../routes/app_routes.dart';
import '../widgets/hexagon_clipper.dart';

class ClientFreelancerProfile extends StatelessWidget{
  final ClientProfileController profileController = Get.put(ClientProfileController());
  final ClientFreelancerProfileController controller = Get.put(ClientFreelancerProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Freelancer profile'),
        actions: [
           IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
       body: Column(
         children: [
           Expanded(
             child: SingleChildScrollView(
               child: Column(children: [
                 Divider(),
                 _buildProfile(),
                 Divider(height: 40,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       _buildLargeStatItem('\$900K+', 'Total earnings'),
                       _buildLargeStatItem('891', 'Total jobs'),
                       _buildLargeStatItem('72,651', 'Total hours'),
                     ],
                   ),
                 ),
                Divider(height: 40,),
                 _buildViewProfile(),
                 Divider(height: 40,),
                 _buildWorkHistory(),
                 Divider(height: 40,),
                 _buildPortfolio(),
                 Divider(height: 40,),
                 _buildSkillSection(),
                 Divider(height: 40,),
                 _buildProjectCatalog(),
                 Divider(height: 40,),
                 _buildMeetClient(),
                 Divider(height: 40,),
                 _buildLanguages(),
                 Divider(height: 40,),
                 _buildVerifications(),
                 Divider(height: 40,),
                 _buildEmploymentHistory(),

               ],),
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Row(
               children: [
                 GestureDetector(
                   onTap: () {
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
                   },
                   child: Container(
                       padding: const EdgeInsets.all(4.0),
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       border: Border.all(width: 2, color: Get.theme.primaryColor)
                     ),
                       child: Icon(Icons.more_horiz, color: Get.theme.primaryColor,)),
                 ),
                 SizedBox(width: 16,),
                 Expanded(
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       elevation: 0,
                       backgroundColor: Get.theme.primaryColor,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
                       )
                     ),
                       onPressed: () {
                         Get.toNamed(AppRoutes.sendOfferPage);
                       },
                       child: Text('Hire', style: TextStyle(
                         color: Colors.white
                       ),)),
                 )
               ],
             ),
           )

         ],
       ),
    );
  }

  Widget _buildProfile(){
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 24, right:24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child:
                    Icon(Icons.person, size: 40, color: Colors.grey[600]),
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
              SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Rahul K.',
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
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Ballabgarh, India',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '5:36 pm local time',
                      style: TextStyle(
                          color: Colors.grey, fontSize: 16),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(28)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.electric_bolt_outlined, color: Colors.deepPurple, size: 16,),
                          SizedBox(width: 4.0,),
                          Text('Available now', style: TextStyle(
                            color: Colors.deepPurple
                          ),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(SelectLikeBottomsheet());
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Get.theme.primaryColor, width: 2),
                    shape: BoxShape.circle
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GlobalTooltip(
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
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue.shade700,)
                        ),
                        child: Icon(
                          Icons.thumb_up,
                          size: 20,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        child: Text(
                          '95% Job Success',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GlobalTooltip(
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
                      Expanded(
                        child: Text(
                          'Top Rated     Plus',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLargeStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: 22,
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
    );
  }

  Widget _buildViewProfile(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('View profile', style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500
          ),),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 8.0),
            child: Obx(() {
              return GestureDetector(
                onTap: () {
                  Get.bottomSheet(SelectWorkBottomSheet());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.selectedWork.value),
                      Icon(Icons.keyboard_arrow_down_outlined)
                    ],
                  ),
                ),
              );
            }
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'Top 1 percent Google ads, Fb Ads, Paid Ads, PPC Expert',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text('\$29.99/hr', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          ),

          Text(
            'I\'m a Senior UI/UX and Web Designer creating user-centered designs for brands like "PaySafe", "Michael\'s", and "Mayo Clinic". I\'m proficient in Interaction Design, Visual Design, and Creative Direction by using',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),

          SizedBox(height: 20,),
          Text('Book a consultation', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500
          ),),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/icon/consultation.png',
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Design Consultation', style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500
                  ),),
                ),
                Row(
                  children: [
                    Icon(Icons.videocam_outlined, color: Colors.grey,),
                    Text('\$70 per 30 min Zoom meeting', style: TextStyle(
                      fontSize: 16, color: Colors.grey
                    ),),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  width: Get.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(
                        color: Get.theme.primaryColor, width: 2
                      )),
                      backgroundColor: Get.theme.scaffoldBackgroundColor,
                    ),
                      onPressed: () {
                        Get.toNamed(AppRoutes.consultationPage);
                      }, child: Text('Book a consultation', style: TextStyle(
                    color: Get.theme.primaryColor
                  ),),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWorkHistory(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Work history', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500
              ),),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    WorkExperienceBottomsheet(),
                    backgroundColor: Colors.transparent,
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                     shape: BoxShape.circle,
                    border: Border.all(color: Get.theme.primaryColor, width: 2),
                  ),
                    child: Icon(Icons.swap_vert, color: Get.theme.primaryColor,)),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text('Graphic designer for Ads', style: TextStyle(
            color: Get.theme.primaryColor
          ),),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber,),
              Icon(Icons.star, color: Colors.amber,),
              Icon(Icons.star, color: Colors.amber,),
              Icon(Icons.star, color: Colors.amber,),
              Icon(Icons.star, color: Colors.amber,),
              Text('5.0'),
              Text('may 15,2025 - Jun 5,2025')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$150.00'),
              Text('Fixed price')
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPortfolio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
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
              children: controller.items.map((item) {
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
      ),
    );
  }


  Widget _buildLanguages(){
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Language', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
          Text('English: Native or Bilingual'),
          Text('Albanian: Native or Bilingual'),
          Text('Italian: native or Bilingual'),
          Text('French: Fluent'),
          Text('German: Fluent'),
          Text('Spanish: Fluent')
        ],
      ),
    );
  }

  Widget _buildVerifications(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Verification',style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500
          ),),
          Row(
            children: [
              Text('ID: Verified'),
              SizedBox(width: 10,),
              Icon(Icons.verified, color: Get.theme.secondaryHeaderColor,),
            ],
          ),
          SizedBox(height: 16,),
          Text('Associated with', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500
          ),),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100
                  ),
                  child: Icon(Icons.home_work_outlined, color: Colors.grey,)),
              Text('MarDesignStudio', style: TextStyle(
                  color: Get.theme.primaryColor
              ),),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEmploymentHistory(){
    return Container(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Employment history', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 24,),
          Text('Graphic Designer | Amazon.com', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text('October 2022 - Present', style: TextStyle(
              color: Colors.grey
          ),),
          SizedBox(height: 32,),
          Text('Amazon Enhanced Brand Content EBC/Amazon A+ Content for your product /...',style: TextStyle(
              color: Colors.grey
          ),),
          Text('more',style: TextStyle(
            color: Get.theme.primaryColor,decoration: TextDecoration.underline,
            decorationColor: Get.theme.primaryColor,
          ),),
          Divider(height: 40,),
          Text('Senior Graphic Design | X-AZN DESIGN COMPANY', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 12,),
          Text('January 2020 - August 2022', style: TextStyle(
              color: Colors.grey
          ),),
          SizedBox(height: 24,),
          Text('Create High-Quality Produce Images showcasing features to entice buyers....', style:
          TextStyle(
              color: Colors.grey
          ),),
          Text('more', style: TextStyle(
            color: Get.theme.primaryColor,
            decoration: TextDecoration.underline,
            decorationColor: Get.theme.primaryColor,
          ),),
          Divider(height: 40,),
          Text('Graphic Designer | AGICONS S.R.L', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 12,),
          Text('November 2018 - November 2019', style: TextStyle(
              color: Colors.grey
          ),),
          SizedBox(height: 24,),
          Text('Branding & Logo: Create a unique brand identity, design logos, and set color...', style: TextStyle(
              color: Colors.grey
          ),),
          Text('more', style: TextStyle(
            color: Get.theme.primaryColor,
            decoration: TextDecoration.underline,
            decorationColor: Get.theme.primaryColor,
          ),),
          Divider(height: 40,),
          Text('Other experiences', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 24,),
          Text('Logos, Business Card, Thank you Cards', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(
            height: 32,
          ),
          Text('My expertise is in modern, luxurious, and unique logo design using minimalst...', style: TextStyle(
              color: Colors.grey
          ),),
          Text('more', style: TextStyle(
            color: Get.theme.primaryColor,
            decoration: TextDecoration.underline,
            decorationColor: Get.theme.primaryColor,
          ),),

          Divider(height: 40,),
          Text('Education', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 20,),
          Text('Akademia e Arteve Tirane', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          Text('Master of Arts (MA), Visual Arts |'),
          Divider(height: 40,),
          Text('Akademia e Arteve Tirane', style: TextStyle(
            fontSize: 16,
          ),),
          Text('Master of Arts (MA), Fine Arts and Free Graphic | 2010-2015', style: TextStyle(
              color: Colors.grey
          ),)
        ],
      ),
    );
  }

  Widget _buildSkillSection() {
    return Obx(() {
      final skills = profileController.allSkills;
      final isExpanded = profileController.expanded.value;

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
                    onPressed: () => profileController.expanded.value = true,
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

  Widget _buildProjectCatalog(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Project catalog',style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500
          ),),
          Text('Get started working with Mar quickly with these predefined projects.'),
          SizedBox(height: 16,),
          Image.asset(
            width: Get.width,
            height: 200,
            'assets/images/architecture-interior-design.jpg',
            fit: BoxFit.cover,
          ),
           SizedBox(height: 20,),
          Text('You will get Amazon A+ Content, A+ Premium & Product Images - High-Quality Design', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.grey.shade100
                ),
                  child: Text('From \$200')),
              SizedBox(width: 20,),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.grey,),
                  SizedBox(width: 5,),
                  Text('4 days delivery', style: TextStyle(color: Colors.grey),),
                ],
              )
            ],
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              side: BorderSide(color: Get.theme.primaryColor)
            ),
              onPressed: () {
                Get.toNamed(AppRoutes.projectDetails);
              },
              child: Text('View project', style: TextStyle(color: Get.theme.primaryColor),)
          )
        ],
      ),
    );
  }

  Widget _buildMeetClient() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Meet Rahul K.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
          SizedBox(height: 16,),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: Obx(() {
              if (profileController.isVideoInitialized.value) {
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
                            width: profileController.videoPlayerController!.value.size.width,
                            height: profileController.videoPlayerController!.value.size.height,
                            child: VideoPlayer(profileController.videoPlayerController!),
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
                              onTap: profileController.toggleVideoPlayback,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  profileController.isPlaying.value
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
          SizedBox(height: 16,),
          Text('Hours per week', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 16,),
          Text('As Needed - Open to Offers', style: TextStyle(
            fontSize: 16
          ),),
          Row(
            children: [
              Text('< 24 hrs response time',style: TextStyle(
                fontSize: 16
              ),),
              GlobalTooltip(content: Text('This freelancer responds to most invitations within 24 hours.'),
              iconSize: 20, iconColor: Get.theme.primaryColor,)
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text('Open to contract to hire', style: TextStyle(
                color: Colors.grey.shade600
              ),),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Get.theme.secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(28),
                ),
                  child: Text('New', style: TextStyle(color: Get.theme.scaffoldBackgroundColor),))
            ],
          )
        ],
      ),
    );
  }
}






class SelectWorkBottomSheet extends StatelessWidget {
  final ClientFreelancerProfileController controller = Get.put(ClientFreelancerProfileController());

  final List<String> options = ['Graphic Design', 'All work'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.3,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('View profile', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600
              ),),
              IconButton(onPressed: () {
                Get.back();
              }, icon: Icon(Icons.close))
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return Obx(() => RadioListTile<String>(
                activeColor: Get.theme.primaryColor,
                value: option,
                groupValue: controller.selectedWork.value,
                title: Text(option, style: TextStyle(fontSize: 16),),
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                dense: true,
                onChanged: (value) {
                  if (value != null) {
                    controller.updateWork(value);
                  }
                },
              ));
            }).toList(),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:orbitwork/client_profile_controller/consultation_controller.dart';
import 'package:orbitwork/comms/global/global_tooltip.dart';
import 'package:orbitwork/widgets/hexagon_clipper.dart';

import '../client_profile_controller/client_profile_controller.dart';
import '../client_profile_model/consultation_project_model.dart';
import '../component/profile/share_project_bottomsheet.dart';
import '../routes/app_routes.dart';
import '../widgets/rounded_hexagon_clipper.dart';

class Consultationpage extends StatelessWidget {
  final ConsultationController controller = ConsultationController();
  final ClientProfileController profileController =
  Get.put(ClientProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultation'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marketing Consultation with Rahul K.',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '4.9',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.circle,
                    size: 4,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '189 reviews',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        ShareProjectBottomsheet(),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.share_outlined),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('Share')
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Obx(() => GestureDetector(
                    onTap: controller.toggleSave,
                    child: Row(
                      children: [
                        Icon(
                          controller.isSaved.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.isSaved.value ? Colors.green : Get.theme.secondaryHeaderColor,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Save',
                          style: TextStyle(
                            color: controller.isSaved.value ? Colors.green : Colors.black,
                            decoration: controller.isSaved.value ? TextDecoration.underline : TextDecoration.none,
                            decorationColor: controller.isSaved.value ? Get.theme.primaryColor : Colors.transparent
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                  'As an experienced digital marketing specialist, I provide expert guidance across SEO, PPC, and social media marketing. Whether you need help optimizing your per-click campaigns, or developing effective social media strategies, I\'m here to assist you.'),
              SizedBox(
                height: 24,
              ),
              Text(
                  'My expertise spans various digital marketing topics, ensuring your online presence is practical and engaging. From keyword research and on-page SEO to ad copy creation and social media content planning, I can...'),
              SizedBox(
                height: 24,
              ),
              _buildPersonalizedAdvice(),
              SizedBox(
                height: 24,
              ),
              _buildProfile(),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monetization_on_outlined,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RichText(
                      text: TextSpan(
                          style:
                          TextStyle(color: Get.theme.secondaryHeaderColor),
                          children: [
                            TextSpan(text: 'you\'re covered with '),
                            TextSpan(
                                text: 'payment protection',
                                style: TextStyle(
                                    color: Get.theme.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Get.theme.primaryColor))
                          ])),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              _buildExpectSection(),
              SizedBox(
                height: 24,
              ),
              _buildBeforeConsultation(),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Icon(
                    Icons.flag_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Report this project',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              _buildRatingInfo(),
              SizedBox(
                height: 24,
              ),
              _buildRatingBreakDown(),
              SizedBox(height: 24,),
              _buildProjectSection(),
              SizedBox(height: 24,),
              _buildPricing(),
              SizedBox(height: 24,),
              _buildPeopleViewed(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalizedAdvice() {
    return Obx(() {
      final skills = controller.personalizedAdvice;

      final maxVisible = 10;
      final showingSkills =
      skills.length > maxVisible ? skills.sublist(0, maxVisible) : skills;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get personalized advice on:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 1,
            children: [
              ...showingSkills.map((skill) =>
                  Chip(
                    label: Text(skill, style: TextStyle(fontSize: 13)),
                    backgroundColor: Colors.grey.shade200,
                    labelPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.transparent, width: 0),
                    ),
                  )),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildExpectSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What to expect',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 12,
        ),
        _buildRowData('assets/icon/bag.svg', 'Schedule the consultation',
            'Choose from the freelancer\'s available days and times.'),
        SizedBox(
          height: 24,
        ),
        _buildRowData(
          'assets/icon/custom-need.svg',
          'Get advice for your custom needs',
          'Share details about your project and what you want to talk about. The freelancer will review and reach out if they have questions.',
        ),
        SizedBox(
          height: 24,
        ),
        _buildRowData(
          'assets/icon/zoom-meeting.svg',
          'Join the Zoom meeting',
          '1-on-1 meeting with the freelancer to discuss your needs and project.',
        ),
        SizedBox(
          height: 24,
        ),
        _buildRowData(
          'assets/icon/approve-work.svg',
          'Approve the work',
          'The freelancer will finish up the documents you asked for and send them to you for approval: • Meeting summary',
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }

  Widget _buildRowData(String iconName, String title, String subTitle) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconName,
              height: 60,
              width: 60,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildBeforeConsultation() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.grey.shade50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Before the consultation',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Here\'s what Mar will need to know before you meet',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            '1. What kind of topics do you want to cover?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          )
        ],
      ),
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
                int count = controller.ratings[index];
                double percent =
                controller.totalVotes == 0 ? 0 : count / controller.totalVotes;

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

  Widget _buildPricing() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Colors.grey.shade300)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pricing',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.close))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() =>
                  _customRadioTile(
                    value: '30',
                    title: '30 minutes',
                    price: '\$50',
                    groupValue: controller.selectedDuration.value,
                    onChanged: (val) {
                      controller.selectedDuration.value = val;
                    },
                  )),
              Obx(() =>
                  _customRadioTile(
                    value: '60',
                    title: '60 minutes',
                    price: '\$100',
                    groupValue: controller.selectedDuration.value,
                    onChanged: (val) {
                      controller.selectedDuration.value = val;
                    },
                  )),
            ],
          ),

          Text(
            'Scheduling',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() =>
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Radio<String>(
                        value: 'now',
                        activeColor: Get.theme.primaryColor,
                        groupValue: controller.selectedOption.value,
                        onChanged: (value) {
                          controller.selectedOption.value = value!;
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Meet now'),
                                SizedBox(width: 8),
                                Lottie.asset(
                                  'assets/lottie/time.json',
                                  width: 30,
                                  height: 25,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade700,
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  child: Text(
                                    'BETA',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Elder is available until 7:16 PM today (GMT+5:30)',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 12),
              Obx(() =>
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Radio<String>(
                        activeColor: Get.theme.primaryColor,
                        value: 'later',
                        groupValue: controller.selectedOption.value,
                        onChanged: (value) {
                          controller.selectedOption.value = value!;
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Meet later'),
                            Text(
                              'Next available date Fri, Jun 6',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          Obx(() {
            if (controller.selectedOption.value == 'later') {
              return Padding(
                padding: EdgeInsets.all(16), // indent to align with text
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _timeOption('4:30 PM'),
                    SizedBox(height: 6),
                    _timeOption('5:00 PM'),
                    SizedBox(height: 6),
                    _timeOption('7:30 PM'),
                  ],
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          }),
          SizedBox(height: 18,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.messenger_outline),
              SizedBox(width: 8,),
              Expanded(
                  child: Text(
                      'You can share details and message Eldar after checkout.'))
            ],
          ),
          SizedBox(height: 32,),
          Row(
            children: [
              Icon(Icons.error_outline, color: Colors.amber,),
              SizedBox(width: 8,),
              Expanded(
                child: Text(
                  'Sorry,you cannot purchase projects in Project Catalog using this account.',
                  style: TextStyle(
                      fontSize: 12
                  ),),
              ),
            ],
          ),
          SizedBox(height: 24,),
          Container(
            width: Get.width,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    )
                ),
                child: Text('Continue (\$50)',
                  style: TextStyle(color: Colors.grey),
                )),
          ),
          SizedBox(height: 8,),
          Container(
            width: Get.width,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                    backgroundColor: Colors.grey.shade100
                ),
                child: Text('Message Elder', style: TextStyle(
                    color: Colors.grey
                ),)),
          )
        ],
      ),
    );
  }

  Widget _timeOption(String time) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        time,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _customRadioTile({
    required String value,
    required String title,
    required String price,
    required String groupValue,
    required ValueChanged<String> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Radio<String>(
            activeColor: Get.theme.primaryColor,
            value: value,
            groupValue: groupValue,
            onChanged: (val) => onChanged(val!),
            visualDensity: VisualDensity.compact,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: 14)),
                Text(price, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectSection() {
    return Obx(() {
      final displayedItems = controller.getDisplayedItems();
      final shouldShowMore = controller.shouldShowMoreButton();

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
                  _buildTabButton(0, controller.getTabTitle(0)),
                  const SizedBox(width: 32),
                  _buildTabButton(1, controller.getTabTitle(1)),
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
    final isSelected = controller.selectedTab.value == index;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
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
          onTap: () => controller.toggleShowMore(controller.selectedTab.value),
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
          itemCount: controller.serviceProviders.length,
          itemBuilder: (context, index) {
            return _buildServiceProviderCard(controller.serviceProviders[index]);
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
}

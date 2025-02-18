import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/profile_controller.dart';

import '../component/profile/add_education_bottomsheet.dart';
import '../component/profile/add_employment_bottomsheet.dart';
import '../component/profile/add_language_bottomsheet.dart';
import '../component/profile/add_license_bottomsheet.dart';
import '../component/profile/add_portfolio_bottomsheet.dart';
import '../component/profile/availability_badge_bottomsheet.dart';
import '../component/profile/boost_profile_bottomsheet.dart';
import '../component/profile/change_hourly_rate_bottomsheet.dart';
import '../component/profile/edit_language_bottomsheet.dart';
import '../component/profile/edit_title_bottomsheet.dart';
import '../component/profile/hours_per_week_bottomsheet.dart';
import '../component/profile/other_experience_bottomsheet.dart';
import '../component/profile/profile_overview_bottomsheet.dart';
import '../component/profile/testimonials_bottomsheet.dart';
import '../component/profile/verification_bottomsheet.dart';
import '../component/profile/video_introduction_bottomsheet.dart';
import '../controllers/profile_skill_controller.dart';
import '../routes/app_routes.dart';
import 'createProfile/skill_search_view.dart';

class ProfilePage extends StatelessWidget {
  final ProfilePageController controller = Get.put(ProfilePageController());
  final ProfileSkillController profileSkillController =
      Get.put(ProfileSkillController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person_2_outlined),
                  ),
                  Column(
                    children: [
                      Text('User Name'),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Rajkot,India'),
                        ],
                      ),
                      Text('7:11 pm local time')
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Mobile app developer',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit_outlined,
                              color: theme.primaryColor,
                              size: 16,
                            ),
                          ),
                          onPressed: () {
                            Get.bottomSheet(
                              Container(
                                  height: Get.height * 0.9,
                                  child: EditTitleBottomsheet()),
                              isScrollControlled: true,
                              ignoreSafeArea: false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.link))
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Text('\$40.00/hr'),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height * 0.9,
                            child: ChangeHourlyRateBottomsheet()),
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                          'Expertise in building cross - platform mobile applications using flutter. Proficient in flutter widget, state management ( provider, riverpod, block), and using firebase')),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height * 0.9,
                            child: PofileOverviewBottomsheet()),
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Portfolio',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height * 0.9,
                            child: AddPortfolioBottomsheet()),
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              DefaultTabController(
                length: 2,
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.32,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelPadding: EdgeInsets.symmetric(horizontal: 16),
                        tabAlignment: TabAlignment.start,
                        onTap: controller.changeTab,
                        labelColor: theme.primaryColor,
                        unselectedLabelColor: theme.unselectedWidgetColor,
                        indicatorColor: theme.primaryColor,
                        tabs: const [
                          Tab(text: 'Published'),
                          Tab(text: 'Drafts'),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/icon/briefcase.png',
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                  'Add a project. Talent are hired 9x more often if they\'ve published a portfolio.')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Work history',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                  Text('No item'),
                ],
              ),
              Divider(
                height: 24,
              ),
              Row(
                children: [
                  Text(
                    'Skills',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.to(
                        () => SkillsSearchView(),
                        binding: BindingsBuilder(() {
                          Get.put(ProfileSkillController());
                        }),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Obx(() => Wrap(
                    spacing: 4,
                    runSpacing: 2,
                    children: profileSkillController.selectedSkills
                        .map((skill) => Chip(
                              padding: const EdgeInsets.all(2),
                              backgroundColor: Colors.white,
                              label: Text(skill.name),
                              deleteIcon: const Icon(Icons.close),
                              onDeleted: () =>
                                  profileSkillController.removeSkill(skill),
                            ))
                        .toList(),
                  )),
              Divider(
                height: 24,
              ),
              Text(
                'Your project catalog',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Projects are a new way to earn on Orbitwork that helps you do more of the work you love to do.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.center,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    side: BorderSide(color: theme.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Manage projects',
                    style: TextStyle(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              Divider(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.hoverColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Promote with ads',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Availability badge',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Off',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.green,
                              size: 16,
                            ),
                          ),
                          onPressed: () {
                            Get.bottomSheet(
                              Container(
                                  height: Get.height * 0.9,
                                  child: AvailabilityBadgeBottomSheet()),
                              isScrollControlled: true,
                              ignoreSafeArea: false,
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Boost your profile',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Off',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit_outlined,
                              color: theme.primaryColor,
                              size: 16,
                            ),
                          ),
                          onPressed: () {
                            Get.bottomSheet(
                              Container(
                                  height: Get.height * 0.9,
                                  child: BoostProfileBottomsheet()),
                              isScrollControlled: true,
                              ignoreSafeArea: false,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: Get.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.hoverColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connects: 0',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.connectsHistory);
                      },
                      child: Text(
                        'View details',
                        style: TextStyle(
                            color: theme.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.primaryColor,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Video introduction',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height * 0.9,
                            child: AddVideoIntroductionSheet()),
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hours per week',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height * 0.9,
                            child: HoursPerWeekBottomsheet()),
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text('More than 30 hrs/week'),
              SizedBox(
                height: 16,
              ),
              Text(
                'No contract-to-hire preference set',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Languages',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: theme.primaryColor,
                            size: 16,
                          ),
                        ),
                        onPressed: () {
                          Get.bottomSheet(
                            Container(
                                height: Get.height * 0.9,
                                child: AddLanguageBottomSheet()),
                            isScrollControlled: true,
                            ignoreSafeArea: false,
                          );
                        },
                      ),
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit_outlined,
                            color: theme.primaryColor,
                            size: 16,
                          ),
                        ),
                        onPressed: () {
                          Get.bottomSheet(
                            Container(
                                height: Get.height * 0.9,
                                child: EditLanguagesSheet()),
                            isScrollControlled: true,
                            ignoreSafeArea: false,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text('English:'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Conversational',
                    style: TextStyle(color: theme.dividerColor),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text('Gujarati:'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Fluent',
                    style: TextStyle(color: theme.dividerColor),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text('Hindi:'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Fluent',
                    style: TextStyle(color: theme.dividerColor),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Verifications',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Military veteran'),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height * 0.9,
                            child: VerificationBottomsheet()),
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Licenses',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height * 0.9,
                            child: AddLicenseBottomsheet()),
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Education',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height,
                            child: AddEducationBottomsheet()),
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                      );
                    },
                  ),
                ],
              ),
              Text(
                'Linked accounts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.hoverColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.profileSetting);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: theme.scaffoldBackgroundColor,
                        side: BorderSide(color: theme.primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icon/github.png',
                            height: 16,
                            width: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'GitHub',
                            style: TextStyle(color: theme.primaryColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.profileSetting);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: theme.scaffoldBackgroundColor,
                        side: BorderSide(color: theme.primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icon/stackoverflow.png',
                            height: 16,
                            width: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'StackOverflow',
                            style: TextStyle(color: theme.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Testimonials',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text('Endorsements from past clients'),
                    ],
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height * 0.9,
                            child: TestimonialBottomSheet()),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/icon/find.png',
                    height: 120,
                    width: 120,
                  ),
                  Text(
                    'Showcase your skills with non-Orbitwork client testimonial',
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          Container(
                              height: Get.height * 0.9,
                              child: TestimonialBottomSheet()),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                        );
                      },
                      child: Text(
                        'Request a testimonial',
                        style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
              Divider(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Certifications',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      _selectCertificate(context);
                    },
                  ),
                ],
              ),
              Divider(
                height: 24,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/icon/trophy.png',
                    height: 120,
                    width: 120,
                  ),
                  Text(
                    'Listing your certifications can help prove your specific knowledge or abilities. (+10%)',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'You can add them manually or import them from Credly.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add manually',
                        style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Import from Credly',
                        style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
              Divider(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Employment history',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height,
                            child: AddEmploymentBottomsheet()),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/icon/briefcase.png',
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    'Add employment history to showcase your past work to clients',
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height,
                            child: AddEmploymentBottomsheet()),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                    child: Text(
                      'Add employment',
                      style: TextStyle(
                          color: theme.primaryColor, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              Divider(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Other experience',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: theme.primaryColor,
                        size: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height * 0.7,
                            child: OtherExperienceBottomsheet()),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/icon/open-folder.png',
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    'Add any other experiences that help you stand out',
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                            height: Get.height * 0.7,
                            child: OtherExperienceBottomsheet()),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                    child: Text(
                      'Add an experience',
                      style: TextStyle(
                          color: theme.primaryColor, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectCertificate(BuildContext context) {
    final theme = Theme.of(context);
    Get.bottomSheet(Container(
      height: Get.height * 0.25,
      color: theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close))
              ],
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Add manually',
                  style: TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.secondaryHeaderColor),
                )),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Import from Credly',
                  style: TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.secondaryHeaderColor),
                )),
          ],
        ),
      ),
    ));
  }
}

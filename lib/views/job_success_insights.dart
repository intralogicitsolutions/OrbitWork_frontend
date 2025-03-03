import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/widgets/feedback_card.dart';
import 'package:orbitwork/widgets/timeline_widget.dart';

import '../component/Explore_work_bottomsheet.dart';
import '../component/client_satisfaction_bottomsheet.dart';
import '../component/contract_length_bottomsheet.dart';
import '../component/higher_earnings_bottomsheet.dart';
import '../component/ineligible_jobs_bottomsheet.dart';
import '../controllers/job_success_controller.dart';

class JobSuccessInsights extends StatelessWidget {
  final JobSuccessController controller = Get.put(JobSuccessController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Job Success insights',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb navigation
              Row(
                children: [
                  Icon(Icons.home, size: 18, color: Colors.grey),
                  Text(' / ', style: TextStyle(color: Colors.grey)),
                  Text('My stats', style: TextStyle(color: Colors.grey)),
                  Text(' / ', style: TextStyle(color: Colors.grey)),
                  Text('Job Success insights',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 20),

              // Main heading
              Text(
                'Job Success insights',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16),

              // Description text
              Text(
                'Your Job Success Score is based on several factors, including clients\' overall satisfaction with your work. We calculate your score daily based on 6-, 12-, and 24-month timeframes. Your profile will display the highest score of these timeframes. A high score can help boost your visibility and win more clients.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 20),

              // Watch how it works button
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextButton.icon(
                  icon: Icon(Icons.play_circle_outline, color: Colors.green),
                  label: Text(
                    'Watch how it works',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 20),

              // Score card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    // Circular progress indicator (empty)
                    Container(
                      width: 140,
                      height: 140,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            child: CircularProgressIndicator(
                              value: 0,
                              strokeWidth: 8,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.transparent),
                            ),
                          ),
                          Text('-',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),

                    // No score text with question mark
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                              controller.score.value,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            )),
                        SizedBox(width: 8),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child:
                                Text('?', style: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Date text
                    Obx(() => Text(
                          controller.date.value,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Requirements heading
              Text(
                'Requirements and factors that impact your score',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tab headers
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //         bottom: BorderSide(color: Colors.grey.shade300)),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: GestureDetector(
                  //           onTap: () => controller.selectedTab.value = 0,
                  //           child: Obx(() => Container(
                  //                 padding: EdgeInsets.symmetric(vertical: 16),
                  //                 decoration: BoxDecoration(
                  //                   border: Border(
                  //                     bottom: BorderSide(
                  //                       color: controller.selectedTab.value == 0
                  //                           ? Colors.black
                  //                           : Colors.transparent,
                  //                       width: 3,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 child: Center(
                  //                   child: Text(
                  //                     'Score requirements',
                  //                     style: TextStyle(
                  //                       fontWeight:
                  //                           controller.selectedTab.value == 0
                  //                               ? FontWeight.w500
                  //                               : FontWeight.normal,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               )),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: GestureDetector(
                  //           onTap: () => controller.selectedTab.value = 1,
                  //           child: Obx(() => Container(
                  //                 padding: EdgeInsets.symmetric(vertical: 16),
                  //                 decoration: BoxDecoration(
                  //                   border: Border(
                  //                     bottom: BorderSide(
                  //                       color: controller.selectedTab.value == 1
                  //                           ? Colors.black
                  //                           : Colors.transparent,
                  //                       width: 3,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 child: Center(
                  //                   child: Text(
                  //                     'Client satisfaction',
                  //                     style: TextStyle(
                  //                       fontWeight:
                  //                           controller.selectedTab.value == 1
                  //                               ? FontWeight.bold
                  //                               : FontWeight.normal,
                  //                       color: controller.selectedTab.value == 1
                  //                           ? Colors.black
                  //                           : Colors.grey,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               )),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(() => Row(
                            children: List.generate(
                              controller.tabTitles.length,
                              (index) => GestureDetector(
                                onTap: () =>
                                    controller.selectedTab.value = index,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 20),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: controller.selectedTab.value ==
                                                index
                                            ? Colors.black
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    controller.tabTitles[index],
                                    style: TextStyle(
                                      fontWeight:
                                          controller.selectedTab.value == index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      color:
                                          controller.selectedTab.value == index
                                              ? Colors.black
                                              : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),

                  Obx(() {
                    switch (controller.selectedTab.value) {
                      case 0:
                        return _buildScoreRequirements();
                      case 1:
                        return _buildClientSatisfactionTab();
                      case 2:
                        return _buildLongTermRelationships();
                      case 3:
                        return _buildHigherEarningsTab();
                      case 4:
                        return _buildContractLengthTab();
                      case 5:
                        return _buildIneligibleJobs();
                      default:
                        return Container();
                    }
                  }),

                  //_showScoreRequirements(),

                  // Recent jobs section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recent jobs heading
                      Text(
                        'Recent jobs',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 16),

                      // Description text
                      Text(
                        'Only jobs within the past 24 months will impact your score. Some jobs are considered ineligible and won\'t factor into your score.',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                            height: 1.5),
                      ),
                      SizedBox(height: 20),

                      // Job tabs
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade300)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    controller.selectedJobTab.value = 0,
                                child: Obx(() => Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: controller
                                                        .selectedJobTab.value ==
                                                    0
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: 3,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Eligible jobs (${controller.eligibleJobsCount.value})',
                                        style: TextStyle(
                                          fontWeight:
                                              controller.selectedJobTab.value ==
                                                      0
                                                  ? FontWeight.w500
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    controller.selectedJobTab.value = 1,
                                child: Obx(() => Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: controller
                                                        .selectedJobTab.value ==
                                                    1
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: 3,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Ineligible jobs (${controller.ineligibleJobsCount.value})',
                                        style: TextStyle(
                                          fontWeight:
                                              controller.selectedJobTab.value ==
                                                      1
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                          color:
                                              controller.selectedJobTab.value ==
                                                      1
                                                  ? Colors.black
                                                  : Colors.grey,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // No jobs message
                      Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey.shade100,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'There are no recent jobs impacting\nyour Job Success Score.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      // Benefits section
                      SizedBox(height: 20),
                      Text(
                        'Benefits of Job Success Score',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 24),

                      // Benefits list
                      Obx(
                        () => Column(
                          children: controller.benefits
                              .map(
                                (benefit) => BenefitCard(
                                  title: benefit['title'],
                                  description: benefit['description'],
                                  icon: benefit['icon'],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24, bottom: 12),
          child: Text(
            'How do I earn a score?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),

        // Section description
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'Meeting 2 criteria to earn a Job Success Score.',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
        ),
        // First requirement card
        Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Work with 2 clients',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                          child:
                              Text('?', style: TextStyle(color: Colors.grey))),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => LinearProgressIndicator(
                            value: controller.clientProgress,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.grey.shade300),
                            minHeight: 8,
                          )),
                    ),
                    SizedBox(width: 8),
                    Obx(() => Text(
                          '${controller.clientsCount.value}/${controller.clientsRequired.value}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Center(
                        child: Icon(Icons.close,
                            size: 16, color: Colors.grey.shade400),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Not completed',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    ),
                    Spacer(),
                    Icon(Icons.person, color: Colors.grey.shade600),
                    SizedBox(width: 4),
                    Obx(() => Text(
                          '${controller.clientsCount.value} clients',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 16),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Second requirement card
        Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Complete 2 eligible jobs in 24 months',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                          child:
                              Text('?', style: TextStyle(color: Colors.grey))),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => LinearProgressIndicator(
                            value: controller.jobsProgress,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.grey.shade300),
                            minHeight: 8,
                          )),
                    ),
                    SizedBox(width: 8),
                    Obx(() => Text(
                          '${controller.jobsCount.value}/${controller.jobsRequired.value}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Center(
                        child: Icon(Icons.close,
                            size: 16, color: Colors.grey.shade400),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Not completed',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    ),
                    Spacer(),
                    Icon(Icons.work, color: Colors.grey.shade600),
                    SizedBox(width: 4),
                    Obx(() => Text(
                          '${controller.jobsCount.value} jobs',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 16),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Find jobs button
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 32),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Find jobs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClientSatisfactionTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
          child: Text(
            'Client satisfaction',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          'There are 3 components that shape client satisfaction. You must consistently receive positive feedback on these 3 components.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
                Container(
                    height: Get.height * 0.8,
                    child: ClientSatisfactionBottomsheet()),
                isScrollControlled: true,
                isDismissible: true);
          },
          child: Text(
            'Learn more',
            style: TextStyle(
              fontSize: 16,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 24),

        // Feedback cards

        FeedbackCard(
            title: 'Public feedback',
            subtitle: 'Viewable as star ratings',
            iconName: 'star',
            rating: '5.0',
            hasRating: true),

        SizedBox(height: 16),
        FeedbackCard(
            title: 'Private feedback',
            subtitle: 'Not publicly viewable',
            iconName: 'visibility_off',
            rating: '',
            hasRating: false),

        SizedBox(height: 16),
        FeedbackCard(
            title: 'Contract ending reason',
            subtitle: 'Not publicly viewable',
            iconName: 'visibility_off',
            rating: '',
            hasRating: false),

        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildHigherEarningsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
          child: Text(
            'Higher earnings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                children: [
              TextSpan(
                  text:
                      'Jobs with higher earnings have a bigger impact on your Job Success Score. This can either increase the positive impact when you meet client expectations, or amplify a negative impact when you don\'t. '),
              TextSpan(
                text: 'Learn more',
                style: TextStyle(
                    color: Get.theme.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: Get.theme.primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.bottomSheet(HigherEarningsBottomsheet(),
                        isScrollControlled: true, isDismissible: true);
                  },
              ),
            ])),

        SizedBox(height: 24),

        // Earnings scale card
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Earnings header
              Row(
                children: [
                  Icon(Icons.monetization_on_outlined,
                      size: 22, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    'Earnings',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Earnings scale visualization
              Container(
                height: 240,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Vertical line
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 2,
                        color: Colors.grey[400],
                      ),
                    ),

                    // Arrow at bottom
                    Positioned(
                      left: 9,
                      bottom: -4,
                      child: Icon(Icons.arrow_downward,
                          size: 24, color: Colors.black),
                    ),

                    // $1+ marker
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 2,
                            color: Colors.grey[400],
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$1+',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'Weighted as 1 job',
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // $251+ marker
                    Positioned(
                      left: 0,
                      top: 90,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 2,
                            color: Colors.grey[400],
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$251+',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'Weighted as 1.25 jobs',
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // $1001+ marker
                    Positioned(
                      left: 0,
                      top: 180,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 2,
                            color: Colors.grey[400],
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$1001+',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'Weighted as 1.5 jobs',
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 14),
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
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildContractLengthTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
          child: Text(
            'Contract length',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                children: [
              TextSpan(
                  text:
                      'A single contract with a payment every 90 days is considered an extra "job" toward your Job Success Score, up to a maximum of 8 jobs. '),
              TextSpan(
                text: 'Learn more',
                style: TextStyle(
                    color: Get.theme.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: Get.theme.primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.bottomSheet(
                        Container(
                            height: Get.height * 0.8,
                            child: ContractLengthBottomSheet()),
                        isScrollControlled: true,
                        isDismissible: true);
                  },
              ),
            ])),
        SizedBox(height: 24),

        // Contract length timeline card
        TimelineWidget(),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildLongTermRelationships() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
          child: Text(
            'Long-term relationships',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Get.theme.secondaryHeaderColor,
                    height: 1.5,
                    wordSpacing: 1.5),
                children: [
              TextSpan(
                  text:
                      'A relationship qualifies as long-term if a client\'s last payment is made more than 90 days after their first payment. For ongoing jobs or jobs without feedback. Long-term relationships are rewarded in the place of positive feedback left by a client. '),
              TextSpan(
                text: 'Learn more',
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: Get.theme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.bottomSheet(ExploreWorkBottomsheet(),
                        isScrollControlled: true, isDismissible: true);
                  },
              )
            ])),
        SizedBox(
          height: 12,
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon(Icons.location_on_outlined),
                      Image.asset(
                        'assets/icon/placeholder.png',
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.circle,
                        size: 10,
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '90+ days',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 2,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon(Icons.location_on_outlined),
                      Image.asset(
                        'assets/icon/placeholder.png',
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.circle,
                        size: 10,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jan 1',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Apr 1',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'For example, if a client\'s first payment was Jan 1 and their most recent payment was Apr 1 (90 days later), then all ongoing and completed jobs with that client are considered successful.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildIneligibleJobs(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
          child: Text('Ineligible jobs', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500
          ),),
        ),
        RichText(text: TextSpan(
          style: TextStyle(
            color: Colors.grey.shade700, fontSize: 16
          ),
          children: [
            TextSpan(
              text: 'Some jobs may be excluded from your Job Success Score. Conditions apply. '
            ),
            TextSpan(
              text: 'Learn more', style: TextStyle(
              color: Get.theme.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: Get.theme.primaryColor
            ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.bottomSheet(
                      Container(
                          height: Get.height * 0.8,
                          child: IneligibleJobsBottomsheet()),
                      isScrollControlled: true,
                      isDismissible: true);
                },
            ),
          ]
        )),
        SizedBox(height: 24,),
        Row(
          children: [
            Icon(Icons.attach_money),
            SizedBox(width: 10,),
            Text('Jobs with no earnings')
          ],
        ),
        SizedBox(height: 8,),
        Row(
          children: [
            Icon(Icons.folder_copy_outlined),
            SizedBox(width: 10,),
            Text('Jobs with no feedback'),
          ],
        ),
        SizedBox(height: 8,),
        Row(
          children: [
            Icon(Icons.delete_outline_sharp),
            SizedBox(width: 10,),
            Text('Jobs with feedback removed')
          ],
        ),
        SizedBox(height: 16,),
      ],
    );
  }
}

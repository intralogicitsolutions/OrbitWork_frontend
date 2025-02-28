import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                                  fontSize: 24, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tab headers
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectedTab.value = 0,
                            child: Obx(() => Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: controller.selectedTab.value == 0
                                            ? Colors.black
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Score requirements',
                                      style: TextStyle(
                                        fontWeight:
                                            controller.selectedTab.value == 0
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectedTab.value = 1,
                            child: Obx(() => Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: controller.selectedTab.value == 1
                                            ? Colors.black
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Client satisfac',
                                      style: TextStyle(
                                        fontWeight:
                                            controller.selectedTab.value == 1
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                        color: controller.selectedTab.value == 1
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Section title
                  Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 12),
                    child: Text(
                      'How do I earn a score?',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Section description
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Meeting 2 criteria to earn a Job Success Score.',
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade700),
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
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Center(
                                    child: Text('?',
                                        style: TextStyle(color: Colors.grey))),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                ),
                                child: Center(
                                  child: Icon(Icons.close,
                                      size: 16, color: Colors.grey.shade400),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Not completed',
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 16),
                              ),
                              Spacer(),
                              Icon(Icons.person, color: Colors.grey.shade600),
                              SizedBox(width: 4),
                              Obx(() => Text(
                                    '${controller.clientsCount.value} clients',
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16),
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
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
                                    child: Text('?',
                                        style: TextStyle(color: Colors.grey))),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                ),
                                child: Center(
                                  child: Icon(Icons.close,
                                      size: 16, color: Colors.grey.shade400),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Not completed',
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 16),
                              ),
                              Spacer(),
                              Icon(Icons.work, color: Colors.grey.shade600),
                              SizedBox(width: 4),
                              Obx(() => Text(
                                    '${controller.jobsCount.value} jobs',
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16),
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

                  // Recent jobs section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recent jobs heading
                      Text(
                        'Recent jobs',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
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
                                                  ? FontWeight.bold
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
                            fontSize: 24, fontWeight: FontWeight.bold),
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobSuccessController extends GetxController {
  final score = RxString('No score');
  final date = RxString('As of Feb 28, updates daily');
  final clientsCount = RxInt(0);
  final clientsRequired = RxInt(2);
  final jobsCount = RxInt(0);
  final jobsRequired = RxInt(2);

  final selectedTab = RxInt(0);

  final eligibleJobsCount = RxInt(0);
  final ineligibleJobsCount = RxInt(0);
  final selectedJobTab = RxInt(0);


  final benefits = RxList<Map<String, dynamic>>([
    {
      'title': 'Boost your visibility',
      'description': 'The Job Success Score badge is featured in search and can be used and filtered by clients to find talent faster based on',
      'icon': 'search'
    },
    {
      'title': 'Win more clients',
      'description': 'The Job Success Score proves your ability to deliver quality work, and helps increase your likelihood of winning proposals.',
      'iconType': 'handshake'
    },
    {
      'title': 'Level up your success',
      'description': 'Maintaining a high Job Success Score helps you earn badges, which unlock new benefits and help you land more work opportunities.',
      'iconType': 'level_up'
    }
  ]);

  double get clientProgress => clientsCount.value / clientsRequired.value;
  double get jobsProgress => jobsCount.value / jobsRequired.value;

  List<String> tabTitles = [
    'Score requirements',
    'Client satisfaction',
    'Long-term relationships',
    'Higher earnings',
    'Contract length',
    'Ineligible jobs',
  ];
}




// Custom widget for each benefit item
class BenefitItem extends StatelessWidget {
  final String title;
  final String description;
  final String iconType;

  const BenefitItem({
    Key? key,
    required this.title,
    required this.description,
    required this.iconType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom icon based on the type
          _buildIcon(),
          SizedBox(width: 16),

          // Benefit text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build the appropriate icon
  Widget _buildIcon() {
    switch (iconType) {
      case 'search':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.bar_chart,
                    color: Colors.grey.shade400,
                    size: 40,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      case 'handshake':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.brown.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.handshake,
                  color: Colors.brown,
                  size: 50,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.brightness_low,
                    color: Colors.green,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        );

      case 'level_up':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Icon(
              Icons.school,
              color: Colors.green.shade800,
              size: 50,
            ),
          ),
        );

      default:
        return Container(
          width: 80,
          height: 80,
          color: Colors.grey.shade200,
          child: Icon(
            Icons.star,
            color: Colors.grey.shade400,
            size: 40,
          ),
        );
    }
  }
}

// Benefits section widget
class BenefitsSection extends StatelessWidget {
  final JobSuccessController controller = Get.find<JobSuccessController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Text(
          'Benefits of Job Success Score',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 24),

        // List of benefits
        Obx(() => Column(
          children: controller.benefits.map((benefit) =>
              BenefitItem(
                title: benefit['title'],
                description: benefit['description'],
                iconType: benefit['iconType'],
              )
          ).toList(),
        )),

        // Bottom indicator line
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 16, bottom: 24),
            width: 120,
            height: 4,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}

// Jobs list tab section
class JobsTabSection extends StatelessWidget {
  final JobSuccessController controller = Get.find<JobSuccessController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Job tabs
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectedJobTab.value = 0,
                  child: Obx(() => Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: controller.selectedJobTab.value == 0
                              ? Colors.black
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      'Eligible jobs (0)',
                      style: TextStyle(
                        fontWeight: controller.selectedJobTab.value == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectedJobTab.value = 1,
                  child: Obx(() => Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: controller.selectedJobTab.value == 1
                              ? Colors.black
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      'Ineligible jobs (0)',
                      style: TextStyle(
                        fontWeight: controller.selectedJobTab.value == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: controller.selectedJobTab.value == 1
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
        SizedBox(height: 24),
      ],
    );
  }
}

// Complete page implementation
class JobSuccessPage extends StatelessWidget {
  final JobSuccessController controller = Get.put(JobSuccessController());

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
          'Job Success insights',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Jobs tabs section
                  JobsTabSection(),

                  // Benefits section
                  BenefitsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}












// Recent Jobs Section Widget
class RecentJobsSection extends StatelessWidget {
  final JobSuccessController controller = Get.find<JobSuccessController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Recent jobs heading
        Text(
          'Recent jobs',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        // Description text
        Text(
          'Only jobs within the past 24 months will impact your score. Some jobs are considered ineligible and won\'t factor into your score.',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade700, height: 1.5),
        ),
        SizedBox(height: 20),

        // Job tabs
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectedJobTab.value = 0,
                  child: Obx(() => Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: controller.selectedJobTab.value == 0
                              ? Colors.black
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      'Eligible jobs (${controller.eligibleJobsCount.value})',
                      style: TextStyle(
                        fontWeight: controller.selectedJobTab.value == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectedJobTab.value = 1,
                  child: Obx(() => Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: controller.selectedJobTab.value == 1
                              ? Colors.black
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      'Ineligible jobs (${controller.ineligibleJobsCount.value})',
                      style: TextStyle(
                        fontWeight: controller.selectedJobTab.value == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: controller.selectedJobTab.value == 1
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
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 24),

        // Benefits list
        Obx(() => Column(
          children: controller.benefits.map((benefit) =>
              BenefitCard(
                title: benefit['title'],
                description: benefit['description'],
                icon: benefit['icon'],
              )
          ).toList(),
        )),
      ],
    );
  }
}

// Benefit Card Widget
class BenefitCard extends StatelessWidget {
  final String title;
  final String description;
  final String? icon;

  const BenefitCard({
    Key? key,
    required this.title,
    required this.description,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with magnifying glass
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: icon == 'search'
                ? Stack(
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      'assets/icon/agenda.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    // If you don't have the image, use a placeholder:
                    // color: Colors.grey.shade300,
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            )
                : Icon(Icons.star, color: Colors.grey.shade400), // Default icon
          ),
          SizedBox(width: 16),

          // Benefit text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../controllers/project_list_controller.dart';


class ProjectListPage extends StatelessWidget {
  final ProjectListController controller = Get.put(ProjectListController());
   ProjectListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text('Project List | OrbitWork'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Add more options functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMainSection(),
              SizedBox(height: 24),
              _buildFixedPriceProjectSection(),
              SizedBox(height: 24),
              _buildHowItWorksSection(),
              SizedBox(height: 24),
              _buildTipsForSuccessSection(),
              SizedBox(height: 24),
              _buildMoreResourcesSection(),
              SizedBox(height: 24,),
              _buildSeeArticlesButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create and manage your services',
          style: Get.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Explore new ways to earn on Upwork. With Catalog projects, clients come to you. So you can spend more time working on the things you love.',
          style: Get.textTheme.bodyMedium,
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Add create project functionality
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: Size(double.infinity, 40),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
          ),
          child: Text(
            'Create a project',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildFixedPriceProjectSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create your first fixed-price project',
          style: Get.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Package your most popular services to attract clients. You define the scope, timeline, and price for each project upfront.',
          style: Get.textTheme.bodyMedium,
        ),
        SizedBox(height: 16),
        _buildFeatureItem(
          icon: Icons.mail_outline,
          text: 'Build a portfolio doing what you do best',
        ),
        SizedBox(height: 8),
        _buildFeatureItem(
          icon: Icons.search,
          text: 'Get discovered by clients who are looking for your unique skills',
        ),
        SizedBox(height: 8),
        _buildFeatureItem(
          icon: Icons.check_circle_outline,
          text: 'No Connects needed',
        ),
      ],
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        SizedBox(width: 12),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _buildHowItWorksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How it works',
          style: Get.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16),
        _buildHowItWorksStep(
          icon: Icons.description_outlined,
          title: 'Get an order',
          description: 'Someone purchased your project! 🎉 Take a look at the work they need done.',
        ),
        SizedBox(height: 16),
        _buildHowItWorksStep(
          icon: Icons.laptop_outlined,
          title: 'Work on the project',
          description: 'Work on the client\'s project. Send a message or schedule a meeting if you need to connect.',
        ),
        SizedBox(height: 16),
        _buildHowItWorksStep(
          icon: Icons.check_circle_outline,
          title: 'Finish up and get paid',
          description: 'Send your work to the client. You\'ll get paid when they approve and close the contract.',
        ),
      ],
    );
  }

  Widget _buildHowItWorksStep({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.green),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20

                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: Get.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTipsForSuccessSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tips for success',
          style: Get.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16),
        _buildTipsSlider(),
        SizedBox(height: 8),
        _buildSliderIndicator(),
      ],
    );
  }

  Widget _buildTipsSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 340,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          controller.currentSlide.value = index;
        },
      ),
      items: controller.tipsList.map((tip) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              color: Get.theme.scaffoldBackgroundColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      tip['image']!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tip['title']!,
                          style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500
                          )
                        ),
                        SizedBox(height: 8),
                        Text(
                          tip['description']!,
                          style: Get.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildSliderIndicator() {
    return Obx(
          () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: controller.tipsList.map((tip) {
          int index = controller.tipsList.indexOf(tip);
          return Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.currentSlide == index
                  ? Colors.green
                  : Colors.grey.shade300,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMoreResourcesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'More resources',
          style: Get.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16),
        _buildResourceItem(
          title: 'Tips for creating a project',
          subtitle: 'Project Catalog',
          onTap: () {
            // Add navigation logic
          },
        ),
        SizedBox(height: 8),
        _buildResourceItem(
          title: 'Learn how we review your projects',
          subtitle: 'Project Catalog',
          onTap: () {
            // Add navigation logic
          },
        ),
      ],
    );
  }

  Widget _buildResourceItem({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: Get.textTheme.bodyLarge,
      ),
      subtitle: Text(
        subtitle,
        style: Get.textTheme.bodyMedium?.copyWith(
          color: Colors.grey,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.green),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
    );
  }

  Widget _buildSeeArticlesButtons(){
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: Get.theme.primaryColor, width: 2),
      ),
        onPressed: () {

    }, child: Text('See all articles', style: TextStyle(
      color: Get.theme.primaryColor
    ),));
  }
}





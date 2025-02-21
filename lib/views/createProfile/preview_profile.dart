import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/preview_profile_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/profile_section.dart';
import '../my_home_page.dart';

class PreviewProfile extends GetView<PreviewProfileController> {
  final PreviewProfileController controller =
      Get.put(PreviewProfileController());

  // const PreviewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isProfile: true,
        title: 'Create Your Profile',
        rightIcon:  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Preview Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Preview Card
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icon/preview_profile.png',
                        height: 120,
                      ),
                      const SizedBox(height: 16),
                      Obx(() => Text(
                            'Looking good, ${controller.profile.value?.name.split(' ')[0] ?? 'User'}!',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      const SizedBox(height: 8),
                      const Text(
                        'Make any edits you want, then submit your profile. You can make more changes after it\'s live.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: const Size(double.infinity, 40),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Submit profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Profile Details Card
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 30,
                          child: const Icon(Icons.person_outline, size: 40),
                        ),
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.green),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit,
                                color: Colors.green, size: 16),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Obx(() => Text(
                          controller.profile.value?.name ?? 'Your Name',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 16),
                        const SizedBox(width: 4),
                        Obx(() => Text(
                              controller.profile.value?.location ??
                                  'Location',
                              style: const TextStyle(color: Colors.grey),
                            )),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '12:17 PM local time',
                      //controller.getLocalTime(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Obx(() => Text(
                              controller.profile.value?.profession ??
                                  'Profession',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.green),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit,
                                color: Colors.green, size: 16),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ProfileSection(
                      title: 'Expertise',
                      onEdit: () {},
                      child: Obx(() => Text(
                            controller.profile.value?.expertise ?? '',
                            style: const TextStyle(fontSize: 14),
                          )),
                    ),

                    // Hourly Rate Section
                    ProfileSection(
                      title: 'Hourly rate',
                      onEdit: () {},
                      child: Obx(() => Text(
                            '\$${controller.profile.value?.hourlyRate.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),

                    // Skills Section
                    ProfileSection(
                      title: 'Skills',
                      onEdit: () {},
                      child: Obx(() => Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: controller.skills
                                .map((skill) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Text(skill),
                                    ))
                                .toList(),
                          )),
                    ),

                    // Work History Section
                    ProfileSection(
                      title: 'Work history',
                      onEdit: () {

                      },
                      isAdd: true,
                      child: Obx(() => Column(
                            children: controller.workHistory
                                .map((entry) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${entry.company} | ${entry.position}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  entry.period,
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.green),
                                            onPressed: () {
                                              // TODO: Implement edit work history dialog/page
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              controller
                                                  .removeWorkHistory(entry);
                                            },
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          )),
                    ),

                    // Education Section
                    ProfileSection(
                      title: 'Education',
                      onEdit: () {
                        // TODO: Implement add education dialog/page
                      },
                      isAdd: true,
                      child: Obx(() => Column(
                            children: controller.education
                                .map((entry) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  entry.institution,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                                ),
                                                if (entry.degree != null)
                                                  Text(
                                                    entry.degree!,
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                if (entry.period != null)
                                                  Text(
                                                    entry.period!,
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.green),
                                            onPressed: () {
                                              // TODO: Implement edit education dialog/page
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              controller
                                                  .removeEducation(entry);
                                            },
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          )),
                    ),

                    // Languages Section
                    ProfileSection(
                      title: 'Languages',
                      onEdit: () {
                        // TODO: Implement add language dialog/page
                      },
                      child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: controller.languages
                                .map((language) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  language.language,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  language.proficiencyLevel,
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.green),
                                            onPressed: () {
                                              // TODO: Implement edit language dialog/page
                                            },
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          )),
                    ),

                    // Submit Profile Button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () {
                         Get.offNamed(AppRoutes.homeScreen);
                         //  Get.offAll(MyHomePage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Submit profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

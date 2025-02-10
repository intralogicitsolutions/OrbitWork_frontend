// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class PreviewProfile extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create your Profile'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Preview Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
//               SizedBox(height: 16,),
//               Container(
//                 color: Colors.grey[100],
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: Image.asset('assets/icon/preview_profile.png',
//                             width: 100, height: 100),
//                       ),
//                       SizedBox(height: 16,),
//                       Text('Looking good, User name!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
//                       SizedBox(height: 16,),
//                       Text('Make any edits you want, then submit your profile. You can make more changes after it\'s live',
//                       style: TextStyle(fontSize: 16),
//                       ),
//                       SizedBox(height: 16,),
//                       ElevatedButton(
//                         onPressed:() {
//
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 50,
//                             vertical: 10,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           'Submit Profile',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 12,),
//               Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundColor: Colors.grey[200],
//                       child:  Icon(Icons.person, size: 30, color: Colors.grey),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text('User Name',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
//                     SizedBox(height: 5,),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on_outlined),
//                         SizedBox(width: 5,),
//                         Text('Rajkot, GJ'),
//                       ],
//                     ),
//                     SizedBox(height: 5,),
//                     Text('12:17 PM local time'),
//                     SizedBox(height: 16,),
//                     Text('Mobile app developer', style: TextStyle(fontSize: 20),)
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/app/views/profile_preview_view.dart
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
                // App Bar
                // Row(
                //   children: [
                //     CircleAvatar(
                //       backgroundColor: Colors.grey[300],
                //       child:
                //           const Icon(Icons.person_outline, color: Colors.grey),
                //     ),
                //     const SizedBox(width: 12),
                //     const Text(
                //       'Create Your Profile',
                //       style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     const Spacer(),
                //     IconButton(
                //       icon: const Icon(Icons.more_vert),
                //       onPressed: () {},
                //     ),
                //   ],
                // ),


                const SizedBox(height: 24),
                const Text(
                  'Preview Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
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
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
                              style: const TextStyle(fontSize: 16),
                            )),
                      ),

                      // Hourly Rate Section
                      ProfileSection(
                        title: 'Hourly rate',
                        onEdit: () {},
                        child: Obx(() => Text(
                              '\$${controller.profile.value?.hourlyRate.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
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
                          // TODO: Implement add work history dialog/page
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
                                                          FontWeight.bold,
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
                                                          FontWeight.bold,
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
                                                          FontWeight.bold,
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
                            minimumSize: const Size(double.infinity, 56),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

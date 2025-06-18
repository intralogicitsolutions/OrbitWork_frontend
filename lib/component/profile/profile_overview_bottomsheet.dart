import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/profile/profile_overview_controller.dart';

import '../../comms/url_launcher_helper.dart';

class PofileOverviewBottomsheet extends StatelessWidget {
  final ProfileOverviewController controller = Get.put(ProfileOverviewController());
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: theme.scaffoldBackgroundColor,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.close)),
                            Text(
                              'Profile overview',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                            'Use this space to show clients you have the skills and experience they\'re looking for.'),
                        SizedBox(
                          height: 16,
                        ),
                        customRow(
                            icon: Icons.circle,
                            title: "Describe your strengths and skills"),
                        customRow(
                            icon: Icons.circle,
                            title: "Highlight projects, accomplishments and education"),
                        customRow(
                            icon: Icons.circle,
                            title: "Keep it short and make sure it\'s error-free"),
                        SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () => UrlLauncherHelper.openUrl('https://www.google.com'),
                          child: Text(
                            'Learn more about building your profile',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: theme.primaryColor),
                          ),
                        ),
                        SizedBox(height: 24,),
                        Text('Profile overview'),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: textController,
                          maxLines: 6,
                          maxLength: controller.maxCharacters,
                          keyboardType: TextInputType.multiline,
                          scrollPhysics: BouncingScrollPhysics(),
                          onChanged: controller.updateCharacterCount,
                          decoration: InputDecoration(
                            border: OutlineInputBorder( // Adds border
                              borderRadius: BorderRadius.circular(8),
                            ),hintText: 'Example: I have been a very successful mobile developer for over 7 years, working for individuals all over the world. \n since I have started ios and Android app development, I have been spending every spare minute writing code for the iPhone, and learning everything on mobile application development. Additionally to development of new apps, a lot of the work I do is on-going maintenance of existing popular apps. \n I always aim to maintain a long term relationship with my clients. Whether you\'ve lost your original developer, need additional resources, or want a brand new app, I can step in and take over wherever you need. Thanks!',
                            hintStyle: TextStyle(color: Colors.grey,  fontSize: 12),
                            counterText: "",
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          ),
                        ),
                        SizedBox(height: 8),
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${controller.remainingCharacters.value} characters left',
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        )),

                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customRow({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 8),
          SizedBox(width: 8), // Add some space between icon and text
          Expanded(
            child: Text(
              title,
              style:
                  TextStyle(fontSize: 14), // You can adjust the text style here
            ),
          ),
        ],
      ),
    );
  }
}

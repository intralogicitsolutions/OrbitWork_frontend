import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/freelancer_profile_controller.dart';

import '../../routes/app_routes.dart';

class WriteAnOverview extends StatelessWidget {
  final FreelancerProfileController controller = Get.put(FreelancerProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Great. Now write a bio to tell the world about yourself',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Help people get to know you at a glance. What work do you do best? Tell them clearly, using paragraphs or bullet points. You can always edit later, just make sure you proofread now.',
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                    SizedBox(height: 24,),
                    TextField(
                      controller: controller.bioController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        hintText: 'Enter your top skills, experiences, and interests. This is one of the first things clients will see on your profile.',
                        hintStyle: TextStyle(fontSize: 12, color: Colors.black54)
                      ),
                      maxLines: 6,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                        child: Text('At least 100 characters'))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

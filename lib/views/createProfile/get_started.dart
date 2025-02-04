import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/drawer_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_appbar.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(Drawercontroller());
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        isProfile: true,
        title: "Create Your Profile",
        rightIcon: IconButton(
          icon: Icon(
            Icons.more_vert_rounded,
            color: theme.hintColor,
          ),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hey Abc. Ready for your next big opportunity?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            _createInformationList(Icons.person_2_outlined,
                'Answer a few questions and start building your profile'),
            _createInformationList(Icons.mark_email_read_outlined,
                'Apply for open roles or list services for clients to buy'),
            _createInformationList(Icons.paid_outlined,
                'Get paid safely and know we\'re there to help'),
            Text(
              'It only takes 5-10 minutes and you can edit it later. We\'ll save as you go.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: theme.dividerColor),
            ),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () =>   Get.toNamed(AppRoutes.profileSetupContainer),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Get started", style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createInformationList(IconData icon, String information) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(
                width: 25,
              ),
              Expanded(
                  child: Text(
                information,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              )),
            ],
          ),
          Divider(
            height: 48,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}

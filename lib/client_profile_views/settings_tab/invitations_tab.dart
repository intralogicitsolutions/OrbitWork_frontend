import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvitationsTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pending invites', style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500
                  ),
                  ),
                  SizedBox(height: 32,),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/icon/target.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 32,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text('You have no pending invitations yet', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 32,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Get started by invited someone to join you.', style: TextStyle(
                      fontSize: 16
                    ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              width: Get.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Get.theme.primaryColor,
                ),
                  onPressed: () {},
                  child: Text('Invite Members', style: TextStyle(
                    color: Colors.white
                  ),),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
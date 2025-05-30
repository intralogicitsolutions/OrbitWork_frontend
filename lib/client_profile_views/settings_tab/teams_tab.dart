import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TeamsTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Teams', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/team.svg',
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(height: 20,),
                  Text('Create your first team', style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 20,),
                  Text('Invite teammates to streamline hiring, manage contracts, and collaborate in one place.',
                    style: TextStyle(
                      color: Colors.grey
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                        backgroundColor: Get.theme.primaryColor
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.white,),
                          SizedBox(width: 8,),
                          Text('Create a team',
                            style: TextStyle(
                              color: Colors.white
                          ),),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
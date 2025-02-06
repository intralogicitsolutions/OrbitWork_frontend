import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviewProfile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create your Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Preview Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
              SizedBox(height: 16,),
              Container(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset('assets/icon/preview_profile.png',
                            width: 100, height: 100),
                      ),
                      SizedBox(height: 16,),
                      Text('Looking good, User name!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      SizedBox(height: 16,),
                      Text('Make any edits you want, then submit your profile. You can make more changes after it\'s live',
                      style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16,),
                      ElevatedButton(
                        onPressed:() {

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Submit Profile',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[200],
                      child:  Icon(Icons.person, size: 30, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('User Name',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 5,),
                        Text('Rajkot, GJ'),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text('12:17 PM local time'),
                    SizedBox(height: 16,),
                    Text('Mobile app developer', style: TextStyle(fontSize: 20),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
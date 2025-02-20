import 'package:flutter/material.dart';

class MyTeamsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My teams',style: TextStyle(
              fontSize: 18, fontWeight:FontWeight.w500
            ),),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My teams', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 16,),
                    Text('Teams are used to group contract by department or manager',style: TextStyle(
                       fontSize: 16, fontWeight: FontWeight.w400
                    ),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(height: 32,),
                        Text('Team name', style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14
                        ),),
                        Divider(height: 32,),
                        Text('LIBERI ZELAMULA', style: TextStyle(
                          fontSize: 16,
                        ),),
                        Text('On Contract'),
                        Divider(height: 32,),
                        Text('CoFoundersLab', style: TextStyle(
                          fontSize: 16
                        ),),
                        Text('On Contract'),
                        Divider(height: 32,),
                        Text('Jaya Negi', style: TextStyle(
                          fontSize: 16
                        ),),
                        Text('On Contract'),
                        Divider(height: 32,)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person_2_outlined),
                ),
                Column(
                  children: [
                    Text('User Name'),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 5,),
                        Text('Rajkot,India'),
                      ],
                    ),
                    Text('7:11 pm local time')
                  ],
                ),
              ],
            ),
            SizedBox(height: 24,),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text('Mobile app developer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                      IconButton(onPressed: () {

                      }, icon: Icon(Icons.edit_outlined))
                    ],
                  ),
                ),
                IconButton(onPressed: () {

                }, icon: Icon(Icons.link))
              ],
            ),
            SizedBox(height: 24,),
            Row(
              children: [
                Text('\$40.00/hr'),
                IconButton(onPressed: () {

                }, icon: Icon(Icons.edit_outlined))
              ],
            ),
            SizedBox(height: 24,),
            Row(
              children: [
                Expanded(
                    child: Text('Expertise in building cross - platform mobile applications using flutter. Proficient in flutter widget, state management ( provider, riverpod, block), and using firebase')),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined, color: Colors.green,))
              ],
            ),
            SizedBox(height: 24,),
            Row(
              children: [
                Text('Portfolio', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                IconButton(onPressed: () {

                }, icon: Icon(Icons.add, color: Colors.green,))
              ],
            ),
          ],
        ),
      ),
    );
  }

}
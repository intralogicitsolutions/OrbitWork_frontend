import 'package:flutter/material.dart';

class MyStatePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My stats'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My stats', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
            SizedBox(height: 12),
            Text('View proposal history, earnings, profile analytics, and your Job Success Score.',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 12),
            Text('Stats are not updated in real-time and may take up to 24 hours to reflect recent activity.',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateClientAccount extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a client account'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Create a client account'),
            SizedBox(height: 20,),
            Column(
              children: [
                _buildBillingMethodWarning(context),
                Text('Setup a client account if you want to post jobs and hire talents.'),
                SizedBox(height: 12,),
                Text('Company Name'),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Get.theme.hintColor
                  ),
                ),
                SizedBox(height: 24,),
                Text('Your company name will NOT appear on job posts unless you have previously worked with the talent or agency on Orbitwork.')
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBillingMethodWarning(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 242, 242),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber, size: 20, color: Colors.red.shade900,),
          SizedBox(width: 10,),
          RichText(text: TextSpan(
            style: TextStyle(color: Colors.red.shade900),
            children: [
              TextSpan(
                text: 'You must set up your '
              ),
              TextSpan(
                text: 'billing method',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red.shade900
                ),
              ),
              TextSpan(
                text: ' before you can create a new clint account.'
              )
            ]
          ))
        ],
      ),
    );
  }

}
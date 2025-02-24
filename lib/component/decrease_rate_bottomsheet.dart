import 'package:flutter/material.dart';

class DecreaseRateBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                Expanded(
                  child: Text('Decrease rate', style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500
                  ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextfield(String title){
    return Column(
      children: [
        Text(title, style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500
        ),)
      ],
    );
  }
}
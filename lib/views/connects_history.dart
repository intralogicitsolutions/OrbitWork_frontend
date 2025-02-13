import 'package:flutter/material.dart';

class ConnectsHistory extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connects history', style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500
        ),),
      ),
      body: Column(
        children: [
          Text('Connects History', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 242, 242),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,  // Aligns content to the center vertically
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('⚠'),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "In compliance with Tax Law in India, Orbitwork withholds 0.1% Tax at Deduction Source (TDS) from your payments. The TDS can be as much as 5% if you haven\'t provided your govt. issued tax id yet. Please click here to add your PAN asap. For more details, read our fAQs.",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      style: TextStyle(color: Colors.red.shade900),
                    ),
                  ),
                  IconButton(onPressed: () {

                  }, icon: Icon(Icons.close, color: Colors.red.shade900,))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
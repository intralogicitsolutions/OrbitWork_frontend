import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShareLocation extends StatefulWidget{
  @override
  State<ShareLocation> createState() => _ShareLocationState();
}

class _ShareLocationState extends State<ShareLocation> {
  @override
  Widget build(BuildContext context) {
    String? latitude;
    String? longitude;
    return Scaffold(
      appBar: AppBar(title: Text('Share Location with current latitude and longitude'),),
      body: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Positioned(
                  left: 2,
                  right: 2,
                  top: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                Text('share location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),),
                Container(
                  child: Text('$latitude $longitude', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),

                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
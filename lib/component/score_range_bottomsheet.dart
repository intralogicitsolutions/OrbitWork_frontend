import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreRangeBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('How score ranges are defined', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                        IconButton(onPressed: () {
                          Get.back();
                        }, icon: Icon(Icons.close),),
                      ],
                    ),
                    SizedBox(height: 24,),
                    Text('Excellent: 90% or higher', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    Text('The score reflects a consistent history of meeting or surpassing client expectations. This puts you on track for Top Rated or Top Rated Plus status.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                    SizedBox(height: 24,),
                    Text('Good: 80% to 89%', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    Text('You\'ve delivered reliable work, but clients believe there\'s room for improvement.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                    SizedBox(height: 24,),
                    Text('Need improvement: 79% or below', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    Text('The score suggests challenges in fulfilling client expectations. You may find it more difficult to secure new clients or job opportunities.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                    SizedBox(height: 24,),
                    Text('No score', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    Text('You need more work to establish a Job Success Score or your number of eligible jobs has dropped below 2.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: Get.width,
              child: ElevatedButton(onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.green,
                    minimumSize: const Size(40, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Close', style: TextStyle(color: Colors.white),)),
            ),
          )
        ],
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HigherEarningsBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.65,
      decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Higher earnings', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500
                  ),),
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.close)),
                ],
              ),
            ),
            Text('Jobs with higher earnings have a bigger impact on your Job Success Score. This can either increase the positive impact when you meet client expectations, or amplify a negative impact when you don\'t.',
            style: TextStyle(
              fontSize: 16, color: Colors.grey[600]
            ),
            ),
            SizedBox(height: 24,),
            _createText('Jobs with earnings between \$1-\$250 are weighted as 1 job.'),
            SizedBox(height: 12,),
            _createText('Jobs with earnings between \$251 and \$1,000 are weighted as 1.25 jobs.'),
            SizedBox(height: 12,),
            _createText('Jobs with earnings of more than \$1,000 are weighted as 1.5 jobs.'),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.green,
                  minimumSize: Size(Get.width, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Close', style: TextStyle(
                    color: Colors.white
                ),)),
          ],
        ),
      ),
    );
  }

  Widget _createText(String text){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Icon(Icons.circle, size: 8, color: Colors.grey[600],),
        ),
        SizedBox(width: 5.0,),
        Expanded(child: Text(text, style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600]
        ),))
      ],
    );
  }
}
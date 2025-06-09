import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientFeedbackBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jan 25,2025 - Mar 18,2025'),
                    SizedBox(height: 16,),
                    Container(
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('112 hours'),
                          SizedBox(height: 16,),
                          Text('\$5.00 /hr'),
                          SizedBox(height: 16,),
                          Text('\$560.83 earned')
                        ],
                      ),
                    ),
                    SizedBox(height: 24,),
                    Text('Job feedback', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500
                    ),),
                    Divider(),
                    Text('Client\'s feedback', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 16,),
                   _buildFeedbackIcon('4.4'),
                    Text('"It was a good experience overall, however our corrections and feedback about our company name were not implemented. It\'d be important to agree on a system to revisit citations / make corrections. We were also listed on some irrelevant sites like a directory of athletes, and a website about Korean TV shows. Irrelevant citations don\'t bring good SEO results, so they should have been avoided."',
                    style: TextStyle(
                      fontSize: 16
                    ),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Overall rating', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                        Text('4.4', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
                      ],
                    ),
                    Divider(),
                    _buildOverallRating('Skills', 5.0),
                    _buildOverallRating('Quality', 4.0),
                    _buildOverallRating('Availability', 4.0),
                    _buildOverallRating('deadlines', 5.0),
                    _buildOverallRating('Communication', 4.0),
                    _buildOverallRating('Cooperation', 4.0),

                    SizedBox(height: 24,),
                    Text('Freelancer\'s feedback to the client', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    SizedBox(height: 16,),
                    _buildFeedbackIcon('4.1'),
                    SizedBox(height: 16,),
                    Text('"Thank you"'),
                    SizedBox(height: 20,),
                    Text('Job details', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500
                    ),),
                    Divider(),
                    Text('This job is private')
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            width: Get.width,
            child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Get.theme.primaryColor
                ),
                child: Text('Close', style: TextStyle(
                  color: Colors.white
                ),)
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOverallRating(String text, double rate) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(fontSize: 12, color: Colors.grey),),
            Text('$rate', style: TextStyle(fontSize: 12),)
          ],
        ),
        SizedBox(height: 16,),
      ],
    );
  }

  Widget _buildFeedbackIcon(String text){
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 12,),
        Icon(Icons.star, color: Colors.amber, size: 12,),
        Icon(Icons.star, color: Colors.amber, size: 12,),
        Icon(Icons.star, color: Colors.amber, size: 12,),
        Icon(Icons.star, color: Colors.amber, size: 12,),
        SizedBox(width: 8.0,),
        Text(text),
      ],
    );
  }
}
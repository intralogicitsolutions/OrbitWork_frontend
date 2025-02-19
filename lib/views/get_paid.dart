import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/get_paid_controller.dart';

class GetPaidPage extends StatelessWidget{
  final GetPaidController controller = Get.put(GetPaidController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
       appBar: AppBar(
         title: Row(
           children: [
             Text('Get Paid', style: TextStyle(
               fontWeight: FontWeight.w500,
               fontSize: 20
             ),),
             IconButton(onPressed: () {

             }, icon: Icon(Icons.more_vert_rounded)),
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
            border: Border.all(color: Colors.grey)
        ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Available balance'),
                  Text('\$${controller.price}', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500, color: theme.primaryColor
                  ),),
                  Row(
                    children: [
                      Text('+\$${controller.pending} pending',style: TextStyle(fontSize: 12, color: Colors.grey),),
                      Icon(Icons.info_outline, size: 12, color: Colors.grey,)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.yellow[100],
                    ),

                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline,color: Colors.brown[400], ),
                       SizedBox(width: 10,),
                       Expanded(
                         child: RichText(text: TextSpan(
                           children: [
                             TextSpan(
                               text: 'To withdraw earnings, please update your ',
                               style: TextStyle(color: Colors.brown[400])
                             ),
                             TextSpan(
                               text: 'tax information. ', style: TextStyle(
                               decoration: TextDecoration.underline,color: Colors.brown[400]
                             ),
                             ),
                             TextSpan(text: 'For more details, read our ', style: TextStyle(color: Colors.brown[400])),
                             TextSpan(text: 'FAQs.', style: TextStyle(
                               decoration: TextDecoration.underline, color: Colors.brown[400]
                             ))
                           ]
                         )),
                       )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
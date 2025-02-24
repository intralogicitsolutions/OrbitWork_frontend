import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/buy_connects_controller.dart';

class NumberOfConnectsBottomsheet extends StatelessWidget{
  final BuyConnectsController controller = Get.put(BuyConnectsController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor
      ),
     child: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
         children: [
           Row(
             children: [
               Expanded(
                 child: Text('Select number of Connects', style: TextStyle(
                   fontSize: 24, fontWeight: FontWeight.w500
                 ),),
               ),
               IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)),
             ],
           ),
           SizedBox(height: 24,),
           _buildRadioOption('100 for \$15.00'),
           _buildRadioOption('150 for \$22.50'),
           _buildRadioOption('200 for \$30.00'),
           _buildRadioOption('250 for \$37.50'),
           _buildRadioOption('300 for \$45.00'),
         ],
       ),
     ),
    );
  }

  Widget _buildRadioOption(String text) {
    return Obx(() => RadioListTile<String>(
      title: Text(text),
      value: text,
      groupValue: controller.selectConnects.value,
      onChanged: (value) => controller.setNUmberOfConnects(value ?? ''),
      contentPadding: EdgeInsets.zero,
      activeColor: Colors.green,
    ));
  }

}
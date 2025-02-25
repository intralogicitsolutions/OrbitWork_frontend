import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DecreaseRateBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor
      ),
      child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.close)),
                          Text('Decrease rate', style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500
                          ),),
                          const SizedBox(width: 40),
                        ],
                      ),
                      _buildTextfield('Hourly rate', '\$0.00', subTitle: 'Total amount the client will see'),
                      _buildTextfield('10% Orbitwork service fee', '\$0.00', subTitle: ''),
                      _buildTextfield('You\'ll receive', '\$0.00', subTitle: 'The estimated amount you\'ll receive after service fees')
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
    );

  }

  Widget _buildTextfield(String title, String suffixText,{
    String? subTitle
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500
        ),),
        subTitle != '' ? Text(subTitle??'', style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400,color: Colors.grey
        ),): SizedBox.shrink(),
        SizedBox(height: 12,),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    suffixText: suffixText,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Text('/hr')
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBottomButtons(){
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
       // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10,),
                side: BorderSide(color: Colors.green, width: 2),
                foregroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
           Expanded(
             child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.grey[100],
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:  Text(
                'Save new rate',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
                       ),
           ),
        ],
      ),
    );
  }
}
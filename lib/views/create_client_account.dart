import 'package:flutter/material.dart';

class CreateClientAccount extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a client account', style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500
        ),),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
           children: [
             Container(
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),
                   border: Border.all(color: Colors.grey.shade400)),
               padding: const EdgeInsets.all(16.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('Create a client account', style: TextStyle(
                     fontSize: 20, fontWeight: FontWeight.w500
                   ),),
                   SizedBox(height: 24,),
                   Text('Setup a client account if you want to post jobs and hire talents.'),
                   SizedBox(height: 12,),
                   Text('Company Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                   SizedBox(height: 10,),
                   Container(
                     height: 40,
                     child: TextField(
                       decoration: InputDecoration(
                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                         contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                       ),
                     ),
                   ),
                   SizedBox(height: 30,),
                   Text('Your company name will NOT appear on job posts unless you have previously worked with the talent or agency on OrbitWork.'),
                   SizedBox(height: 24,),
                   Row(
                     children: [
                       OutlinedButton(onPressed: () {},
                           style: OutlinedButton.styleFrom(
                             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                             side: BorderSide.none,
                           ),
                           child: Text('Cancel',style: TextStyle(
                             color: theme.primaryColor
                           ),)),
                       ElevatedButton(onPressed: () {},
                           style: ElevatedButton.styleFrom(
                               elevation: 0,
                               backgroundColor: theme.primaryColor,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(8)
                               )
                           ),
                           child: Text('Create Client Account', style: TextStyle(
                             color: Colors.white
                           ),))
                     ],
                   )
                 ],
               ),
             ),
           ],
        ),
      ),
    );
  }
}
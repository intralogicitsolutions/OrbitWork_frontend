import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ViewAllContracts extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contracts'),
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Text('All contracts', style: TextStyle(fontSize: 20),),
            SizedBox(height: 24,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(16),
                    //   border: Border.all(width: 1, color: Get.theme.secondaryHeaderColor)
                    // ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search all contracts',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Get.theme.hintColor
                        ),
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                IconButton(onPressed: () {}, icon: Icon(Icons.filter_list))
              ],
            ),
            SizedBox(height: 24,),
            SvgPicture.asset(
              'assets/icon/contracts.svg',
              height: 80,
              width: 80,
              // color: Colors.green, // Optional
            ),
            SizedBox(height: 12,),
            Text('You don\'t have any contracts yet.',  style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500
            ),),
            Text('Your pending and active contracts will be available here when you start hiring talent.'),
            RichText(text: TextSpan(
              style: TextStyle(
                fontSize: 14, color: Get.theme.secondaryHeaderColor, height: 1.5
              ),
              children: [
                TextSpan(
                  text: 'Post a job',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Get.theme.primaryColor,
                    color: Get.theme.primaryColor
                  ),
                ),
                TextSpan(
                  text: 'or'
                ),
                TextSpan(
                  text: 'check out who\'s applied',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Get.theme.primaryColor,
                    color: Get.theme.primaryColor
                  )
                ),
                TextSpan(
                  text: 'to your existing job posts.'
                )
              ]
            ))
          ],
        ),
      ),
    );
  }

}
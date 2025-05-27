import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ViewAllJobPost extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job posting'),
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Text('All job posts'),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: Get.theme.secondaryHeaderColor)
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search job postings',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14
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
              'assets/icon/search-job.svg',
              height: 80,
              width: 80,
              // color: Colors.green, // Optional
            ),
            SizedBox(height: 12,),
            Text('There are no result that match your search.', style: TextStyle( fontSize: 16, color: Get.theme.hintColor),),
            SizedBox(height: 12,),
            Text('Please try adjusting your search keywords or filters.')

          ],
        ),
      ),
    );
  }
}
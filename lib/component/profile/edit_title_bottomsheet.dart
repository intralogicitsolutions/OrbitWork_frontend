import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTitleBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.close)),
                      Text('Edit your title',style: TextStyle( fontSize: 18, fontWeight: FontWeight.w500),),
                      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
                    ],
                  ),
                  SizedBox(height: 16,),
                  Text('Enter a single sentence description of your professional skills/experience (e.g. Expert Web Designer with Ajax experience)'),
                  SizedBox(height: 24,),
                  Text('Your title', style: TextStyle(
                    fontSize: 16,fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 5,),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Mobile app developer',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8), ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
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
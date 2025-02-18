import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherExperienceBottomsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Add other experiences',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                        ),
                        IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)),
                      ],
                    ),
                    SizedBox(
                     height: 24,
                    ),
                    Text('Subject', style: TextStyle(fontSize: 16),),
                     SizedBox(height: 5,),
                     Container(
                       height: 40,
                       child: TextField(
                         decoration: InputDecoration(
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(8)
                           ),
                           hintText: 'Enter subject',
                           hintStyle: TextStyle(
                             fontSize: 14,
                             color: Colors.grey
                           ),
                         ),
                       ),
                     ),
                    SizedBox(
                      height: 24,
                    ),
                    Text('Description', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 5,),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                       hintText: 'Enter description',
                       hintStyle: TextStyle(
                         fontSize: 14,
                         color: Colors.grey
                       )
                      ),
                      maxLines: 8,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom + 16,
                left: 16,
                right: 16
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
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
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                    ),
                    child: const Text('Save'),
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

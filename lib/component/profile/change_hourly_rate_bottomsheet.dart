import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeHourlyRateBottomsheet extends StatelessWidget{
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.close)),
                      Text('Change hourly rate', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text('Please note that your new hourly rate will only apply to new contracts.',),
                  SizedBox(height: 24,),
                  Text('Your profile rate: \$40.00/hr'),
                  SizedBox(height: 24,),
                  Text('Hourly Rate',style: TextStyle(
                    fontSize: 18,
                  ),),
                  Text('Total amount the client will see', style: TextStyle(fontSize: 12),),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Align row content to the end
                    children: [
                      Flexible( // Wrap with Flexible to avoid overflow issues
                        child: SizedBox(
                          height: 40,
                          width: 150, // Adjust width if needed
                          child: TextField(
                            textAlign: TextAlign.right, // Align text inside the TextField
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: '\$40.00',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('/hr'),
                      ),
                    ],
                  ),
                  Divider(height: 24,),
                  Text('10% Orbitwork Service Fee', style: TextStyle(
                    fontSize: 18
                  ),),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: 40,
                          width: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300], // Background color
                              borderRadius: BorderRadius.circular(8), // Rounded corners
                            ),
                            child: TextField(
                              readOnly: true,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                border: InputBorder.none,
                                hintText: '\$4.00-',
                                hintStyle: TextStyle(color: Colors.grey,),
                                  hintTextDirection: TextDirection.rtl
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('/hr'),
                      ),
                    ],
                  ),
                  Divider(height: 24,),
                  Text('You\'ll Receive', style: TextStyle(
                    fontSize: 18
                  ),),
                  Text('The estimated amount you\'ll receive after service fees ?', style: TextStyle(fontSize: 12),),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Align row content to the end
                    children: [
                      Flexible( // Wrap with Flexible to avoid overflow issues
                        child: SizedBox(
                          height: 40,
                          width: 150, // Adjust width if needed
                          child: TextField(
                            textAlign: TextAlign.right, // Align text inside the TextField
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: '\$40.00',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('/hr'),
                      ),
                    ],
                  ),

                ],
              ),
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
    );
  }
}
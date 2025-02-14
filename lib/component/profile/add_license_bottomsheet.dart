import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLicenseBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
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
                      children: [
                        IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.close)),
                        Text('Add a license', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500
                        ),),
                        const Spacer(),
                        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
                      ],
                    ),
                    RichText(text: TextSpan(
                      children: [
                        TextSpan(text: 'Licenses are documents issued by government authorities or professional entities in certain fields. Examples include Attorney at Law, Licensed Physician, Registered Nurse, etc. Adding a license to your profile helps build trust and credibility with clients on Orbitwork. you can also add non-government issued certifications elsewhere in your profile.',
                        style: TextStyle(color: Colors.black, fontSize: 16)
                        ),
                        TextSpan(text: ' Learn more about adding professional licenses', style: TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                          fontSize: 16
                        ),),
                      ],
                    ),),
                    SizedBox(height: 16,),
                    Text('Licensed profession', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'e.g. Attorney at Law',
                        hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text('Jurisdiction or Licensing body', style: TextStyle(
                      fontSize: 16
                    ),),
                    SizedBox(height: 12,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'e.g. California Bar Association',
                        hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text('License number', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter license number',
                        hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text('Licensing verification URL', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter URL where license can be verified',
                        hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text('Date issued', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Mmm d, yyyy',
                        hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text('Expiration date', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Mmm d, yyyy',
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey)
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text('My license does not have an expiration date'),
                    SizedBox(height: 24,),
                    Text('Indicates required field', style: TextStyle(color: Colors.grey, fontSize: 12),),

                    // Padding(
                    //   padding: EdgeInsets.only(
                    //     bottom: MediaQuery.of(context).viewPadding.bottom + 16,
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: TextButton(
                    //           onPressed: () => Get.back(),
                    //           child: const Text(
                    //             'Cancel',
                    //             style: TextStyle(
                    //               color: Colors.green,
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(width: 16),
                    //       Expanded(
                    //         child: Obx(() {
                    //           // final bool isEnabled = controller.selectedLanguage.isNotEmpty &&
                    //           //     controller.selectedProficiency.isNotEmpty;
                    //           return ElevatedButton(
                    //             onPressed: () {},
                    //             // onPressed: isEnabled ? () {
                    //             //   // Handle save action
                    //             //   Get.back();
                    //             // } : null,
                    //             style: ElevatedButton.styleFrom(
                    //                 backgroundColor: Colors.grey.shade200,
                    //                 foregroundColor: Colors.grey,
                    //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                    //             ),
                    //             child: const Text('Save'),
                    //           );
                    //         }),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom + 16,
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
                  child:
                    // final bool isEnabled = controller.selectedLanguage.isNotEmpty &&
                    //     controller.selectedProficiency.isNotEmpty;
                     ElevatedButton(
                      onPressed: () {},
                      // onPressed: isEnabled ? () {
                      //   // Handle save action
                      //   Get.back();
                      // } : null,
                      style: ElevatedButton.styleFrom(
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/profile/add_license_controller.dart';

class AddLicenseBottomsheet extends StatelessWidget{
  final AddLicenseController controller = Get.put(AddLicenseController());
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Row(
                      children: [
                        Text('Licensed profession', style: TextStyle(fontSize: 16),),
                        SizedBox(width: 5,),
                        Text('*', style: TextStyle(
                          fontSize: 18
                        ),),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.info_outline, size: 18,),
                      ],
                    ),
                    SizedBox(height: 12,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'e.g. Attorney at Law',
                        hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Text('Jurisdiction or Licensing body', style: TextStyle(
                          fontSize: 16
                        ),),
                        SizedBox(width: 5,),
                        Text('*', style: TextStyle(
                            fontSize: 18
                        ),),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.info_outline, size: 18,),
                      ],
                    ),
                    SizedBox(height: 12,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'e.g. California Bar Association',
                        hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Text('License number', style: TextStyle(fontSize: 16),),
                        SizedBox(width: 5,),
                        Text('*', style: TextStyle(
                            fontSize: 18
                        ),),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.info_outline, size: 18,),
                      ],
                    ),
                    SizedBox(height: 12,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter license number',
                        hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Text('Licensing verification URL', style: TextStyle(fontSize: 16),),
                        SizedBox(width: 5,),
                        Text('*', style: TextStyle(
                            fontSize: 18
                        ),),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.info_outline, size: 18,),
                      ],
                    ),
                    SizedBox(height: 12,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter URL where license can be verified',
                        hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Text('Date issued', style: TextStyle(fontSize: 16),),
                        SizedBox(width: 5,),
                        Text('*', style: TextStyle(
                            fontSize: 18
                        ),),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.info_outline, size: 18,),
                      ],
                    ),
                    SizedBox(height: 12,),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Mmm d, yyyy',
                        hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                          prefixIcon: Icon(Icons.calendar_month),
                          suffixIcon: Icon(Icons.keyboard_arrow_down_outlined)
                      ),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Text('Expiration date', style: TextStyle(fontSize: 16),),
                        SizedBox(width: 5,),
                        Text('*', style: TextStyle(
                            fontSize: 18
                        ),),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.info_outline, size: 18,),
                      ],
                    ),
                    SizedBox(height: 12,),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Mmm d, yyyy',
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                          prefixIcon: Icon(Icons.calendar_month),
                          suffixIcon: Icon(Icons.keyboard_arrow_down_outlined)
                      ),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Obx(() => SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            activeColor: Colors.green,
                            value: controller.isChecked.value,
                            onChanged: (bool? newValue) {
                              controller.isChecked.value = newValue!;
                            },
                          ),
                        )),
                        SizedBox(
                          width: 5,
                        ),
                        Text('My license does not have an expiration date'),
                      ],
                    ),
                    SizedBox(height: 24,),
                    Text('* Indicates required field', style: TextStyle(color: Colors.grey[700], fontSize: 12),),

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
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controllers/language_controller.dart';
//
// class ShowLanguageBottomsheet extends StatelessWidget{
//   final LanguageController controller = Get.put(LanguageController());
//   @override
//   Widget build(BuildContext context) {
//    return Container(
//      height: 400,
//      decoration: BoxDecoration(
//        color: Colors.white,
//        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//      ),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: [
//          Container(
//            padding: EdgeInsets.all(16),
//            decoration: BoxDecoration(
//              border: Border(
//                bottom: BorderSide(color: Colors.grey[300]!),
//              ),
//            ),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: [
//                Text(
//                  'Select Language',
//                  style: TextStyle(
//                    fontSize: 20,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//                IconButton(
//                  icon: Icon(Icons.close),
//                  onPressed: () => Get.back(),
//                ),
//              ],
//            ),
//          ),
//          Expanded(
//            child: ListView.builder(
//              itemCount: controller.languages.length,
//              itemBuilder: (context, index) {
//                return RadioListTile<String>(
//                  title: Text(controller.languages[index]),
//                  value: controller.languages[index],
//                  groupValue: controller.selectedLanguage.value,
//                  onChanged: (value) {
//                    controller.selectedLanguage.value = value!;
//                    Get.back();
//                  },
//                );
//              },
//            ),
//          ),
//        ],
//      ),
//    );
//   }
// }

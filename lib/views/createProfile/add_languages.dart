// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controllers/language_controller.dart';
// import '../../models/language_model.dart';
//
// class AddLanguages extends StatelessWidget {
//   final LanguageController controller = Get.put(LanguageController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Get.back(),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.more_vert),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Looking good. Next, tell us\nwhich languages you speak.',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Upwork is global, so clients are often interested to know what languages you speak. English is a must, but do you speak any other languages?',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//             SizedBox(height: 24),
//             // Default English language field
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Language'),
//                 SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'English (all profiles include this)',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ),
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           hintText: 'My level is',
//                           border: OutlineInputBorder(),
//                         ),
//                         items: controller.proficiencyLevels
//                             .map((level) => DropdownMenuItem(
//                           value: level,
//                           child: Text(level),
//                         ))
//                             .toList(),
//                         onChanged: (value) {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             // List of added languages
//             Obx(() => Column(
//               children: [
//                 for (int i = 0; i < controller.languages.length; i++)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 16.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextFormField(
//                             initialValue: controller.languages[i].name,
//                             decoration: InputDecoration(
//                               labelText: 'Language',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 16),
//                         Expanded(
//                           child: DropdownButtonFormField<String>(
//                             value: controller.languages[i].proficiency,
//                             decoration: InputDecoration(
//                               labelText: 'Proficiency',
//                               border: OutlineInputBorder(),
//                             ),
//                             items: controller.proficiencyLevels
//                                 .map((level) => DropdownMenuItem(
//                               value: level,
//                               child: Text(level),
//                             ))
//                                 .toList(),
//                             onChanged: (value) => controller.updateProficiency(
//                                 i, value ?? 'Beginner'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//               ],
//             )),
//             // Add language button
//             OutlinedButton.icon(
//               icon: Icon(Icons.add, color: Colors.green),
//               label: Text(
//                 'Add a language',
//                 style: TextStyle(color: Colors.green),
//               ),
//               style: OutlinedButton.styleFrom(
//                 side: BorderSide(color: Colors.green),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//               onPressed: () {
//                 controller.addLanguage(
//                   Language(name: '', proficiency: 'Basic'),
//                 );
//               },
//             ),
//             Spacer(),
//             // Write an overview button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                 ),
//                 onPressed: () {
//                   // Navigate to next screen
//                   Get.toNamed('/overview');
//                 },
//                 child: Text(
//                   'Write an overview',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/language_controller.dart';
import '../../routes/app_routes.dart';

class AddLanguages extends StatelessWidget {
  final LanguageController controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Looking good. Next, tell us which languages you speak.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Upwork is global, so clients are often interested to know what languages you speak. English is a must, but do you speak any other languages?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Language',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Proficiency',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 48), // Space for delete button
                      ],
                    ),
                    SizedBox(height: 16),
                    // Obx(() => Column(
                    //       children: [
                    //         for (int i = 0;
                    //             i < controller.languages.length;
                    //             i++)
                    //           Padding(
                    //             padding: const EdgeInsets.only(bottom: 12.0),
                    //             child: Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: controller.languages[i].isDefault
                    //                       ? Container(
                    //                           child: Padding(
                    //                               padding: EdgeInsets.symmetric(
                    //                                // horizontal: 12,
                    //                                 vertical: 14,
                    //                               ),
                    //                               child: Text(
                    //                                 'English (all profiles include this)',
                    //                                 style: TextStyle(
                    //                                     color:
                    //                                         Colors.grey[600]),
                    //                               )),
                    //                         )
                    //                       : GestureDetector(
                    //                           onTap: () => showBottomSheet(
                    //                               context,
                    //                               controller.languageOptions,
                    //                               (value) {
                    //                             controller.updateLanguage(
                    //                                 i, value);
                    //                           }),
                    //                           child: Container(
                    //                             padding: EdgeInsets.symmetric(
                    //                                // horizontal: 12,
                    //                                 vertical: 14),
                    //                             decoration: BoxDecoration(
                    //                               border: Border.all(
                    //                                   color: Colors.grey[300]!),
                    //                               borderRadius:
                    //                                   BorderRadius.circular(4),
                    //                             ),
                    //                             child: Row(
                    //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                               mainAxisSize: MainAxisSize.min,
                    //                               children: [
                    //                                 Expanded(
                    //                                   child: Text(
                    //                                     controller.languages[i].name,
                    //                                     overflow: TextOverflow.ellipsis,
                    //                                     style: TextStyle(
                    //                                         color: Colors.black),
                    //                                   ),
                    //                                 ),
                    //                                 Icon(Icons.keyboard_arrow_down, size: 20,)
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         ),
                    //                 ),
                    //                 SizedBox(width: 12),
                    //                 Expanded(
                    //                   child: GestureDetector(
                    //                     onTap: () => showBottomSheet(context,
                    //                         controller.proficiencyLevels,
                    //                         (value) {
                    //                       controller.updateProficiency(
                    //                           i, value);
                    //                     }),
                    //                     child: Container(
                    //                       padding: EdgeInsets.symmetric(
                    //                           horizontal: 12, vertical: 14),
                    //                       decoration: BoxDecoration(
                    //                         border: Border.all(
                    //                             color: Colors.grey[300]!),
                    //                         borderRadius:
                    //                             BorderRadius.circular(4),
                    //                       ),
                    //                       child: Row(
                    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                         children: [
                    //                           Expanded(
                    //                             child: Text(
                    //                               controller
                    //                                       .languages[i].proficiency ??
                    //                                   'Select Proficiency',
                    //                               overflow: TextOverflow.ellipsis,
                    //                               style:
                    //                                   TextStyle(color: Colors.black),
                    //                             ),
                    //                           ),
                    //                           Icon(Icons.keyboard_arrow_down, size: 20,)
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 //SizedBox(width: 10),
                    //                 if (!controller.languages[i].isDefault)
                    //                   IconButton(
                    //                     padding: EdgeInsets.zero,
                    //                     constraints: BoxConstraints(),
                    //                     icon: Icon(Icons.delete_outline,
                    //                         color: Colors.green),
                    //                     onPressed: () =>
                    //                         controller.removeLanguage(i),
                    //                   ),
                    //               ],
                    //             ),
                    //           ),
                    //       ],
                    //     )),

                    Obx(() => Column(
                      children: List.generate(controller.languages.length, (i) {
                        final lang = controller.languages[i];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: lang.language == 'English'
                                    ? Container(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Text(
                                    'English (all profiles include this)',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                )
                                    : GestureDetector(
                                  onTap: () => showBottomSheet(
                                    context,
                                    controller.languageOptions,
                                        (value) => controller.updateLanguage(i, value),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]!),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            lang.language ?? 'Select Language',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        Icon(Icons.keyboard_arrow_down, size: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => showBottomSheet(
                                    context,
                                    controller.proficiencyLevels,
                                        (value) => controller.updateProficiency(i, value),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[300]!),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            lang.level ?? 'Select Proficiency',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        Icon(Icons.keyboard_arrow_down, size: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (lang.language != 'English')
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(Icons.delete_outline, color: Colors.green),
                                  onPressed: () => controller.removeLanguage(i),
                                ),
                            ],
                          ),
                        );
                      }),
                    )),
                    OutlinedButton.icon(
                      icon: Icon(Icons.add, color: Colors.green),
                      label: Text(
                        'Add a language',
                        style: TextStyle(color: Colors.green),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: controller.addLanguage,
                    ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheet(
      BuildContext context, List<String> options, Function(String) onSelected) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options
              .map(
                (option) => ListTile(
                  title: Text(option),
                  onTap: () {
                    onSelected(option);
                    Get.back();
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // void showLanguageBottomSheet(BuildContext context, int index) {
  //   final controller = Get.find<LanguageController>();
  //
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(16),
  //         child: Wrap(
  //           children: controller.languageOptions.map((language) {
  //             return ListTile(
  //               title: Text(language),
  //               onTap: () {
  //                 controller.languages[index].name = language;
  //                 controller.languages.refresh();
  //                 Navigator.pop(context);
  //               },
  //             );
  //           }).toList(),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // void showProficiencyBottomSheet(BuildContext context, int index) {
  //   final controller = Get.find<LanguageController>();
  //
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(16),
  //         child: Wrap(
  //           children: controller.proficiencyLevels.map((level) {
  //             return ListTile(
  //               title: Text(level),
  //               onTap: () {
  //                 controller.languages[index].proficiency = level;
  //                 controller.languages.refresh();
  //                 Navigator.pop(context);
  //               },
  //             );
  //           }).toList(),
  //         ),
  //       );
  //     },
  //   );
  // }
}

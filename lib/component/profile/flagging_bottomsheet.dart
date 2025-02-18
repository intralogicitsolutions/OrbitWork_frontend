import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/profile/flagging_controller.dart';

class FlaggingBottomsheet extends StatelessWidget {
  final FlaggingController controller = Get.put(FlaggingController());

  final List<String> reasons = [
    'Person is requesting payment outside of Orbitwork',
    'Person is attempting to buy or use my Orbitwork account',
    'Person in the profile is not the person working on Orbitwork',
    'Profile looks fake or contains stolen/plagiarized content',
    'Something else',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    'Why are you flagging this?',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                  )),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close)),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              // Text('Person is requesting payment outside of Orbitwork'),
              // Text('Person is attempting to buy or use my Orbitwork account'),
              // Text('Person in the profile is not the person working on Orbitwork'),
              // Text('Profile looks fake or contains stolen/plagiarized content'),
              // Text('Something else'),

              Obx(() => Wrap(
                spacing: 8,
                  runSpacing: 16,
                    children: reasons.map((reason) {
                      return GestureDetector(
                        onTap: () => controller.selectedReason.value = reason,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Radio<String>(
                              activeColor: Colors.green,
                              value: reason,
                              groupValue: controller.selectedReason.value,
                              onChanged: (value) {
                                controller.selectedReason.value = value!;
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              // Reduces tap target size
                              visualDensity: VisualDensity
                                  .compact, // Reduces default spacing
                            ),
                            SizedBox(width: 8), // Adjust spacing as needed
                            Expanded(child: Text(reason, style: TextStyle(
                              fontSize: 16
                            ),)),
                          ],
                        ),
                      );
                    }).toList(),
                  )),

              // Column(
              //   children: reasons.map((reason) {
              //     return Obx(() => RadioListTile<String>(
              //       title: Text(reason),
              //       value: reason,
              //       groupValue: controller.selectedReason.value,
              //       onChanged: (value) {
              //         controller.selectedReason.value = value!;
              //       },
              //     ));
              //   }).toList(),
              // ),

              SizedBox(
                height: 24,
              ),
              Text(
                'Please tell us more',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              // Obx(() {
              //     return TextField(
              //       decoration: InputDecoration(
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(8)),
              //         ),
              //         hintText: 'Share additional details',
              //         hintStyle: TextStyle(
              //           fontSize: 12, color: Colors.grey[600]
              //         ),
              //         contentPadding: EdgeInsets.symmetric(
              //           horizontal: 16,
              //           vertical: 12,
              //         ),
              //       ),
              //       maxLines: 4,
              //       onChanged: controller.updateCharacterCount,
              //     );
              //   }
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  hintText: 'Share additional details',
                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                maxLines: 4,
                onChanged: controller.updateCharacterCount,
              ),
              // ),
              Obx(() {
                return Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                        '${controller.remainingCharacters.value} characters left'));
              })
            ],
          ),
        ),
      ),
    );
  }
}

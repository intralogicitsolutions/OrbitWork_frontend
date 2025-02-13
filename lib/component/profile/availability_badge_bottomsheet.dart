import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../controllers/profile/availability_badge_controller.dart';

class AvailabilityBadgeBottomSheet extends StatelessWidget {
  final controller = Get.put(AvailabilityBadgeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Turn on availability\nbadge',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          // onPressed: () => Get.back(),
                          onPressed: () {
                            controller.validateAndUpdateConnects();
                            Get.back();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Make it easy for clients to see you\'re open for work by turning on the Availability Badge. This label helps you stand out wherever your profile is shown. Freelancers who use the badge may receive up to 50% more invites.',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Preview',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(Icons.person_outline, color: Colors.grey),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ishita P.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Mobile app developer',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 12,),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Optional: Background color
                                  border: Border.all(color: Colors.lightBlue, width: 1), // Green border
                                  borderRadius: BorderRadius.circular(12), // Rounded corners
                                ),
                                child: Row(
                                  children: [
                                   Icon(Icons.electric_bolt, size: 12, color: Colors.lightBlue,),
                                    SizedBox(width: 5,),
                                    Text('Available now', style: TextStyle(fontSize: 12, color: Colors.lightBlue),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Maximum budget',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      // 'Current price: ${controller.connects} Connects per week',
                      'Current price: 14 Connects per week',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 2), // Green border
                          ),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.remove, color: Colors.green, size: 20),
                              onPressed: controller.decrementConnects,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 16),
                        //   child: Obx(() => Text(
                        //     '${controller.connects.value}',
                        //     style: TextStyle(fontSize: 18),
                        //   )),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: 60,
                            height: 40,
                            child: TextField(
                              controller: controller.connectsTextController,
                              focusNode: controller.connectsFocusNode,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                              ),
                              onSubmitted: (_) {
                                controller.validateAndUpdateConnects();
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 2), // Green border
                          ),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.add, color: Colors.green,size: 20,),
                              onPressed: controller.incrementConnects,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Connects per\nweek',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Row(
                    //   children: [
                    //     Icon(Icons.info_outline, color: Colors.red),
                    //     SizedBox(width: 8),
                    //     Text(
                    //       'You have 0 Connects.',
                    //       style: TextStyle(color: Colors.red),
                    //     ),
                    //   ],
                    // ),
                    Obx(() => Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: controller.connects.value < 14 ? Colors.red : Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'You have ${controller.connects.value} Connects.',
                          style: TextStyle(
                            color: controller.connects.value < 14 ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    )),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    // onPressed: () => Get.back(),
                    onPressed: () {
                      controller.validateAndUpdateConnects();
                      Get.back();
                    },
                    child: Text('Cancel'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.green),
                      foregroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Obx(
                     () {
                      return ElevatedButton(
                        onPressed: controller.connects.value >= 14 ? () {} : null, // Disabled state
                        child: Text('Turn On', style: TextStyle(color: controller.connects.value >= 14
                            ? Colors.white : Colors.black38),),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: controller.connects.value >= 14 ? Colors.green : Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
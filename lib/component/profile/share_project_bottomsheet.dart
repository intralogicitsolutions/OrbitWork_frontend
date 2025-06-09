import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../client_profile_controller/consultation_controller.dart';

class ShareProjectBottomsheet extends StatelessWidget{
  final ConsultationController controller = Get.put(ConsultationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.close)),
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/icon/share.svg',
                  height: 120,
                  width: 120,
                ),
              ),
              SizedBox(height: 20,),
              Text('Share this project with others', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500
              ),
              ),
              SizedBox(height: 12,),
              Text('Spread the word about this Orbitwork project on your social media accounts.',
              textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Text('Shared Project Tier', textAlign: TextAlign.start,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Obx(() {
                    return GestureDetector(
                      onTap: () {
                        Get.bottomSheet(DurationBottomSheet());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.selectedShareDuration.value),
                            Icon(Icons.keyboard_arrow_down_outlined)
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Get.theme.primaryColor)
                      ),
                      child: Image.asset(
                        'assets/icon/facebook.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Get.theme.primaryColor)
                      ),
                      child: Image.asset(
                        'assets/icon/linkedin.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Get.theme.primaryColor)
                      ),
                      child: Image.asset(
                        'assets/icon/twitter.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Get.theme.primaryColor)
                      ),
                      child: Image.asset(
                        'assets/icon/link.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class DurationBottomSheet extends StatelessWidget {
  final ConsultationController controller = Get.put(ConsultationController());

  final List<String> options = ['30 minutes', '60 minutes'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map((option) {
          return Obx(() => RadioListTile<String>(
            activeColor: Get.theme.primaryColor,
            value: option,
            groupValue: controller.selectedShareDuration.value,
            title: Text(option),
            onChanged: (value) {
              if (value != null) {
                controller.updateDuration(value);
              }
            },
          ));
        }).toList(),
      ),
    );
  }
}

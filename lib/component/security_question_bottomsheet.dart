import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/add_extra_layers_security_controller.dart';

class SecurityQuestionBottomsheet extends StatelessWidget{
  final AddExtraLayersSecurityController controller = Get.put(AddExtraLayersSecurityController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('Your elementary school mascot', style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w500
                  ),),
                ),
                IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)),
              ],
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.filterSecurityQuestion.length,
                itemBuilder: (context, index) {
                  final country = controller.filterSecurityQuestion[index];
                  return Obx(() => RadioListTile<String>(
                    value: country,
                    groupValue: controller.selectedSecurityQuestion.value,
                    onChanged: (value) => controller.updateCountry(value!),
                    title: Text(
                      country,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ));
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
  
}
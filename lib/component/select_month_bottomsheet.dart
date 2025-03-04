import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/month_controller.dart';
import '../controllers/work_experience_controller.dart';
import '../models/month_model.dart';

class MonthBottomSheet extends GetView<WorkExperienceController> {
  final WorkExperienceController controller = Get.put(WorkExperienceController());
 // const MonthBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Month',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.months.length,
              itemBuilder: (context, index) {
                final month = controller.months[index];
                return ListTile(
                  leading: Obx(
                        () => Radio<MonthModel>(
                          activeColor: Get.theme.primaryColor,
                      value: month,
                      groupValue: controller.selectedMonth.value,
                      onChanged: (MonthModel? value) {
                        if (value != null) controller.selectMonth(value);
                      },
                    ),
                  ),
                  title: Text(
                    month.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: ()  {
                    controller.selectMonth(month); // Update the selected month
                   // Navigator.pop(context); // Close the bottom sheet
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
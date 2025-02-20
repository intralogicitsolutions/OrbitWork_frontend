import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/get_paid_controller.dart';

class SelectBankAccountBottomsheet extends StatelessWidget{
  final GetPaidController controller = Get.put(GetPaidController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('Select a bank account type', style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w500
                  ),),
                ),
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 24,),
            _buildRadioOption('Individual checking'),
            _buildRadioOption('Individual savings'),
            _buildRadioOption('Corporation checking'),
            _buildRadioOption('Corporation saving'),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String text) {
    return Obx(() => RadioListTile<String>(
      title: Text(text),
      value: text,
      groupValue: controller.selectAccountType.value,
      onChanged: (value) => controller.setBankAccount(value ?? ''),
      contentPadding: EdgeInsets.zero,
      activeColor: Colors.green,
    ));
  }

}
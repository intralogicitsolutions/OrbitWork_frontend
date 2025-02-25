import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/warning_controller.dart';

Widget buildWarningMessage(BuildContext context) {
  final WarningController controller = Get.find();

  return Obx(() => controller.showWarning.value
      ? Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 242, 242),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Aligns content to the center vertically
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('⚠'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "In compliance with Tax Law in India, Orbitwork withholds 0.1% Tax at Deduction Source (TDS) from your payments. The TDS can be as much as 5% if you haven\'t provided your govt. issued tax id yet. Please click here to add your PAN asap. For more details, read our fAQs.",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.visible,
                        style: TextStyle(color: Colors.red.shade900),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: IconButton(
                          onPressed: controller.dismissWarningText,
                          icon: Icon(
                            Icons.close,
                            color: Colors.red.shade900,
                          ),
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            )
          ],
        )
      : SizedBox());
}

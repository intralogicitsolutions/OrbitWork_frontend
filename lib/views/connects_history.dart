import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/profile/connects_bottomsheet.dart';
import '../controllers/profile/connects_history_controller.dart';
import '../widgets/select_duration_bottomsheet.dart';

class ConnectsHistory extends StatelessWidget {
  final ConnectsHistoryController controller =
      Get.put(ConnectsHistoryController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connects history',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => controller.showWarning.value
                  ? _buildWarningMessage(context)
                  : SizedBox()),
              SizedBox(
                height: 24,
              ),
              Text(
                'Connects History',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My balance',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Obx(() {
                            return Text(
                              '${controller.balance.value} Connects',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            );
                          }),
                        ],
                      ),
                      Image.asset(
                        'assets/icon/balance.png',
                        height: 80,
                        width: 80,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Connects type'),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                                height: Get.height * 0.9,
                                child: ConnectsBottomSheet()),
                            isScrollControlled: true,
                            ignoreSafeArea: false,
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Text('All connects'),
                              Obx(() => Expanded(
                                      child: Text(
                                    controller.selectedFiltersText.value,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: theme.secondaryHeaderColor),
                                  ))),
                              Icon(Icons.keyboard_arrow_down_outlined)
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date'),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            //showBottomSheet(context);
                            showDurationBottomSheet(context, (selectedValue) {
                              controller.selectedDuration.value = selectedValue;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  return Text(
                                    controller.selectedDuration.value,
                                    style: TextStyle(
                                        color: theme.secondaryHeaderColor),
                                  );
                                }),
                                Icon(Icons.keyboard_arrow_down_outlined),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 600,
                // height: 300,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() => Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 120, child: Text('Date')),
                                  SizedBox(width: 400, child: Text('Action')),
                                  SizedBox(width: 80, child: Text('Connects')),
                                ],
                              ),
                              Container(
                                width: 600,
                                child: Divider(
                                  color: Colors.grey[300],
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: controller.history
                                .map((item) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[300]!),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Date Column
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              item.date,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          // Action Column
                                          SizedBox(
                                            width: 400,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.action,
                                                  style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  item.jobTitle,
                                                  style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Connects Column
                                          SizedBox(
                                            width: 80,
                                            child: Text(
                                              item.connectsChange > 0
                                                  ? '+${item.connectsChange}'
                                                  : '${item.connectsChange}',
                                              style: TextStyle(
                                                color: item.connectsChange > 0
                                                    ? Colors.green
                                                    : Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningMessage(BuildContext context) {
    return Container(
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
            IconButton(
              onPressed: controller.dismissWarningText,
              icon: Icon(
                Icons.close,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/component/select_all_speciality_bottomsheet.dart';

class SwitchSpecialtyBottomsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Switch Specialty',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.close)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
        ],
      ),
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'We\'ll copy over the information from your current specialized profile to your new one if you change your specialty.'),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Select a specialty:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        onTap: () {
                          Get.bottomSheet(
                              SelectAllSpecialtyBottomsheet(),
                              ignoreSafeArea: false,
                              isScrollControlled: true
                          );
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Select a specialty',
                            suffixIcon: Icon(Icons.keyboard_arrow_down),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      side: BorderSide.none,
                      foregroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      ' Cancel',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Get.theme.primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Unpublish & Continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

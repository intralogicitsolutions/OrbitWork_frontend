import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/flag_inappropriate_controller.dart';

class FlagInappropriateBottomsheet extends StatelessWidget{
  final FlagInappropriateController controller = Get.put(FlagInappropriateController());

  final List<String> reasons = [
    'Client is offering payment outside of Orbitwork',
    'Person is attempting to buy or use my Orbitwork account',
    'Client is misrepresenting their identity',
    'Job post looks like a scam or contains a suspicious link',
    'Job post contains contact information',
    'It\'s something else'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Expanded(
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
                            child: Text('Flag as inappropriate', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),)),
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
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(){
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
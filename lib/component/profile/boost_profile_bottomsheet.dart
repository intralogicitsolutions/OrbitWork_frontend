import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../controllers/profile/boost_profile_controller.dart';
import '../../controllers/tooltip_controller.dart';
import '../../widgets/custom_tooltip.dart';

class BoostProfileBottomsheet extends StatelessWidget {
  final controller = Get.put(BoostProfileController());
  final tooltipController = Get.put(TooltipController());
  final SuperTooltipController _tooltipController = SuperTooltipController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Boost your profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close)),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'With a boost, you can bid Connects to jump to the top of search results. We only charge if a client clicks on your profile.',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(
                height: 24,
              ),
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
                        Row(
                          children: [
                            Text(
                              'Ishita P.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.electric_bolt,
                                  size: 12,
                                  color: Colors.lightBlue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Available now',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                        Text(
                          'Mobile app developer',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Audience',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 24,
              ),
              Text('Category'),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // Optional: Background color
                  border: Border.all(color: Colors.grey, width: 1),
                  // Border color and width
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select a category',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined)
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Speciality',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  // Optional: Background color
                  // border: Border.all(color: Colors.grey, width: 1), // Border color and width
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select a speciality',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Budget',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Text('Bid per click'),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.help_outline),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomTooltip(
                      message: 'Bids help you reach the top of search results, and higher bids increase your chances.',
                      child: Icon(Icons.help_outline),
                    ),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Number of Connects',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Text('Limit'),
                  SuperTooltip(
                    controller: _tooltipController,
                   popupDirection: TooltipDirection.up, // Show above the icon
                    backgroundColor: Colors.white, // White background
                    shadowColor: Colors.transparent, // Soft shadow
                    borderRadius: 8.0,
                    showCloseButton: false, // Close button inside tooltip
                    hasShadow: false, // Enable shadow
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Set a daily or total limit for spending on bids.',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (_tooltipController.isVisible) {
                          _tooltipController.hideTooltip();
                        } else {
                          _tooltipController.showTooltip();
                        }
                      },
                      icon: Icon(Icons.help_outline),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.help_outline),
                  // ),
                ],
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey.shade300),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Obx(() => _SelectableButton(
              //           text: 'Daily',
              //           isSelected: controller.isDailySelected.value,
              //           onTap: () => controller.toggleDailyTotal(true),
              //         )),
              //       ),
              //       Expanded(
              //         child: Obx(() => _SelectableButton(
              //           text: 'Total',
              //           isSelected: !controller.isDailySelected.value,
              //           onTap: () => controller.toggleDailyTotal(false),
              //         )),
              //       ),
              //     ],
              //   ),
              // ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.connectTextController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Number of Connect',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(width: 16),
                  Obx(() => Radio<bool>(
                        value: true,
                        groupValue: controller.isDailySelected.value,
                        onChanged: (value) => controller.toggleDailyTotal(true),
                        activeColor: Colors.green,
                      )),
                  const Text('Daily'),
                  //const SizedBox(width: 16),
                  Obx(() => Radio<bool>(
                        value: false,
                        groupValue: controller.isDailySelected.value,
                        onChanged: (value) =>
                            controller.toggleDailyTotal(false),
                        activeColor: Colors.green,
                      )),
                  const Text('Total'),
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                () => Text(
                  'You have ${controller.connects} Connects left.',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: const Text(
                  'Buy more Connects',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Schedule',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'End date (optional)',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    controller.setDate(picked.toString().split(' ')[0]);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                            controller.selectedDate.value.isEmpty
                                ? 'MMM d, yyyy'
                                : controller.selectedDate.value,
                            style: TextStyle(
                              color: controller.selectedDate.value.isEmpty
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          )),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SummaryRow('Bid per click', '-'),
                    const SizedBox(height: 8),
                    _SummaryRow('Limit', '-'),
                    const SizedBox(height: 8),
                    _SummaryRow('You\'ll receive up to', '-'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement boost logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Boost now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectableButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value),
      ],
    );
  }
}

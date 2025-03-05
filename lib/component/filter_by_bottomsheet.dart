import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/filter_controller.dart';
import '../models/filter_model.dart';

class FilterBottomSheet extends StatelessWidget {
  final FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter By',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Category dropdown (disabled in this example)
                  _buildDropdownColumn('Category', 'Select Categories'),

                  // Experience Level section
                  _buildSectionTitle('Experience level'),
                  _buildFilterList(controller.experienceLevels,
                      controller.toggleExperienceLevel),

                  // Job Type section
                  _buildSectionTitle('Job type'),
                  _buildFilterList(
                      controller.jobTypes, controller.toggleJobType),

                  // Hourly Price Range
                  _buildPriceRangeRow(
                      'Hourly',
                      controller.hourlyMinPriceController,
                      controller.hourlyMaxPriceController),

                  // Fixed Price section
                  _buildSectionTitle('Fixed-Price'),
                  _buildFilterList(
                      controller.priceRanges, controller.togglePriceRange),

                  // Custom Price Range
                  _buildPriceRangeRow(
                      'Fixed-Price',
                      controller.minPriceController,
                      controller.maxPriceController),

                  _buildSectionTitle('Number of proposals'),
                  _buildFilterList(controller.numberOfProposals,
                      controller.toggleNumberOfProposals),

                  _buildSectionTitle('Client info'),
                  _buildFilterList(
                      controller.clientInfo, controller.toggleClientInfo),

                  _buildSectionTitle('Client history'),
                  _buildFilterList(
                      controller.clientHistory, controller.toggleClientHistory),

                  _buildDropdownColumn(
                      'Client location', 'Select client locations'),

                  _buildDropdownColumn(
                      'Client time zones', 'Select client time zones'),

                  _buildSectionTitle('Project length'),
                  _buildFilterList(
                      controller.projectLength, controller.toggleProjectLength),

                  _buildSectionTitle('Hours per week'),
                  _buildFilterList(
                      controller.hoursPerWeek, controller.toggleHoursPerWeek),

                  _buildSectionTitle('Job duration'),
                  _buildFilterList(
                      controller.jobDuration, controller.toggleJobDuration),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: controller.clearFilters,
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                      side: BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text('Clear filters'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Apply filters logic here
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text(
                    'Apply',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownColumn(String title, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hint,
                  style: TextStyle(color: Colors.grey),
                ),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFilterList(List<FilterOption> items, Function(int) onToggle) {
    return Column(
      children: List.generate(items.length, (index) {
        return Obx(() => CheckboxListTile(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                // ✅ Prevents extra spacing in Row
                children: [
                  Text(items[index].title),
                  SizedBox(width: 5),
                  Text(
                    '(${items[index].count})',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              value: items[index].selected.value,
              onChanged: (_) => onToggle(index),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.green,
              contentPadding: EdgeInsets.zero,
              // ✅ Removes extra padding
              visualDensity: VisualDensity(
                  horizontal: -4, vertical: -4), // ✅ Reduces spacing
            ));
      }),
    );
  }

  Widget _buildPriceRangeRow(String type, TextEditingController minController,
      TextEditingController maxController) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 35,
                child: TextField(
                  controller: minController,
                  decoration: InputDecoration(
                    hintText: '\$ Min',
                    prefixText: '\$ ',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Text('/hr', style: TextStyle(color: Colors.grey)),
            SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 35,
                child: TextField(
                  controller: maxController,
                  decoration: InputDecoration(
                    hintText: '\$ Max',
                    prefixText: '\$ ',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Text('/hr', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../client_profile_controller/talent_filters_controller.dart';

class TalentFiltersBottomSheet extends StatelessWidget {
  final TalentFiltersController controller = Get.find<TalentFiltersController>();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 16),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.close, size: 24),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTalentBadgeSection(),
                        SizedBox(height: 24),
                        _buildHourlyRateSection(),
                        SizedBox(height: 24),
                        _buildLocationSection(),
                        SizedBox(height: 24),
                        _buildTalentTimeZonesSection(),
                        SizedBox(height: 24),
                        _buildTalentTypeSection(),

                        SizedBox(height: 24),

                        // Additional options
                        _buildAdditionalOptions(),

                        SizedBox(height: 24),

                        // Category section
                        //_buildCategorySection(),
                        _buildDynamicFilterSections(),

                        SizedBox(height: 24,),

                        Column(
                          children: controller.filterData.keys.map((category) {
                            return _buildFilterCategory(category);
                          },).toList(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // Bottom buttons
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: controller.clearFilters,
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: controller.applyFilters,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTalentBadgeSection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => controller.toggleSection('talentBadge'),
          child: Row(
            children: [
              Text(
                'Talent badge',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.help_outline,
                size: 18,
                color: Colors.grey[600],
              ),
              Spacer(),
              Icon(
                controller.isTalentBadgeExpanded.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 24,
                color: Colors.grey[600],
              ),
            ],
          ),
        ),
        if (controller.isTalentBadgeExpanded.value) ...[
          SizedBox(height: 16),
          _buildTalentBadgeOption(
            'Top Rated Plus',
            Icons.star,
            Colors.pink,
            controller.isTopRatedPlusSelected.value,
                () => controller.toggleTalentBadge('topRatedPlus'),
          ),
          SizedBox(height: 12),
          _buildTalentBadgeOption(
            'Top Rated',
            Icons.star,
            Colors.blue,
            controller.isTopRatedSelected.value,
                () => controller.toggleTalentBadge('topRated'),
          ),
          SizedBox(height: 12),
          _buildTalentBadgeOption(
            'Rising Talent',
            Icons.trending_up,
            Colors.green,
            controller.isRisingTalentSelected.value,
                () => controller.toggleTalentBadge('risingTalent'),
          ),
        ],
      ],
    ));
  }

  Widget _buildTalentBadgeOption(
      String title,
      IconData icon,
      Color iconColor,
      bool isSelected,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.green : Colors.grey[400]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? Colors.green : Colors.transparent,
            ),
            child: isSelected
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : null,
          ),
          SizedBox(width: 12),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyRateSection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => controller.toggleSection('hourlyRate'),
          child: Row(
            children: [
              Text(
                'Hourly rate',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Icon(
                controller.isHourlyRateExpanded.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 24,
                color: Colors.grey[600],
              ),
            ],
          ),
        ),
        if (controller.isHourlyRateExpanded.value) ...[
          SizedBox(height: 20),
          _buildHourlyRateChart(),
        ],
      ],
    ));
  }

  Widget _buildHourlyRateChart() {
    return Obx(() {
      double maxValue = controller.hourlyRateData
          .map((item) => (item['value'] as int).toDouble())
          .reduce((a, b) => a > b ? a : b);

      return Column(
        children: [
          Container(
            height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: controller.hourlyRateData.asMap().entries.map((entry) {
                int index = entry.key;
                var item = entry.value;
                double height = ((item['value'] as int) / maxValue) * 100;
                bool isSelected = item['isSelected'] as bool;

                return GestureDetector(
                  onTap: () => controller.selectHourlyRate(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 32,
                        height: height,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green[700] : Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 40,
            child: Stack(
              children: [
                // Background line
                Positioned(
                  left: 20,
                  right: 20,
                  top: 18,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Left handle
                Positioned(
                  left: 16,
                  top: 12,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Right handle
                Positioned(
                  right: 16,
                  top: 12,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildLocationSection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => controller.toggleSection('location'),
          child: Row(
            children: [
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Icon(
                controller.isLocationExpanded.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 24,
                color: Colors.grey[600],
              ),
            ],
          ),
        ),
        if (controller.isLocationExpanded.value) ...[
          SizedBox(height: 16),
          InkWell(
            onTap: () {
              Get.bottomSheet(
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Select Location",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(height: 1),
                        ...[
                          'Location',
                          'United States',
                          'United Kingdom',
                          'Canada',
                          'Australia',
                          'India',
                          'Germany',
                          'France',
                        ].map((location) {
                          return ListTile(
                            title: Text(location),
                            onTap: () {
                              controller.setLocation(location);
                              Get.back(); // Close bottom sheet
                            },
                          );
                        }).toList(),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                    controller.selectedLocation.value,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  )),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                ],
              ),
            ),
          ),
        ],

      ],
    ));
  }

  Widget _buildTalentTimeZonesSection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => controller.toggleSection('timeZones'),
          child: Row(
            children: [
              Text(
                'Talent time zones',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Icon(
                controller.isTalentTimeZonesExpanded.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 24,
                color: Colors.grey[600],
              ),
            ],
          ),
        ),
        if (controller.isTalentTimeZonesExpanded.value) ...[
          SizedBox(height: 16),
          InkWell(
            onTap: () {
              Get.bottomSheet(
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Select Time Zone",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(height: 1),
                        ...[
                          'UTC-12:00 (Baker Island)',
                          'UTC-11:00 (Hawaii)',
                          'UTC-10:00 (Alaska)',
                          'UTC-9:00 (Pacific)',
                          'UTC-8:00 (Mountain)',
                          'UTC-7:00 (Central)',
                          'UTC-6:00 (Eastern)',
                          'UTC-5:00 (Atlantic)',
                          'UTC+0:00 (GMT)',
                          'UTC+1:00 (CET)',
                          'UTC+5:30 (IST)',
                          'UTC+8:00 (CST)',
                          'UTC+9:00 (JST)',
                        ].map((timeZone) {
                          return ListTile(
                            title: Text(timeZone),
                            onTap: () {
                              controller.setTimeZone(timeZone);
                              Get.back(); // close bottom sheet
                            },
                          );
                        }).toList(),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                    controller.selectedTimeZone.value.isEmpty
                        ? 'Select time zone'
                        : controller.selectedTimeZone.value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  )),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                ],
              ),
            ),
          ),
        ],

      ],
    ));
  }

  Widget _buildTalentTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Talent type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(Icons.keyboard_arrow_up, color: Colors.black),
          ],
        ),

        SizedBox(height: 16),

        Obx(() => Column(
          children: [
            _buildRadioOption(
              'Freelancers & Agencies',
              controller.selectedTalentType.value == 'Freelancers & Agencies',
                  () => controller.selectTalentType('Freelancers & Agencies'),
            ),
            SizedBox(height: 12),
            _buildRadioOption(
              'Freelancers',
              controller.selectedTalentType.value == 'Freelancers',
                  () => controller.selectTalentType('Freelancers'),
            ),
            SizedBox(height: 12),
            _buildRadioOption(
              'Agencies',
              controller.selectedTalentType.value == 'Agencies',
                  () => controller.selectTalentType('Agencies'),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildRadioOption(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.green : Colors.grey[400]!,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            )
                : null,
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalOptions() {
    return Column(
      children: [
        Obx(() => _buildCheckboxOption(
          'Open to contract-to-hire',
          controller.isOpenToContractToHire.value,
          controller.toggleContractToHire,
        )),
        SizedBox(height: 12),
        Obx(() => _buildCheckboxOption(
          'Offers consultations',
          controller.offersConsultations.value,
          controller.toggleConsultations,
        )),
      ],
    );
  }

  Widget _buildCheckboxOption(String title, bool isChecked, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isChecked ? Colors.green : Colors.grey[400]!,
                width: 2,
              ),
              color: isChecked ? Colors.green : Colors.transparent,
            ),
            child: isChecked
                ? Icon(
              Icons.check,
              size: 14,
              color: Colors.white,
            )
                : null,
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicFilterSections() {
    return Obx(() {
      List<Widget> sections = [];

      // Always show category section
      sections.add(_buildCategorySection());

      // Show subcategory section if a specific category is selected
      if (controller.selectedCategory.value != 'All categories' &&
          controller.currentCategory != null) {
        sections.add(SizedBox(height: 24));
        sections.add(_buildSubcategorySection());

        // Show specialty section if a subcategory is selected
        if (controller.selectedSubcategory.value.isNotEmpty &&
            controller.currentSubcategory != null) {
          sections.add(SizedBox(height: 24));
          sections.add(_buildSpecialtySection());
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sections,
      );
    });
  }

  Widget _buildCategorySection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: controller.toggleCategoryExpansion,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Icon(
                controller.isCategoryExpanded.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
            ],
          ),
        ),

        // Show selected category when collapsed or all categories when expanded
        if (!controller.isCategoryExpanded.value) ...[
          SizedBox(height: 16),
          Text(
            controller.selectedCategory.value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ] else ...[
          SizedBox(height: 20),
          Column(
            children: controller.allCategoryNames.map((category) =>
                _buildSelectableItem(
                    category,
                    controller.selectedCategory.value == category,
                        () => controller.selectCategory(category)
                )
            ).toList(),
          ),
        ],
      ],
    ));
  }

  Widget _buildSubcategorySection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: controller.toggleSubcategoryExpansion,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subcategory',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Icon(
                controller.isSubcategoryExpanded.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
            ],
          ),
        ),

        if (!controller.isSubcategoryExpanded.value) ...[
          SizedBox(height: 16),
          Text(
            controller.selectedSubcategory.value.isNotEmpty
                ? controller.selectedSubcategory.value
                : 'Select subcategory',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ] else ...[
          SizedBox(height: 20),
          if (controller.currentCategory != null)
            Column(
              children: controller.currentCategory!.subcategories.map((subcategory) =>
                  _buildSelectableItem(
                      subcategory.name,
                      controller.selectedSubcategory.value == subcategory.name,
                          () => controller.selectSubcategory(subcategory.name)
                  )
              ).toList(),
            ),
        ],
      ],
    ));
  }

  Widget _buildSpecialtySection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: controller.toggleSpecialtyExpansion,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Specialties',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Icon(
                controller.isSpecialtyExpanded.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
            ],
          ),
        ),

        if (!controller.isSpecialtyExpanded.value) ...[
          SizedBox(height: 16),
          Text(
            controller.selectedSpecialty.value.isNotEmpty
                ? controller.selectedSpecialty.value
                : 'Select specialty',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ] else ...[
          SizedBox(height: 20),
          if (controller.currentSubcategory != null)
            Column(
              children: controller.currentSubcategory!.specialties.map((specialty) =>
                  _buildSelectableItem(
                      specialty.name,
                      controller.selectedSpecialty.value == specialty.name,
                          () => controller.selectSpecialty(specialty.name)
                  )
              ).toList(),
            ),
        ],
      ],
    ));
  }

  Widget _buildSelectableItem(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.green : Colors.black,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterCategory(String category){
    return Obx(() {
      bool isExpanded = controller.expandedCategories[category] ?? false;
      List<String> items = controller.filterData[category] ?? [];

      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            GestureDetector(
              onTap: () => controller.toggleCategoriesExpansion(category),
              child: Container(
               // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      size: 24,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),

            // Category items (radio buttons)
            if (isExpanded) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: items.map((item) {
                    bool isSelected = controller.isItemSelected(category, item);

                    return GestureDetector(
                      onTap: () => controller.selectItem(category, item),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? Colors.green : Colors.grey[400]!,
                                  width: 2,
                                ),
                                color: Colors.transparent,
                              ),
                              child: isSelected
                                  ? Container(
                               margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              )
                                  : null,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
             // SizedBox(height: 12),
            ],
            SizedBox(height: 20),
          ],
        ),
      );
    });
  }

}
import 'package:get/get.dart';

import '../client_profile_model/talent_filter_model.dart';

class TalentFiltersController extends GetxController {
  // Talent badge selections
  var isTopRatedPlusSelected = false.obs;
  var isTopRatedSelected = false.obs;
  var isRisingTalentSelected = true.obs;

  // Section expansion states
  var isTalentBadgeExpanded = true.obs;
  var isHourlyRateExpanded = true.obs;
  var isLocationExpanded = true.obs;
  var isTalentTimeZonesExpanded = true.obs;

  var selectedTalentType = 'Freelancers & Agencies'.obs;

// Additional options
  var isOpenToContractToHire = false.obs;
  var offersConsultations = false.obs;

  // Category expansion state
  var isCategoryExpanded = true.obs;
  var isSubcategoryExpanded = false.obs;
  var isSpecialtyExpanded = true.obs;
  var selectedCategory = 'All categories'.obs;
  var selectedSubcategory = ''.obs;
  var selectedSpecialty = ''.obs;

  // Hourly rate data and selection
  var hourlyRateData = [
    {'label': 'under\n\$10', 'value': 45, 'isSelected': false},
    {'label': '\$10-\$30', 'value': 80, 'isSelected': false},
    {'label': '\$30-\$60', 'value': 35, 'isSelected': false},
    {'label': '\$60-\$100', 'value': 25, 'isSelected': false},
    {'label': '\$100+', 'value': 15, 'isSelected': false},
  ].obs;


  // Range selection for hourly rate
  var selectedMinIndex = 0.obs;
  var selectedMaxIndex = 4.obs;
  var isRangeSelectionMode = true.obs;

  // Location and timezone
  var selectedLocation = 'Location'.obs;
  var selectedTimeZone = ''.obs;

  // Available categories
  // final List<String> categories = [
  //   'All categories',
  //   'Accounting & Consulting',
  //   'Admin Support',
  //   'Customer Service',
  //   'Data Science & Analytics',
  //   'Design & Creative',
  //   'Engineering & Architecture',
  //   'IT & Networking',
  //   'Legal',
  //   'Sales & Marketing',
  //   'Translation',
  //   'Web, Mobile & Software Dev',
  //   'Writing',
  // ];
  RxMap<String, String?> selectedItems = <String, String?>{}.obs;
  RxMap<String, bool> expandedCategories = <String, bool>{}.obs;

  final Map<String, List<String>> filterData = {
    'Job success': [
      'Any job success',
      '80% & up',
      '90% & up',
      '95% & up',
      '100%',
    ],
    'Earned amount': [
      'Any amount earned',
      '\$1+ earned',
      '\$100+ earned',
      '\$1K+ earned',
      '\$10K+ earned',
      'No earnings yet'
    ],
    'Hours billed': [
      'Any hours',
      '1+ hours billed',
      '100+ hours billed',
      '1,000+ hours billed'
    ],
    'English level': [
      'Any level',
      'Basic',
      'Conversational',
      'Fluent',
      'Native or bilingual',
    ],
  };

  final List<Category> categories = [
    Category(
        name: 'Accounting & Consulting',
        subcategories: [
          Subcategory(
              name: 'Personal & Professional Coaching',
              specialties: [
                Specialty(name: 'Career Coaching'),
                Specialty(name: 'Personal Coaching'),
                Specialty(name: 'Life Coaching'),
                Specialty(name: 'Business Coaching'),
              ]
          ),
          Subcategory(
              name: 'Accounting',
              specialties: [
                Specialty(name: 'Financial Accounting'),
                Specialty(name: 'Tax Preparation'),
                Specialty(name: 'Bookkeeping'),
                Specialty(name: 'Payroll'),
              ]
          ),
          Subcategory(
              name: 'Financial Consulting',
              specialties: [
                Specialty(name: 'Financial Planning'),
                Specialty(name: 'Investment Advisory'),
                Specialty(name: 'Risk Management'),
              ]
          ),
        ]
    ),
    Category(
        name: 'Admin Support',
        subcategories: [
          Subcategory(
              name: 'Virtual Assistance',
              specialties: [
                Specialty(name: 'Email Management'),
                Specialty(name: 'Calendar Management'),
                Specialty(name: 'Data Entry'),
              ]
          ),
          Subcategory(
              name: 'Customer Support',
              specialties: [
                Specialty(name: 'Live Chat Support'),
                Specialty(name: 'Phone Support'),
                Specialty(name: 'Email Support'),
              ]
          ),
        ]
    ),
    Category(
        name: 'Customer Service',
        subcategories: [
          Subcategory(
              name: 'Customer Support',
              specialties: [
                Specialty(name: 'Technical Support'),
                Specialty(name: 'Order Processing'),
                Specialty(name: 'Complaint Resolution'),
              ]
          ),
        ]
    ),
    Category(
        name: 'Data Science & Analytics',
        subcategories: [
          Subcategory(
              name: 'Data Analysis',
              specialties: [
                Specialty(name: 'Statistical Analysis'),
                Specialty(name: 'Data Visualization'),
                Specialty(name: 'Machine Learning'),
              ]
          ),
        ]
    ),
    Category(
        name: 'Design & Creative',
        subcategories: [
          Subcategory(
              name: 'Graphic Design',
              specialties: [
                Specialty(name: 'Logo Design'),
                Specialty(name: 'Brand Identity'),
                Specialty(name: 'Print Design'),
              ]
          ),
          Subcategory(
              name: 'Web Design',
              specialties: [
                Specialty(name: 'UI/UX Design'),
                Specialty(name: 'Responsive Design'),
                Specialty(name: 'Landing Pages'),
              ]
          ),
        ]
    ),
    Category(
        name: 'Engineering & Architecture',
        subcategories: [
          Subcategory(
              name: 'Software Engineering',
              specialties: [
                Specialty(name: 'Backend Development'),
                Specialty(name: 'Frontend Development'),
                Specialty(name: 'Full Stack Development'),
              ]
          ),
        ]
    ),
    Category(
        name: 'IT & Networking',
        subcategories: [
          Subcategory(
              name: 'Network Administration',
              specialties: [
                Specialty(name: 'Network Security'),
                Specialty(name: 'Server Management'),
                Specialty(name: 'Cloud Infrastructure'),
              ]
          ),
        ]
    ),
  ];

  // All categories list for initial display
  List<String> get allCategoryNames => [
    'All categories',
    ...categories.map((cat) => cat.name).toList()
  ];

  Category? get currentCategory {
    if (selectedCategory.value == 'All categories') return null;
    return categories.firstWhereOrNull((cat) => cat.name == selectedCategory.value);
  }

  Subcategory? get currentSubcategory {
    if (selectedSubcategory.value.isEmpty) return null;
    return currentCategory?.subcategories.firstWhereOrNull(
            (sub) => sub.name == selectedSubcategory.value
    );
  }


  @override
  void onInit() {
    super.onInit();
    expandedCategories['Job success'] = true;
    selectedItems['Job success'] = 'Any job success';

    for (String category in filterData.keys) {
      if (category != 'Job success') {
        expandedCategories[category] = false;
        selectedItems[category] = null;
      }
    }
  }


  void toggleTalentBadge(String badge) {
    switch (badge) {
      case 'topRatedPlus':
        isTopRatedPlusSelected.value = !isTopRatedPlusSelected.value;
        break;
      case 'topRated':
        isTopRatedSelected.value = !isTopRatedSelected.value;
        break;
      case 'risingTalent':
        isRisingTalentSelected.value = !isRisingTalentSelected.value;
        break;
    }
  }

  void toggleSection(String section) {
    switch (section) {
      case 'talentBadge':
        isTalentBadgeExpanded.value = !isTalentBadgeExpanded.value;
        break;
      case 'hourlyRate':
        isHourlyRateExpanded.value = !isHourlyRateExpanded.value;
        break;
      case 'location':
        isLocationExpanded.value = !isLocationExpanded.value;
        break;
      case 'timeZones':
        isTalentTimeZonesExpanded.value = !isTalentTimeZonesExpanded.value;
        break;
    }
  }

  void selectHourlyRate(int index) {
    for (int i = 0; i < hourlyRateData.length; i++) {
      hourlyRateData[i]['isSelected'] = i == index;
    }
    hourlyRateData.refresh();
  }

  void selectHourlyRateRange(int index) {
    // Handle range selection logic
    if (selectedMinIndex.value == -1) {
      selectedMinIndex.value = index;
    } else if (selectedMaxIndex.value == -1) {
      if (index >= selectedMinIndex.value) {
        selectedMaxIndex.value = index;
      } else {
        selectedMaxIndex.value = selectedMinIndex.value;
        selectedMinIndex.value = index;
      }
    } else {
      // Reset and start new selection
      selectedMinIndex.value = index;
      selectedMaxIndex.value = -1;
    }

    // Update visual selection
    for (int i = 0; i < hourlyRateData.length; i++) {
      bool isInRange = false;
      if (selectedMinIndex.value != -1 && selectedMaxIndex.value != -1) {
        isInRange = i >= selectedMinIndex.value && i <= selectedMaxIndex.value;
      } else if (selectedMinIndex.value != -1) {
        isInRange = i == selectedMinIndex.value;
      }
      hourlyRateData[i]['isSelected'] = isInRange;
    }
    hourlyRateData.refresh();
  }

  void setLocation(String location) {
    selectedLocation.value = location;
  }

  void setTimeZone(String timeZone) {
    selectedTimeZone.value = timeZone;
  }

  void clearFilters() {
    isTopRatedPlusSelected.value = false;
    isTopRatedSelected.value = false;
    isRisingTalentSelected.value = false;

    selectedMinIndex.value = -1;
    selectedMaxIndex.value = -1;
    selectedLocation.value = 'Location';
    selectedTimeZone.value = '';

    selectedTalentType.value = 'Freelancers & Agencies';
    isOpenToContractToHire.value = false;
    offersConsultations.value = false;
    selectedCategory.value = 'All categories';
    selectedSubcategory.value = '';
    selectedSpecialty.value = '';
    isCategoryExpanded.value = false;
    isSubcategoryExpanded.value = false;
    isSpecialtyExpanded.value = true;

    for (var item in hourlyRateData) {
      item['isSelected'] = false;
    }
    hourlyRateData.refresh();
  }

  void applyFilters() {
    // Handle apply logic here
    Get.back();
    Get.snackbar('Filters Applied', 'Your filters have been applied successfully');
  }

  void selectTalentType(String type) {
    selectedTalentType.value = type;
  }

  void toggleContractToHire() {
    isOpenToContractToHire.value = !isOpenToContractToHire.value;
  }

  void toggleConsultations() {
    offersConsultations.value = !offersConsultations.value;
  }

  void toggleCategoryExpansion() {
    isCategoryExpanded.value = !isCategoryExpanded.value;
  }

  void toggleSubcategoryExpansion() {
    isSubcategoryExpanded.value = !isSubcategoryExpanded.value;
  }

  void toggleSpecialtyExpansion() {
    isSpecialtyExpanded.value = !isSpecialtyExpanded.value;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    selectedSubcategory.value = '';
    selectedSpecialty.value = '';

    isCategoryExpanded.value = false;
    isSubcategoryExpanded.value = false;
    isSpecialtyExpanded.value = true;

    if (category != 'All categories' && currentCategory != null && currentCategory!.subcategories.isNotEmpty) {
      selectedSubcategory.value = currentCategory!.subcategories.first.name;
    }
  }

  void selectSubcategory(String subcategory) {
    selectedSubcategory.value = subcategory;
    selectedSpecialty.value = '';
    isSubcategoryExpanded.value = false;
    isSpecialtyExpanded.value = true;
  }

  void selectSpecialty(String specialty) {
    selectedSpecialty.value = specialty;
    isSpecialtyExpanded.value = false;
  }

  void toggleCategoriesExpansion(String category) {
    expandedCategories[category] = !(expandedCategories[category] ?? false);
  }

  void selectItem(String category, String item) {
    selectedItems[category] = item;
  }

  bool isItemSelected(String category, String item) {
    return selectedItems[category] == item;
  }

}
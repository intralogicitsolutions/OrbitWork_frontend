import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/filter_model.dart';

class FilterController extends GetxController{

  final experienceLevels = <FilterOption>[
    FilterOption(title: 'Entry Level', count: 13184),
    FilterOption(title: 'Intermediate', count: 116540),
    FilterOption(title: 'Expert', count: 46083),
  ].obs;

  final jobTypes = <FilterOption>[
    FilterOption(title: 'Hourly', count: 111042),
    FilterOption(title: 'Fixed-Price', count: 64876),
  ].obs;

  final priceRanges = <FilterOption>[
    FilterOption(title: 'Less than \$100', count: 28573),
    FilterOption(title: '\$100 to \$500', count: 22472),
    FilterOption(title: '\$500 - \$1k', count: 5870),
    FilterOption(title: '\$1k - \$5k', count: 6400),
    FilterOption(title: '\$5k+', count: 1560),
  ];

  final numberOfProposals = <FilterOption>[
    FilterOption(title: 'Less than 5', count: 38065),
    FilterOption(title: '5 to 10', count: 40807),
    FilterOption(title: '10 to 15', count: 28657),
    FilterOption(title: '15 to 20', count: 19836),
    FilterOption(title: '20 to 50', count: 38132),
  ];

  final clientInfo = <FilterOption>[
    FilterOption(title: 'My previous clients', count: 0),
    FilterOption(title: 'Payment verified', count: 156477),
  ];

  final clientHistory = <FilterOption>[
    FilterOption(title: 'No hires', count: 0),
    FilterOption(title: '1 to 9 hires', count: 48815),
    FilterOption(title: '10+ hires', count: 78370),
  ];

  final projectLength = <FilterOption>[
    FilterOption(title: 'Less than one month', count: 97639),
    FilterOption(title: '1 to 3 months', count: 112513),
    FilterOption(title: '3 to 6 months', count: 73495),
    FilterOption(title: 'more than 6 months', count: 86904),
  ];

  final hoursPerWeek = <FilterOption>[
    FilterOption(title: 'Less than 30 hrs/week', count: 69428),
    FilterOption(title: 'More than 30 hrs/week', count: 94587),
  ];

  final jobDuration = <FilterOption>[
    FilterOption(title: 'Contract-to-hire roles', count: 34403),
  ];


  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  final hourlyMinPriceController = TextEditingController();
  final hourlyMaxPriceController = TextEditingController();


  void toggleExperienceLevel(int index) {
    experienceLevels[index].selected.toggle();
  }

  void toggleJobType(int index) {
    jobTypes[index].selected.toggle();
  }

  void togglePriceRange(int index) {
    priceRanges[index].selected.toggle();
  }

  void toggleNumberOfProposals(int index) {
    numberOfProposals[index].selected.toggle();
  }

  void toggleClientInfo(int index) {
    clientInfo[index].selected.toggle();
  }

  void toggleClientHistory(int index) {
    clientHistory[index].selected.toggle();
  }

  void toggleProjectLength(int index) {
    projectLength[index].selected.toggle();
  }

  void toggleHoursPerWeek(int index) {
    hoursPerWeek[index].selected.toggle();
  }

  void toggleJobDuration(int index) {
    jobDuration[index].selected.toggle();
  }


  void clearFilters() {
    for (var level in experienceLevels) {
      level.selected.value = false;
    }
    for (var type in jobTypes) {
      type.selected.value = false;
    }
    minPriceController.clear();
    maxPriceController.clear();
    hourlyMinPriceController.clear();
    hourlyMaxPriceController.clear();
  }
}
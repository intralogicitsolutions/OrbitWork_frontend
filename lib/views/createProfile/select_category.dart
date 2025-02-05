import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_profile_controller.dart';
import '../../models/category_model.dart';

class SelectCategory extends GetView<ProfilesController> {
  SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person_outline, color: Colors.white),
        ),
        title: const Text(
          'Create Your Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Great, so what kind of work are you here to do?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Don\'t worry, you can change these choices later on.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select 1 category',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Obx(() => Column(
              // children: [
              //   Obx(() => controller.showCategoryWarning.value
              //       ? _buildWarningMessage()
              //       : const SizedBox()),
              //   ...controller.categories.map((category) =>
              //       Obx(() => _buildCategoryTile(category))),
              // ],
              children: controller.categories.map((category) => _buildCategoryTile(category)).toList(),
            )),
            // const SizedBox(height: 16),
            // Obx(() {
            //   return controller.showWarning.value
            //       ? _buildWarningMessage()
            //       : SizedBox.shrink();
            // }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Add skills',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  // Widget _buildCategoryTile(Category category) {
  //   return ExpansionTile(
  //     title: Text(category.name),
  //     children: category.name == 'Accounting & Consulting'
  //         ? [
  //       const Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //         child: Text(
  //           'Now, select 1 to 3 specialties',
  //           style: TextStyle(color: Colors.grey),
  //         ),
  //       ),
  //       ...category.specialties.map((specialty) => _buildSpecialtyCheckbox(specialty)),
  //       if (category.name == controller.selectedCategory.value && controller.selectedSpecialties.length >= 3)
  //                 _buildWarningMessage(),
  //     ]
  //         : [],
  //   );
  // }

  Widget _buildCategoryTile(Category category) {
    bool isSelected = controller.isCategorySelected(category.name);

    return ExpansionTile(
      title: Row(
        children: [
          Text(
            category.name,
            style: const TextStyle(fontSize: 18),
          ),
          if (isSelected && controller.selectedSpecialties.isNotEmpty)
            Text(
              ' (${controller.selectedSpecialtiesCount})',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
        ],
      ),
      onExpansionChanged: (expanded) {
        if (expanded) {
          controller.selectCategory(category.name);
        }
      },
      initiallyExpanded: isSelected,
      children: isSelected && category.specialties.isNotEmpty
          ? [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Now, select 1 to 3 specialties',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),

        ...category.specialties.map(_buildSpecialtyCheckbox),
        if(controller.selectedSpecialties.length > 3)
        _buildWarningMessage(),
      ]
          : [],
    );
  }

  // Widget _buildCategoryTile(Category category) {
  //   return Obx(() => ExpansionTile(
  //     title: Text(category.name),
  //     initiallyExpanded: controller.openedCategory.value == category.name,
  //     onExpansionChanged: (isExpanded) {
  //       if (isExpanded) {
  //         controller.setOpenedCategory(category.name);
  //       }
  //     },
  //     children: [
  //       if (category.name == controller.selectedCategory.value && controller.selectedSpecialties.length >= 3)
  //         _buildWarningMessage(),
  //       const Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //         child: Text(
  //           'Now, select 1 to 3 specialties',
  //           style: TextStyle(color: Colors.grey),
  //         ),
  //       ),
  //       ...category.specialties.map((specialty) => _buildSpecialtyCheckbox(specialty)),
  //     ],
  //   ));
  // }


  // Widget _buildCategoryTile(Category category) {
  //   return Obx(() {
  //     bool isSelected = controller.selectedCategory.value == category.name;
  //     return ExpansionTile(
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(category.name),
  //           // if (isSelected)
  //           //   const Icon(Icons.check_circle, color: Colors.green),
  //         ],
  //       ),
  //       onExpansionChanged: (expanded) {
  //         if (expanded) controller.selectCategory(category.name);
  //       },
  //       children: isSelected
  //           ? [
  //         const Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //           child: Text(
  //             'Now, select 1 to 3 specialties',
  //             style: TextStyle(color: Colors.grey),
  //           ),
  //         ),
  //         ...category.specialties
  //             .map((specialty) => _buildSpecialtyCheckbox(specialty))
  //             .toList(),
  //         if (category.name == controller.selectedCategory.value && controller.selectedSpecialties.length >= 3)
  //           _buildWarningMessage(),
  //
  //       ]
  //           : [],
  //     );
  //   });
  // }




  Widget _buildSpecialtyCheckbox(String specialty) {
    return Obx(() => CheckboxListTile(
      activeColor: Colors.green,
      title: Text(specialty),
      value: controller.selectedSpecialties.contains(specialty),
      onChanged: (_) => controller.toggleSpecialty(specialty),
    ));
  }

  Widget _buildWarningMessage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: const [
          Icon(Icons.info_outline, color: Color(0xFFB7995B)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Select up to 3 specialties. You\'ll be able to change and add to these later on.',
              style: TextStyle(
                color: Color(0xFFB7995B),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

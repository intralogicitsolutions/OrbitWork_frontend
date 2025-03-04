import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/speciality_controller.dart';

class SelectAllSpecialtyBottomsheet extends StatelessWidget{
  final SpecialityController controller = Get.put(SpecialityController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.close)),
        title: Text('Select a Specialty', style: TextStyle(
          fontSize: 18,  fontWeight: FontWeight.w500
        ),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) => controller.updateSearch(value),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              final filteredList = controller.filteredSpecialties;
              return ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredList[index]),
                    onTap: () {
                      controller.setSpecialty(filteredList[index]);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void showSpecialtyBottomSheet() {
    Get.bottomSheet(
      Container(
        height: 400,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => controller.updateSearch(value),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                final filteredList = controller.filteredSpecialties;
                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredList[index]),
                      onTap: () {
                        controller.setSpecialty(filteredList[index]);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true, // Allows full-screen height
    );
  }

}
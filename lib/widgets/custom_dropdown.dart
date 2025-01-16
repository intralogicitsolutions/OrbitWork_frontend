import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdown extends StatelessWidget {
  final RxString selectedCountry = 'India'.obs; // Default selected country

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GestureDetector(
        onTap: () {
          _showFullScreenDropdown(context);
        },
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: selectedCountry.isEmpty ? "Select a country" : selectedCountry.value,
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black), // Set border color to black
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black), // Set the border color when disabled
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black, // Set suffixIcon color to black
                  ),
                ),
              )

          ),
    );
  }

  void _showFullScreenDropdown(BuildContext context) {
    final List<String> countries = ["India", "USA", "UK", "Australia", "Canada"];
    final RxString searchQuery = ''.obs;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9, // Full-screen height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Header with close icon
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select a country',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              // Search bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    searchQuery.value = value.toLowerCase();
                  },
                  decoration: InputDecoration(
                    labelText: "Search",
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              // Country list with radio buttons
              Expanded(
                child: Obx(
                      () {
                    final filteredCountries = countries
                        .where((country) => country.toLowerCase().contains(searchQuery.value))
                        .toList();
                    return ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];
                        return RadioListTile<String>(
                          title: Text(country),
                          value: country,
                          groupValue: selectedCountry.value,
                          onChanged: (value) {
                            selectedCountry.value = value!;
                            Navigator.pop(context); // Close the dropdown after selection
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

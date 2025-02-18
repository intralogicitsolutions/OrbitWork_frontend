import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/profile/add_employment_controller.dart';

class AddEmploymentBottomsheet extends StatelessWidget {
  final AddEmploymentController controller = Get.put(AddEmploymentController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: theme.scaffoldBackgroundColor,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)),
                              Text('Add employment', style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500
                              ),),
                              Spacer(),
                              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Obx(() {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildTextField('Company', controller.company, hintText: 'Ex: Orbitwork'),
                                  _buildTextField('City', controller.city, hintText: 'Enter city'),
                                  _buildTextField('Country', controller.country, hintText: 'Ex: United States'),
                                  _buildTextField('Title', controller.title, hintText: 'Ex: Senior Software Engineer'),
                                  _buildTextField('Month', controller.month, hintText: 'From, month',
                                      suffix: Icon(Icons.keyboard_arrow_down_outlined)),
                                  _buildTextField('Year', controller.year, hintText: 'From, year',
                                    suffix: Icon(Icons.keyboard_arrow_down_outlined),
                                  ),
                                  if (!controller.isChecked.value) ...[
                                    _buildTextField('Through Month', controller.throughMonth, hintText: 'Through, month',
                                      suffix: Icon(Icons.keyboard_arrow_down_outlined),
                                    ),
                                    _buildTextField('Through Year', controller.throughYear, hintText: 'Through, year',
                                      suffix: Icon(Icons.keyboard_arrow_down_outlined),
                                    ),
                                  ],
                                  Row(
                                    children: [
                                      Obx(() => SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Checkbox(
                                          activeColor: Colors.green,
                                          value: controller.isChecked.value,
                                          onChanged: (bool? newValue) {
                                            print('isChecked value => ${controller.isChecked.value}');
                                            controller.isChecked.value = newValue!;
                                          },
                                        ),
                                      )),
                                      SizedBox(width: 5,),
                                      Text('I currently work here'),
                                    ],
                                  ),
                                  SizedBox( height: 24,),
                                  _buildTextField('Description (Optional)', controller.description,
                                      hintText: 'Enter description', maxLine: 4)
                                ],
                              );
                            }
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom + 16,
                    left: 16,
                    right: 16
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.grey.shade200,
                            foregroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                        ),
                        child: const Text('Save'),
                      ),

                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget _buildTextField(String label, RxString value,
  {String? hintText,
    Widget? suffix,
    int? maxLine,
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,  style: const TextStyle(
          fontSize: 16,
        ),),
        const SizedBox(height: 8),
        Container(
         // height: 40,
          child: TextField(
            onChanged: (text) => value.value = text,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
              suffixIcon: suffix,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            maxLines: maxLine,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
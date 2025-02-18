import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEducationBottomsheet extends StatelessWidget{
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)),
                          Text('Add education', style: TextStyle(
                            fontSize: 20,fontWeight: FontWeight.w500
                          ),),
                          Spacer(),
                          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Degree'),
                            TextField(
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                hintText: 'Ex: Northwestern University',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),

                            _buildLabel('Dates Attended'),
                            Container(
                              height: 48,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: () {
                                  // Implement from date selection
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'From',
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.keyboard_arrow_down, size: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16,),
                            Container(
                              height: 48,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: () {
                                  // Implement from date selection
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'To (or expected graduation year)',
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.keyboard_arrow_down, size: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                            _buildLabel('Degree (Optional)'),
                            Container(
                              height: 48,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: () {
                                  // Implement from date selection
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Degree (Optional)',
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.keyboard_arrow_down, size: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                            _buildLabel('Area of Study (Optional)'),
                            TextField(
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                hintText: 'Ex: Computer Science',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                            _buildLabel('Description (Optional)'),
                            TextField(
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              maxLines: 4,
                            ),
                          ],
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
        ),
      ),
    );
  }

  Widget _buildLabel(String text, [bool isRequired = false]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          children: isRequired
              ? const [
            TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
          ]
              : null,
        ),
      ),
    );
  }

}
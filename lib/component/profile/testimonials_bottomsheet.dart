import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/testimonials_controller.dart';

class TestimonialBottomSheet extends StatelessWidget {
  final controller = Get.put(TestimonialController());

  TestimonialBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Request a client\ntestimonial',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Add your client's contact details. Don't worry—we'll only display their first name and last initial.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField('First name', controller.firstName),
            _buildTextField('Last name', controller.lastName),
            _buildTextField('Business email address', controller.businessEmail),
            _buildTextField(
                "Client's LinkedIn profile", controller.linkedInProfile,
                prefix: 'https://', hintText: ''),
            _buildTextField("Client's title", controller.clientTitle,
                isOptional: true, hintText: 'Ex. Director of Marketing'),
            _buildTextField('Project type', controller.projectType,
                isOptional: true, hintText: 'Ex. Marketing Brand Refresh'),
            _buildTextField('Message to client', controller.messageToClient,
                hintText: 'Enter message', maxLine: 4),
            const SizedBox(height: 16),
            Container(
              height: 40,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                  shape: BoxShape.rectangle),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Request testimonial',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
            ),
            SizedBox(height: 24,),
            Container(
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200]
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/icon/find.png',
                      height: 80,
                      width: 80,
                    ),
                    Text(
                      'Strengthen your profile with client testimonials',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: '✔ ', style: TextStyle(color: Colors.green)),
                        TextSpan(
                          text:
                              'Showcase your skills and success from clients outside of Orbitwork',
                          style: TextStyle(color: Colors.grey[700]),),]),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: '✔ ', style: TextStyle(color: Colors.green)),
                        TextSpan(
                          text:
                          'Your clients will get an email with instructions for submitting your success story',
                          style: TextStyle(color: Colors.grey[700]),),]),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: '✔ ', style: TextStyle(color: Colors.green)),
                        TextSpan(
                          text:
                          'The testimonial will display on your profile once it\'s verified by Orbitwork.',
                          style: TextStyle(color: Colors.grey[700]),),]),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     color: Colors.grey[100],
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Column(
            //     children: [
            //       // Custom illustration widget
            //       CustomIllustration(),
            //       const SizedBox(height: 20),
            //       const Text(
            //         'Strengthen your profile with\nclient testimonials',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       const SizedBox(height: 24),
            //       _buildInfoItem(
            //         'Showcase your skills and successes from clients outside of Upwork',
            //       ),
            //       const SizedBox(height: 16),
            //       _buildInfoItem(
            //         'Your clients will get an email with instructions for submitting your success story',
            //       ),
            //       const SizedBox(height: 16),
            //       _buildInfoItem(
            //         "The testimonial will display on your profile once it's verified by Upwork.",
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, RxString value,
      {bool isOptional = false,
      String? hintText,
      String prefix = '',
      int? maxLine,
      Widget? suffix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isOptional)
              const Text(
                ' Optional',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          //height: 40,
          child: TextField(
            onChanged: (text) => value.value = text,
            decoration: InputDecoration(
              hintText: hintText,
              prefixText: prefix,
              suffix: suffix,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            maxLines: maxLine,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
  Widget _buildInfoItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle,
          color: Colors.green[600],
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}



class CustomIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.green[50],
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.person,
            size: 40,
            color: Colors.green[300],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.search,
                size: 24,
                color: Colors.green[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

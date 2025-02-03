import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/tax_form_controller.dart';

class TaxFormsPage extends StatelessWidget {
  final TaxFormsController controller = Get.put(TaxFormsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tax forms'),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tax forms',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                margin: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Tax forms',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                'Tax information',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          text:
                              'For more details, such as your tax residence and indentification, go to ',
                      style: TextStyle(color: Colors.grey)
                      ),
                      TextSpan(
                        text: 'tax information',
                        style: TextStyle(
                            color: Colors.green[600],
                            decoration: TextDecoration.underline),
                      ),
                      const TextSpan(text: '.'),
                    ])),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
               'W-8BEN',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 24,
              ),
              Obx(
                () => Column(
                  children: controller.taxForms
                      .map(
                        (form) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   form.formType,
                            //   style: TextStyle(
                            //       fontSize: 20, fontWeight: FontWeight.w500),
                            // ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      form.year,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      'Submitted on ${form.submissionDate}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800]),
                                    )
                                  ],
                                ),
                                OutlinedButton(
                                  onPressed: () => controller.viewTaxForm(form),
                                  style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.green[600],
                                      side: BorderSide(color: Colors.green[600]!),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text('View'),
                                ),
                              ],
                            ),
                            Divider(height: 32.0,)
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 24,),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Orbitwork Community',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Find all the answers you need on local taxes and service fees in your hub',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 16,),
                    Icon(Icons.description,
                      color: Colors.green[700],
                      size: 32,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

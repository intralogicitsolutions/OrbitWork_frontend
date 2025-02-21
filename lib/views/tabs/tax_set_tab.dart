import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/notification_settings_controller.dart';

class TaxSetTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.put(NotificationSettingsController());
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 16.0, right: 16.0, left: 16.0),
      child: GestureDetector(
        onTap: () {
          showBottomsheet(context);
        },
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => SizedBox(
                  height: 24,
                  child: Checkbox(
                    activeColor: Colors.green,
                    value: controller.receiveTax.value,
                    onChanged: (bool? value) {
                      if (value != null) controller.toggleReceiveTax(value);
                    },
                  ),
                )),
                Expanded(child: Text('I want to receive tax documents digitally (including Form 1099-k)')),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showBottomsheet(BuildContext context){
    final theme = Theme.of(context);
    Get.bottomSheet(
      Container(
        color: theme.scaffoldBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Electronic consent', style: TextStyle(
                            fontWeight: FontWeight.w500,fontSize: 20
                          ),),
                          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close))
                        ],
                      ),
                      SizedBox(height: 16,),
                      Text('To receive your tax documents digitally:'),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(Icons.circle, size: 8,),
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            child: RichText(text: TextSpan(
                              style: TextStyle(
                                color: theme.secondaryHeaderColor,
                                height: 1.5, fontSize: 16, fontWeight: FontWeight.w300
                              ),
                              children: [
                                TextSpan(
                                  text: 'You acknowledge that you have read, understand, and affirmatively agree to this '
                                ),
                                TextSpan(text: 'consent.',style: TextStyle(
                                  color: theme.primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: theme.primaryColor
                                )),
                                TextSpan(text: ' You consent that you can access electronic tax statements and documents(including Form 1099-k). This includes the ability to access, retain, and print these documents.'),
                              ]
                            )),
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(Icons.circle, size: 8,),
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            child: Text('You agree that the information may be communicated through email or by posting statements, notices, or disclosures on the account page of our website.',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300
                            ),
                            )
                          ),
                        ],
                      ),
                      SizedBox( height: 16,),
                      Text('Your consent is effective until withdrawn:'),
                      SizedBox(height: 16,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(Icons.circle, size: 8,),
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            child: Text('If you don\'t specifically consent to the electronic delivery of tax-related documents, or wish to withdraw this consent, you may do so by opting out here within the notification setting page.',
                            style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300
                            ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(Icons.circle, size: 8,),
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            child: Text('Should you choose to refuse or withdraw consent, you\'ll receive paper copies of all required tax-related documents (including Form 1099-k) at your tax residence address at the time these documents will be delivered.',
                            style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(onPressed: () {Get.back();},
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                          side: BorderSide.none,
                        ),
                        child: Text('Cancel',style: TextStyle(
                            color: theme.primaryColor
                        ),)),
                  ),
                  Expanded(
                    child: ElevatedButton(onPressed: () {Get.back();},
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            )
                        ),
                        child: Text('I agree', style: TextStyle(
                            color: Colors.white
                        ),)),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';

import '../component/add_extra_layres_security_bottomsheet.dart';
import '../component/security_question_bottomsheet.dart';
import '../models/withdrawal_method.dart';
import '../routes/app_routes.dart';

class GetPaidController extends GetxController{
   var price = 0.00.obs;
   var pending = 0.00.obs;
   var ifscCode = ''.obs;
   var swiftCode = ''.obs;
   var errorMessage = ''.obs;

   final RxString selectAccountType = ''.obs;


   final List<WithdrawalMethod> methods = [
      WithdrawalMethod(
         title: 'PayPal',
         icon: 'paypal_icon.png',
         details: [
            '\$2 USD Upwork withdrawal fee',
            'PayPal may charge additional fees for sending and withdrawing funds',
            'Set up will take you to PayPal'
         ],

         isBank: false,
      ),
      WithdrawalMethod(
         title: 'Wire Transfer (USD)',
         icon: 'bank_icon.png',
         details: [
            '\$50 USD per wire to any bank',
            'Up to 7 business days to receive funds'
         ],

      ),
      WithdrawalMethod(
         title: 'Direct to U.S. Bank (USD)',
         icon: 'bank_icon.png',
         details: [
            'Free deposits to U.S. banks',
            'Deposit to a U.S. bank account in USD'
         ],

      ),
   ];

   void setBankAccount(String value){
      selectAccountType.value = value;
      Get.back();
   }

   void setupWithdrawalMethod(String methodTitle) {
      int index = methods.indexWhere((m) => m.title == methodTitle);

      Get.back();

      switch (index) {
         case 0:
            Get.bottomSheet(Container(
               height: Get.height,
      child: AddExtraLayersSecurityBottomsheet()), isDismissible: true, isScrollControlled: true);
            break;
         case 1:
            Get.toNamed(AppRoutes.directToLocalBank, arguments: true);
            break;
         case 2:
            Get.toNamed(AppRoutes.addBankAccount);
            break;
         default:
            Get.toNamed(AppRoutes.directToLocalBank);
      }
   }



   void validateIFSC(String name) {
      if (ifscCode.value.trim().isEmpty || swiftCode.value.trim().isEmpty) {
         errorMessage.value = "Please enter your bank's $name code";
      } else {
         errorMessage.value = "";
         // Perform search operation
      }
   }
}
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../repository/api/helper/payment_api_helper.dart';
//
//
// class PaymentController extends GetxController {
//   RxBool isLoading = false.obs;
//
//   Future<void> startCheckout() async {
//     isLoading.value = true;
//     final url = await PaymentAPI.createCheckoutSession();
//     isLoading.value = false;
//
//     if (url != null) {
//       if (await canLaunchUrl(Uri.parse(url))) {
//         await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//       } else {
//         Get.snackbar('Error', 'Could not launch payment page');
//       }
//     } else {
//       Get.snackbar('Error', 'Failed to create checkout session');
//     }
//   }
//
//   Future<void> startSubscription(String plan) async {
//     isLoading.value = true;
//     final url = await PaymentAPI.createSubscription(plan);
//     isLoading.value = false;
//
//     if (url != null) {
//       if (await canLaunchUrl(Uri.parse(url))) {
//         await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//       } else {
//         Get.snackbar('Error', 'Could not launch subscription page');
//       }
//     } else {
//       Get.snackbar('Error', 'Failed to create subscription');
//     }
//   }
// }

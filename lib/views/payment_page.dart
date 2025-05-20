// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/payment_controller.dart';
//
// class PaymentPage extends StatelessWidget {
//   final PaymentController controller = Get.put(PaymentController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Stripe Payment')),
//       body: Obx(() => Center(
//         child: controller.isLoading.value
//             ? CircularProgressIndicator()
//             : Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: controller.startCheckout,
//               child: Text('One-Time Checkout'),
//             ),
//             ElevatedButton(
//               onPressed: () => controller.startSubscription('premium'),
//               child: Text('Subscribe: Premium'),
//             ),
//             ElevatedButton(
//               onPressed: () => controller.startSubscription('pro'),
//               child: Text('Subscribe: Pro'),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }

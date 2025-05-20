// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:orbitwork/repository/api/api_constants.dart';
//
// class PaymentAPI {
//   static const String baseUrl = 'https://your-backend-url.com'; // change to your backend URL
//
//   static Future<String?> createCheckoutSession() async {
//     final url = Uri.parse('${ApiConstants.BASE_URL}/create-checkout-session');
//     final response = await http.post(url);
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['url'];
//     } else {
//       print('Checkout session failed: ${response.body}');
//       return null;
//     }
//   }
//
//   static Future<String?> createSubscription(String plan) async {
//     final url = Uri.parse('${ApiConstants.BASE_URL}/create-subscription');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'plan': plan}),
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['url'];
//     } else {
//       print('Subscription failed: ${response.body}');
//       return null;
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:orbitwork/repository/api/api_constants.dart';
import 'package:orbitwork/repository/api/helper/webview_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../global/tokenStorage.dart';

class Subscriptionpage extends StatelessWidget {
  final String apiUrl = '${ApiConstants.CREATE_SUBSCRIPTION}';


   Subscriptionpage({super.key}); // Replace with your ngrok or backend URL

  Future<void> createSubscriptionSession(String plan) async {
    String? token = await TokenStorage.getToken();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
        body: jsonEncode({'plan': plan}),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final url = body['url'];

        // if (url != null && await canLaunchUrl(Uri.parse(url))) {
        //   await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        // }
        if (url != null) {
          // Navigate to WebView page using GetX
          Get.to(() => WebViewPage(url: url));
        }
        else {
          Get.snackbar('Error', 'Invalid URL returned');
          throw 'Could not launch $url';
        }
      } else {
        print('Server error: ${response.body}');
        Get.snackbar('Server Error', response.body);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void showPlanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Choose Plan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SubscriptionOption(title: 'Free', plan: 'free', onSelected: () {
              Navigator.pop(ctx);
              createSubscriptionSession('free');
            }),
            SubscriptionOption(title: 'Premium', plan: 'premium', onSelected: () {
              Navigator.pop(ctx);
              createSubscriptionSession('premium');
            }),
            SubscriptionOption(title: 'Pro', plan: 'pro', onSelected: () {
              Navigator.pop(ctx);
              createSubscriptionSession('pro');
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Subscription Plan")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => showPlanDialog(context),
          child: Text("Subscribe Now"),
        ),
      ),
    );
  }
}

class SubscriptionOption extends StatelessWidget {
  final String title;
  final String plan;
  final VoidCallback onSelected;

  const SubscriptionOption({
    Key? key,
    required this.title,
    required this.plan,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onSelected,
    );
  }
}
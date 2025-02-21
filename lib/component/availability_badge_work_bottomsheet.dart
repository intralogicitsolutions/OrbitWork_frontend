import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AvailabilityBadgeWorkBottomsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How availability badge works',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
              Divider(
                height: 32,
              ),
              Text(
                'Where does the badge appear?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Clients will see your availability badge on search results, recommendations, and on your profile.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'How do you use my Connects?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'We\'ll only charge you for the time you have the badge on. We will deduct one connect at a time.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'The price to turn on the badge may go up or down depending on how many people have it on',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'We\'ll let you know if we change the number of Connects it takes to have the badge on',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'What does "My maximum" mean',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'you can set the total number of Connects per week you\'d like to use on the badge.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16,),
              Text(
                'How many Connects do I have?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: theme.secondaryHeaderColor,
                          height: 1.5,
                          fontSize: 16),
                      children: [
                    TextSpan(text: 'You can view your Connects '),
                    TextSpan(
                        text: 'balance and history',
                        style: TextStyle(
                            color: theme.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(AppRoutes.buyConnects);
                        },
                    ),
                    TextSpan(text: ' You can also '),
                    TextSpan(
                        text: 'buy more Connects',
                        style: TextStyle(
                            color: theme.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.primaryColor)),
                    TextSpan(text: ' if you need them.'),
                  ])),
              SizedBox(
                height: 16,
              ),
              Text(
                'Why can\'t I turn on my badge?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'If you profile visibility is set to private, then Clients won\'t find you in search results or see the badge.',
                style: TextStyle(fontSize: 16),
              ),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: theme.secondaryHeaderColor,
                          height: 1.5,
                          fontSize: 16),
                      children: [
                    TextSpan(
                        text:
                            'If you have 0 Connects, we turn the badge off for you. '),
                    TextSpan(
                        text: 'Buy Connects',
                        style: TextStyle(
                            color: theme.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.primaryColor)),
                    TextSpan(
                        text:
                            ' or wait until the beginning of each month when we send you some for free.',
                        style: TextStyle(fontSize: 16))
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}

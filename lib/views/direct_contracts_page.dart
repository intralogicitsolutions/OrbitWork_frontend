import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../comms/url_launcher_helper.dart';

class DirectContracts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Direct Contracts - Orbitwork',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icon/paper-plane.png',
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(height: 16,),
                      Text(
                        'Direct Contracts',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                          'Securely create contracts and quickly collect payment for non-Orbitwork projects.'),
                      SizedBox(
                        height: 16,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding:
                                    EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                                side: BorderSide(color: theme.primaryColor, width: 2),
                                foregroundColor: theme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.ios_share_outlined, color: theme.primaryColor,),
                                  SizedBox(width: 5,),
                                  Text('Share profile'),
                                ],
                              ),
                            ),
                            SizedBox(width: 5.0,),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                'Create a contract',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text('How it works', style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500
                      ),),
                      SizedBox(
                        height: 24,
                      ),
                      _buildHowWorks('1', Colors.red, 'Create and send a contract to your non-Orbitwork client.'),
                      _buildHowWorks('2', Colors.yellow.shade500, 'Your client creates an account to accept the contract and then ', richText: 'funds the project'),
                      _buildHowWorks('3', Colors.lightGreen, 'You\'ll get paid when you complete the work.'),
                      SizedBox(height: 24,),
                      Text('Why use Direct Contracts?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 24,),
                      _buildContracts('assets/icon/dollar.png', '5% service fee *waived for', richText: 'Freelancer Plus subscribers'),
                      _buildContracts('assets/icon/wallet.png', 'Get paid securely'),
                      _buildContracts('assets/icon/computer-worker.png', 'Client feedback counts toward your Job Success Score'),
                      _buildContracts('assets/icon/customer-service.png', 'Dispute assistance'),
                      Divider(color: Colors.grey[300],
                       height: 32,
                      ),
                      Text('Try Direct Contracts', style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 24,),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                          ),
                          child: Text('Create a contract', style: TextStyle(
                            color: Colors.white
                          ),))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24,),
              RichText(text: TextSpan(
                style: TextStyle(
                  color: Get.theme.secondaryHeaderColor, fontSize: 16
                ),
                children: [
                  TextSpan(text: 'Learn more about '),
                  TextSpan(text: 'Direct Contracts', style: TextStyle(
                    color: Get.theme.primaryColor, decoration: TextDecoration.underline,
                    decorationColor: Get.theme.primaryColor,
                  ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => UrlLauncherHelper.openUrl('https://www.google.com'),
                  ),
                ],
              ),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHowWorks(String number, Color color, String title,
      {String? richText}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 50.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number,style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500
          ),),
          SizedBox(width: 5.0,),
          Padding(
            padding: const EdgeInsets.only(top: 15.0,right: 2.0),
            child: Icon(Icons.square, size: 8, color: color,),
          ),
          Expanded(
            child: RichText(text: TextSpan(
              style: TextStyle(
                fontSize: 16, height: 1.5, color: Get.theme.secondaryHeaderColor
              ),
              children: [
                TextSpan(
                  text: title
                ),
                TextSpan(
                  text: richText ?? '', style: TextStyle(
                  color: Get.theme.primaryColor, decoration: TextDecoration.underline,
                  decorationColor: Get.theme.primaryColor
                )
                )
              ]
            )),
          )
        ],
      ),
    );
  }

  Widget _buildContracts(String image, String text, {String? richText}){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 70,
            width: 70,
          ),
          SizedBox(height: 12,),
          Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Get.theme.secondaryHeaderColor,
              fontSize: 18, fontWeight: FontWeight.w500,
          ),),
          richText != null ?Text(richText ?? '', style: TextStyle(
              color: Get.theme.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: Get.theme.primaryColor
          ),): SizedBox(),
        ],
      ),
    );
  }
}

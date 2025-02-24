import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/buy_connects_controller.dart';

class AddedBadgeBottomsheet extends StatelessWidget{
  final BuyConnectsController controller = Get.put(BuyConnectsController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        return controller.handleBackPress();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icon/done.png',
                          height: 120,
                          width: 120,
                        ),
                        SizedBox(height: 16,),
                        Text('You\'ve added the badge!', style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w500,
                        ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text('Clients will see your availability badge on search results, recommendations, and on your profile.',
                        style: TextStyle(
                         fontSize: 16
                        ),),
                        SizedBox(height: 24,),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                          side: BorderSide(color: theme.primaryColor, width: 2),
                          foregroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                          Get.back();
                        }, child: Text('Got it', style: TextStyle(
                        color: theme.primaryColor,
                      ),),),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: theme.primaryColor,
                          minimumSize: const Size(40, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('View My Profile', style: TextStyle(
                            color: Colors.white
                        ),),),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
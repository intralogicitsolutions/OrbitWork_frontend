import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/component/number_of_connects_bottomsheet.dart';
import 'package:orbitwork/controllers/buy_connects_controller.dart';

class BuyConnects extends StatelessWidget {
  final BuyConnectsController controller = Get.put(BuyConnectsController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buy Connects',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Colors.grey)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => controller.showWarning.value
                    ? _buildConnectsContainer(context)
                    : SizedBox()),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Buy Connects',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Your available Connects',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text('0'),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Select the amount to buy',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8,),
                      SizedBox(
                        height: 40,
                        child: Obx(() {
                            return TextField(
                              readOnly: true,
                              onTap: () {
                                Get.bottomSheet(
                                    Container(
                                      height: Get.height * 0.6,
                                      child: NumberOfConnectsBottomsheet(),
                                    ),
                                    isScrollControlled: true,
                                    isDismissible: true);
                              },
                              controller: TextEditingController(text: controller.selectConnects.value),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                suffixIcon: Icon(Icons.keyboard_arrow_down_rounded)
                              ),
                            );
                          }
                        ),
                      ),
                      SizedBox(height: 24,),
                      Obx(() {
                        String selectedText = controller.selectConnects.value;
                        String price = selectedText.split(' for ')[1];
                          return _buildTextData('Your account will be charged', '$price + Tax');
                        }
                      ),
                      _buildTextData('Your new Connects balance will be', '100'),
                      _buildTextData('These Connects will expire on', 'February 224, 2026'),
                      Text('Promo code', style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 8,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter code',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      SizedBox(
                        width: Get.width,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: theme.primaryColor, width: 2),
                              foregroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {}, child: Text('Apply', style: TextStyle(
                          color: theme.primaryColor,
                        ),)),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text('Unused Connects rollover to the next month.', style: TextStyle(
                        fontSize: 16, color: Colors.grey[600]
                      ),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConnectsContainer(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 242, 247, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: theme.secondaryHeaderColor, height: 1.5),
                      children: [
                    TextSpan(
                        text:
                            'Get 100 monthly Connects and full access to Uma, Orbitwork\'s Mindful AI, to help get work done.Chosen by the best, 40% of subscribers are Top Rated Plus. Upgrade to Freelancer Plus. '),
                    TextSpan(
                        text: 'Upgrade Plan',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: theme.secondaryHeaderColor))
                  ])),
            ),
            Image.asset(
              'assets/icon/agenda.png',
              height: 50,
              width: 50,
            ),
            SizedBox(
              height: 24,
              width: 30,
              child: IconButton(
                onPressed: controller.dismissWarningText,
                icon: Icon(Icons.close),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextData(String title, String subTitle){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        SizedBox(height: 12,),
        Text(subTitle, style: TextStyle(
          fontSize: 16, color: Colors.grey[600]
        ),),
        SizedBox(height: 24,),
      ],
    );
  }
}

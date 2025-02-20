import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/get_paid_controller.dart';

class DirectToLocalBank extends StatelessWidget {
  final bool? wireTransfer;
  final GetPaidController controller = Get.put(GetPaidController());

  DirectToLocalBank({Key? key, this.wireTransfer = false, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          wireTransfer == true ? 'Wire transfer' : 'Direct to local bank',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [Icon(Icons.more_vert)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 16, color: theme.secondaryHeaderColor),
                    children: [
                  TextSpan(
                    text: 'Send funds directly to your bank. ',
                  ),
                  TextSpan(
                    text: 'Learn how this payment method works',
                    style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: theme.primaryColor),
                  ),
                ])),
            SizedBox(
              height: 16,
            ),
            Text(
              'Bank information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 16,
            ),
            Text(wireTransfer == true ? 'SWIFT code':'IFSC code'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ),
                          if (controller.errorMessage.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 4, left: 4),
                              child: Text(
                                controller.errorMessage.value,
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      );
                    }
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                    onPressed: () {
                      controller.validateIFSC(wireTransfer == true ? 'SWIFT' : 'IFSC');
                    },
                    style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                      side: BorderSide(color: Colors.grey.shade300, width: 2),
                      foregroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(color: theme.primaryColor),
                    ))
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor: theme.scaffoldBackgroundColor,
                          title: const Text('Something\'s wrong'),
                          content: const Text('Couldn\'t complete your request.'),
                          actions: [
                            ElevatedButton(
                              onPressed: () => Get.back(),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.green,
                                minimumSize: const Size(40, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text('OK',style: TextStyle(color: Colors.white),),)
                          ],
                        )
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                      side: BorderSide(color: Colors.green, width: 2),
                      foregroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.grey.shade200,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

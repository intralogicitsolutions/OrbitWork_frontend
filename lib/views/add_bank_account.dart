import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/component/select_bank_account_bottomsheet.dart';
import 'package:orbitwork/controllers/get_paid_controller.dart';

class AddBankAccount extends StatelessWidget {
  final GetPaidController controller = Get.put(GetPaidController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a bank account',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [Icon(Icons.more_vert)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: theme.secondaryHeaderColor),
                      children: [
                    TextSpan(
                        text:
                            'Get access to your funds in 3-5 business days with no fees. '),
                    TextSpan(
                        text: 'See how bank transfers work',
                        style: TextStyle(
                          color: theme.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: theme.primaryColor,
                        ))
                  ])),
              SizedBox(
                height: 16,
              ),
              Text(
                'Incorrect information can mean a delay in receiving funds or fees.',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _buildTextfield('Account holder name'),
              Obx(() {
                  return _buildTextfield(
                    'Account Type',
                    readOnly: true,
                    controllerText: controller.selectAccountType.value,
                    suffix: Icon(Icons.keyboard_arrow_down),
                    onTap: () {
                      Get.bottomSheet(
                          Container(
                            height: Get.height * 0.6,
                            child: SelectBankAccountBottomsheet(),
                          ),
                          isScrollControlled: true,
                          isDismissible: true);
                    },
                  );
                }
              ),
              _buildTextfield('Routing number'),
              _buildTextfield('Account number'),
              _buildTextfield('Confirm account number'),
              SizedBox(
                height: 16,
              ),
              Text(
                'By adding this bank account you are confirming that you are the owner and have full authorization to this bank account.',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'This payment method will become active in 3 days',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Get.dialog(AlertDialog(
                        backgroundColor: theme.scaffoldBackgroundColor,
                        title: const Text('Somthing\'s wrong'),
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
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ));
                    },
                    style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                      side: BorderSide(color: theme.primaryColor, width: 2),
                      foregroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: theme.primaryColor,
                        minimumSize: const Size(double.infinity, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Add bank account',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextfield(
    String title, {
    String? hintText,
    Widget? suffix,
    VoidCallback? onTap,
    bool readOnly = false,
    String? controllerText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 8),
        TextField(
          readOnly: readOnly,
          controller:
              TextEditingController(text: controllerText),
          onTap: readOnly ? onTap : null,
          decoration: InputDecoration(
            hintText: hintText ?? '',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            suffixIcon: suffix,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

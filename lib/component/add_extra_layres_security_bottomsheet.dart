import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/component/security_question_bottomsheet.dart';
import 'package:orbitwork/controllers/add_extra_layers_security_controller.dart';

class AddExtraLayersSecurityBottomsheet extends StatelessWidget{
  final AddExtraLayersSecurityController controller = Get.put(AddExtraLayersSecurityController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.close)),
            Text('Add extra layers of security', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('You\'ll be prompted to enter your unique password and security answer when we need to verify your identity. So be sure to choose a password and answer that only you will know.',
                    style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 12,),
                    Text('Tips for creating a stronger password', style: TextStyle(
                      fontSize: 16,
                      color: theme.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: theme.primaryColor
                    ),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('New password', style: TextStyle(fontSize: 16),),
                        Row(
                          children: [
                            Obx(() => SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                activeColor: Colors.green,
                                value: controller.showPassword.value,
                                onChanged: (bool? newValue) {
                                  controller.showPassword.value = newValue!;
                                },
                              ),
                            )),
                            SizedBox(width: 5,),
                            Text('Show password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Container(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12)
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Strong', style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500, color: theme.primaryColor
                        ),),
                        Row(
                          children: [
                           Wrap(
                             children: [
                               Icon(Icons.close, color: Colors.yellow,size: 20,),
                               Text('Numbers', style: TextStyle(color: Colors.grey[600]),)
                             ],
                           ),
                            SizedBox(width: 10,),
                            Wrap(
                              children: [
                                Icon(Icons.close, color: Colors.yellow,size: 20,),
                                Text('Symbols', style: TextStyle(color: Colors.grey[600]),)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    _buildTextfield('Confirm New Password'),
                    Divider(height: 48, color: Colors.grey[300],),
                    _buildTextfield('Select Security Question',
                        readOnly: false,
                        hintText: 'Your elementary school mascot',
                        onTap: () {
                          Get.bottomSheet(
                              Container(
                                  height: Get.height * 0.8,
                                  child: SecurityQuestionBottomsheet()),
                              isDismissible: true,
                              isScrollControlled: true
                          );
                        },
                        suffix: Icon(Icons.keyboard_arrow_down_outlined,)),
                    SizedBox(height: 20,),
                    _buildTextfield('Answer'),
                    SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            activeColor: Colors.green,
                            value: controller.isLocked.value,
                            onChanged: (bool? newValue) {
                              controller.isLocked.value = newValue!;
                            },
                          ),
                        )),
                        SizedBox(width: 5,),
                        Expanded(child: Text('I understand my account will be locked if I am unable to answer this question',
                        style: TextStyle(
                          fontSize: 16, color: Colors.grey[700]
                        ),
                        )),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Obx(() => SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            activeColor: Colors.green,
                            value: controller.isLogged.value,
                            onChanged: (bool? newValue) {
                              controller.isLogged.value = newValue!;
                            },
                          ),
                        )),
                        SizedBox(width: 5,),
                        Text('Keep me logged in on this device', style: TextStyle(fontSize: 16, color: Colors.grey[700]),),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 16,left: 16,
              // bottom: MediaQuery.of(context).viewPadding.bottom + 16,
            ),
            child: Container(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child:
                       ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                        ),
                        child: const Text('Save'),
                      ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextfield(String title , {
    String? hintText,
    Widget? suffix,
    VoidCallback? onTap,
    bool? readOnly = true,
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(
          fontSize: 14
        ),),
        SizedBox(height: 8,),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 40,
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 14, color: Colors.grey
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                suffixIcon: suffix
              ),
            ),
          ),
        ),
      ],
    );
  }
}
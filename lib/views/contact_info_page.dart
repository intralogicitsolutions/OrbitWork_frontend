import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/contact_info_controller.dart';
import '../routes/app_routes.dart';

class ContactInfoPage extends StatelessWidget {
  final ContactInfoController controller = Get.put(ContactInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact info'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAccountSection(context),
              Divider(
                height: 32,
              ),
              _buildAdditionalAccountSection(),
              Divider(
                height: 32,
              ),
              _buildLocationSection(context),
              Divider(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => controller.isEditingAccount.value
          ? _buildEditAccountSection(context)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Account',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.dividerColor,
                              // color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: IconButton(
                              onPressed: () {
                                controller.isEditingAccount.value = true;
                              },
                              icon: Icon(
                                Icons.edit_outlined,
                                color: Colors.green,
                                size: 15,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _buildInfoItem('User Id', controller.user.value.userId),
                    _buildInfoItem('Name',
                        '${controller.user.value.firstName} ${controller.user.value.lastName}'),
                    _buildInfoItem('Email', controller.user.value.email),
                    SizedBox(
                      height: 16,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.closeAccount);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Close my account',
                          style: TextStyle(
                              color: Colors.red.shade900,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                  ],
                )
              ],
            ),
    );
  }

  Widget _buildAdditionalAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional accounts',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Creating a new account allows you tpo use Orbitwork in different ways, while still having just one login.',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        SizedBox(
          height: 24,
        ),
        _buildAccountOption(
            'Client Account',
            'Hire, manage and pay as a different company. Each client company has its own freelancers, payment methods and reports.',
            'New Client Account'),
        SizedBox(
          height: 24,
        ),
        _buildAccountOption(
            'Agency Account',
            'Find jobs and earn money as manager of a team of freelancers.',
            'New Agency Account')
      ],
    );
  }

  Widget _buildAccountOption(
      String title, String description, String? buttonText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          description,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        if (buttonText != null) ...[
          SizedBox(
            height: 16,
          ),
          OutlinedButton(
              onPressed: () {
                title == 'Agency Account'
                    ? Get.toNamed(AppRoutes.agencyProfile)
                    : Get.toNamed(AppRoutes.createClientAccount);
              },
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))))
        ]
      ],
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() => controller.isEditingLocation.value
        ? _buildEditLocation(context)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.dividerColor,
                        // color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                        onPressed: () {
                          controller.isEditingLocation.value = true;
                        },
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.green,
                          size: 15,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              _buildInfoItem('Time Zone', controller.user.value.timeZone),
              SizedBox(
                height: 24,
              ),
              _buildInfoItem('Address', _buildFormattedAddress()),
              SizedBox(
                height: 24,
              ),
              _buildInfoItem('Phone', controller.user.value.phone),
            ],
          ));
  }

  String _buildFormattedAddress() {
    final location = controller.user.value;
    return '${location.city}\n${location.city}, ${location.state} ${location.pinCode} \n${location.country}';
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget _buildTextfield(
    String title, {
    String? controllerText,
    String? hintText,
    Widget? suffix,
    Widget? prefix,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          readOnly: readOnly,
          style: TextStyle(fontSize: 13),
          controller: TextEditingController(text: controllerText),
          onTap: readOnly ? onTap : null,
          decoration: InputDecoration(
              hintText: hintText ?? '',
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              suffixIcon: suffix,
              prefixIcon: prefix),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildEditAccountSection(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Icon(
              Icons.account_box_outlined,
              color: theme.primaryColor,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Read our policy on name changes',
              style: TextStyle(
                  color: theme.primaryColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        _buildTextfield('First name',
            controllerText: controller.user.value.firstName),
        _buildTextfield('Last name',
            controllerText: controller.user.value.lastName),
        _buildTextfield('Email', controllerText: controller.user.value.email),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    side: BorderSide(color: theme.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Expanded(
              child: OutlinedButton(
                  onPressed: () {
                    controller.isEditingAccount.value = false;
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    side: BorderSide.none,
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: theme.primaryColor),
                  )),
            )
          ],
        )
      ],
    );
  }

  Widget _buildEditLocation(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 24,),
        _buildTextfield('Time Zone',
            controllerText: controller.user.value.timeZone,
            readOnly: true,
            onTap: () {},
            suffix: Icon(Icons.keyboard_arrow_down)),
        _buildTextfield(
          'Country',
          controllerText: controller.user.value.country,
          readOnly: true,
          onTap: () {},
          suffix: Icon(Icons.keyboard_arrow_down),
        ),
        Text(
            'We take your privacy seriously. Only your city and country will be shared with clients.'),
        SizedBox(
          height: 12,
        ),
        Text(
          'Learn more',
          style: TextStyle(color: theme.primaryColor),
        ),
        SizedBox(
          height: 24,
        ),
        _buildTextfield('Address',
            controllerText: controller.user.value.address),
        _buildTextfield('Address 2 (Apartment, suite, etc',
            hintText: 'Apt/Suite'),
        _buildTextfield(
          'City',
          controllerText: controller.user.value.city,
          prefix: Icon(Icons.search),
          suffix: Icon(Icons.close),
          readOnly: true,
          onTap: () {},
        ),
        _buildTextfield('State/Province',
            controllerText: controller.user.value.state),
        _buildTextfield('ZIP/Postal code',
            controllerText: controller.user.value.pinCode),
        _buildPhoneField(),
        SizedBox(height: 16,),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    side: BorderSide(color: theme.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Expanded(
              child: OutlinedButton(
                  onPressed: () {
                    controller.isEditingLocation.value = false;
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    side: BorderSide.none,
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: theme.primaryColor),
                  )),
            )
          ],
        )
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    // Implement country code picker
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Row(
                      children: [
                        Image.asset('assets/icon/flag-india.png',
                            width: 24, height: 16),
                        const SizedBox(width: 4),
                        Expanded(child: const Icon(Icons.keyboard_arrow_down_rounded)),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  //onChanged: controller.user.value.phone,
                  controller:
                      TextEditingController(text: controller.user.value.phone),
                  decoration: InputDecoration(
                      hintText: 'Enter number',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      // prefixText: '+91 ',
                      suffix: IconButton(
                          onPressed: () {}, icon: Icon(Icons.close))),
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

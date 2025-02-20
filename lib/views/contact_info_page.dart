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
              _buildAccountrSection(context),
              Divider(height: 32,),
              _buildAdditionalAccountSectio(),
              Divider(height: 32,),
              _buildLocationSection(context),
              Divider(height: 32,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountrSection(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
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
                      onPressed: () {},
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
            _buildInfoItem('Name', controller.user.value.name),
            _buildInfoItem('Email', controller.user.value.email),
            SizedBox(height: 16,),
            TextButton(onPressed: () {

            },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text('Close my account',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ))
          ],
        )
      ],
    );
  }

  Widget _buildAdditionalAccountSectio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Additional accounts',
          style:  TextStyle(
            fontSize: 20,
            fontWeight:  FontWeight.w500
          ),
        ),
        SizedBox(height: 8,),

        Text('Creating a new account allows you tpo use Orbitwork in different ways, while still having just one login.',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14
        ),
        ),
        SizedBox(height: 24,),
        _buildAccountOption(
          'Client Account',
            'Hire, manage and pay as a different company. Each client company has its own freelancers, payment methods and reports.',
            'New Client Account'),
        SizedBox(height: 24,),
        _buildAccountOption(
            'Agency Account',
            'Find jobs and earn money as manager of a team of freelancers.',
            'New Agency Account')
      ],
    );
  }



  Widget _buildAccountOption(String title, String description , String? buttonText){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle( fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 8,),
        Text(
          description,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14
          ),
        ),
        if(buttonText != null )...[
          SizedBox(
            height: 16,
          ),
          OutlinedButton(onPressed: () {
            Get.toNamed(AppRoutes.createClientAccount);
          }, child: Text(buttonText,
          style: TextStyle(color: Colors.green,
          ),
          ),
            style: OutlinedButton.styleFrom(
             side: BorderSide(color: Colors.green),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(4)
             )
            )
          )
        ]
      ],
    );
  }

  Widget _buildLocationSection(BuildContext context){
    final theme = Theme.of(context);
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Location',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                  FontWeight.w500
              ),
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.green,
                    size: 15,
                  )),
            ),
          ],
        ),
        SizedBox(height: 24,),
        _buildInfoItem('Time Zone', controller.user.value.timeZone),
        SizedBox(height: 24,),
        _buildInfoItem('Address', _buildFormattedAddress()),
        SizedBox(height: 24,),
        _buildInfoItem('Time Zone', controller.user.value.phone),

      ],
    ));
  }

  String _buildFormattedAddress(){
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 4,),
          Text(
            value,
            style: TextStyle(
                fontSize: 14
            ),
          )
        ],
      ),
    );
  }
}

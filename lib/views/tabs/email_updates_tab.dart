import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/notification_settings_controller.dart';

class EmailUpdatesTabs extends StatelessWidget{
  final NotificationSettingsController controller = Get.put(NotificationSettingsController());
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send email updates to ${controller.userEmail} for the following:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          Text(
            'Recruiting',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Receive recruiting emails for:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(() => ListTile(
              title: Text(controller.selectedJobOption.value),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                // Add dropdown logic here
                showJobsBottomsheet(context);
              },
            )),
          ),
          SizedBox(height: 16),
          Obx(() => _buildSettingsList(
            controller.jobPostingSettings,
            controller.toggleJobPostingSetting,
          )),

          Divider(height: 32),
          Text(
            'Freelancer and agency proposals',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),

          Obx(() => _buildSettingsList(
            controller.proposalSettings,
            controller.toggleProposalSetting,
          )),

          Divider(height: 32),

          Text(
            'Contracts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Receive contract emails for:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(() => ListTile(
              title: Text(controller.selectedFreelancerOption.value),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                showDropdownOptions(context);
              },
            )),
          ),


          Obx(() => _buildSettingsList(
            controller.contractSettings,
            controller.toggleContractSetting,
          )),

          Divider(height: 32),

          // Groups and Invitations Section
          Text(
            'Groups and invitations',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),

          Obx(() => _buildSettingsList(
            controller.groupSettings,
            controller.toggleGroupSetting,
          )),

          Divider(height: 32),

          Text(
            'Membership',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),

          Obx(() => _buildSettingsList(
            controller.membershipSettings,
            controller.toggleMembershipSetting,
          )),
          Divider(height: 32),

          Text(
            'Miscellaneous',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          Obx(() => _buildSettingsList(
            controller.miscellaneousSetting,
            controller.toggleMiscellaneousSetting,
          )),

          Divider(height: 32),
          Text('Project recommendations for our Top Talent', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 16,),
          Obx(() => _buildSettingsList(
            controller.projectSetting,
            controller.toggleProjectSetting,
          )),

          Divider(height: 32),
          Text('Communications from Orbitwork', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 16,),
          Obx(() => _buildSettingsList(
            controller.communicationSetting,
            controller.toggleCommunicationSetting,
          )),
        ],
      ),
    );
  }

  Widget _buildSettingsList(List<Map<String, bool>> settings, Function(int) onToggle) {
    return Column(
      children: List.generate(
        settings.length,
            (index) {
          var setting = settings[index];
          var title = setting.keys.first;
          var isEnabled = setting.values.first;

          return Container(
            //margin: EdgeInsets.symmetric(vertical: 4),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                    child: Checkbox(
                      value: isEnabled,
                      onChanged: (_) => onToggle(index),
                      activeColor: Colors.green,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onToggle(index),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showDropdownOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Only freelancers I hire'),
              onTap: () {
                controller.updateFreelancerOption('Only freelancers I hire');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Freelancers my team and I hire'),
              onTap: () {
                controller.updateFreelancerOption('Freelancers my team and I hire');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showJobsBottomsheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Only jobs I post'),
              onTap: () {
                controller.updateJobOption('Only jobs I post');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Jobs my team and I post'),
              onTap: () {
                controller.updateJobOption('Jobs my team and I post');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

}



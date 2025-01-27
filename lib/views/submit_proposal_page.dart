import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/proposal_controller.dart';
import '../models/proposal_models.dart';

class SubmitProposalPage extends StatelessWidget {
  final ProposalController controller = Get.put(ProposalController());
   SubmitProposalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text('Submit proposal'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Submit a proposal',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              _buildProposalSettings(),
              SizedBox(height: 24),
              _buildJobDetails(),
              SizedBox(height: 24),
              _buildTerms(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProposalSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Proposal settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Obx(() => Text(
          'This proposal requires ${controller.proposal.value.requiredConnects} Connects',
          style: TextStyle(color: Colors.grey[600]),
        )),
        SizedBox(height: 4),
        Obx(() => Text(
          'When you submit this proposal, you\'ll have ${controller.proposal.value.remainingConnects} Connects remaining.',
          style: TextStyle(color: Colors.grey[600]),
        )),
      ],
    );
  }

  Widget _buildJobDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Job details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Obx(() => Text(
          controller.proposal.value.jobTitle,
          style: TextStyle(fontSize: 16),
        )),
        SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Obx(() => Text(
                controller.proposal.value.category,
                style: TextStyle(color: Colors.grey[600]),
              )),
            ),
            SizedBox(width: 8),
            Obx(() => Text(
              'Posted ${controller.proposal.value.postedDate}',
              style: TextStyle(color: Colors.grey[600]),
            )),
          ],
        ),
        SizedBox(height: 8),
        Obx(() => Text(
          controller.proposal.value.description,
          style: TextStyle(color: Colors.grey[800]),
        )),
        TextButton(
          onPressed: () {},
          child: Text('more'),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  Widget _buildTerms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'What is the full amount you\'d like to bid for this job?',
          style: TextStyle(color: Colors.grey[600]),
        ),
        SizedBox(height: 16),
        Text('Bid'),
        Text(
          'Total amount the client will see on your proposal',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 8,),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixText: '\$',
          ),
          keyboardType: TextInputType.number,
          onChanged: controller.updateBid,
        ),
        SizedBox(height: 24),
        Text('10% Freelancer Service Fee'),
        Obx(() => Text(
          '\$${(controller.proposal.value.serviceFee).toStringAsFixed(2)}',
          style: TextStyle(color: Colors.grey),
        )),
        SizedBox(height: 24),
        Text('You\'ll Receive'),
        Text(
          'The estimated amount you\'ll receive after service fees',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Obx(() => Text(
            '\$${(controller.proposal.value.finalAmount).toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.shield, color: Colors.orange),
              SizedBox(width: 8),
              Text('Includes Orbitwork Fixed-Price Protection'),
            ],
          ),
        ),
        SizedBox(height: 24),
        Text('How long will this project take?'),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Select a duration',
          ),
          items: [
            'Less than 1 month',
            '1 to 3 months',
            '3 to 6 months',
            'More than 6 months',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) => controller.updateDuration(value ?? ''),
        ),
        SizedBox(height: 24),
        Text(
          'Additional details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Cover Letter',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Write your cover letter...',
          ),
          maxLines: 6,
          onChanged: controller.updateCoverLetter,
        ),
        SizedBox(height: 24),
        Text(
          'Attachments',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: controller.pickFile,
          icon: Icon(Icons.attach_file, color: Colors.green),
          label: Text(
            'Attach files',
            style: TextStyle(color: Colors.green),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.green),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'You may attach up to 5 files under the size of 25 MB each.\nInclude work samples or other documents to support your application. Do not attach your resume — your Orbitwork profile is automatically forwarded to the client with your proposal.',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 16),

        Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.attachments.length,
          itemBuilder: (context, index) {
            final attachment = controller.attachments[index];
            return ListTile(
              leading: Icon(Icons.insert_drive_file),
              title: Text(attachment.fileName),
              subtitle: Text('${attachment.fileSize.toStringAsFixed(1)} MB'),
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => controller.removeAttachment(index),
              ),
            );
          },
        )),

        SizedBox(height: 24),
        Row(
          children: [
            Text(
              'Profile highlights',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'NEW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Highlight the most relevant items from your profile to demonstrate your experience and skills. You can add up to four highlights total.',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 16),

        Obx(() => controller.showInfoCard.value ? _buildInfoCard() : SizedBox()),

        Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.highlightItems.length,
          itemBuilder: (context, index) {
            final item = controller.highlightItems[index];
            return _buildHighlightItem(item);
          },
        )),
        SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Implement submit proposal
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  'Submit proposal',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.amber, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Show off your best\nwork, easily and\nbeautifully.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: controller.dismissInfoCard,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Portfolios now have more options and a new design.',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextButton(
              onPressed: () {

              },
              //controller.seeWhatsNew,
              child: Text('See what\'s new'),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHighlightItem(HighlightItemModel item) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
        color: item.isEnabled ? Colors.white : Colors.grey[100],
      ),
      child: Row(
        children: [
          Text(
            item.icon,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              item.title,
              style: TextStyle(
                color: item.isEnabled ? Colors.black : Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ),
          // if (item.isEnabled)
          //   Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

}
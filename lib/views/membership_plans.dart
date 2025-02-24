import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembershipPlans extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text('Membership plans'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildBasicPlan(),
            SizedBox(height: 16),
            _buildPlusPlan(),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicPlan() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Basic',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Your current plan',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              )
            ],
          ),
          Text(
            'Free',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Includes:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          _buildFeatureItem('Buy Connects for \$0.15 + Tax each*'),
          _buildFeatureItem('Hourly protection'),
          _buildFeatureItem('Fixed-price protection'),
          _buildFeatureItem(
              '5% service fee when you bring new clients to Upwork through Direct Contracts'),
          _buildFeatureItem('Limited reports and functionality'),
          SizedBox(height: 16),
          Text(
            '*Connects expire one year after purchase date',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlusPlan() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\$19.99 per month*',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Includes everything in Basic and:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          _buildFeatureItem('100 Connects total per month', textColor: Colors.white),
          _buildFeatureItem(
            'Full access to Uma, Upwork\'s Mindful AI to help you get work done',
            textColor: Colors.white,
          ),
          _buildFeatureItemWithLink(
            'New: Get 20% off Microsoft 365 now through April 7, 2025.',
            'Learn more',
            textColor: Colors.white,
          ),
          _buildFeatureItem('View competitor bids for any job', textColor: Colors.white),
          _buildFeatureItem(
            '0% service fee when you bring new clients to Upwork through Direct Contracts',
            textColor: Colors.white,
          ),
          _buildFeatureWithSubItems(
            'Customize your profile',
            [
              'Keep your profile active even when you take a break',
              'Keep your earnings private',
              'Build your brand with a custom profile URL',
            ],
            textColor: Colors.white,
          ),
          SizedBox(height: 20),
          Text(
            '*Sales tax may apply',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'Upgrades unavailable in app',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text, {Color textColor = Colors.black}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check,
            color: textColor == Colors.white ? Colors.white : Colors.green,
            size: 20,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItemWithLink(String text, String linkText, {Color textColor = Colors.black}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check,
            color: textColor == Colors.white ? Colors.white : Colors.green,
            size: 20,
          ),
          SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$text ',
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: linkText,
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                      decoration: TextDecoration.underline,
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

  Widget _buildFeatureWithSubItems(String mainText, List<String> subItems, {Color textColor = Colors.black}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFeatureItem(mainText, textColor: textColor),
        ...subItems.map((item) => Padding(
          padding: EdgeInsets.only(left: 28, bottom: 8),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 4,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: textColor,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
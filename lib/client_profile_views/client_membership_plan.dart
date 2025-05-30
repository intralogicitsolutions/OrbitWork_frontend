import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientMembershipPlans extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership plans'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Membership plans', style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500
              ),),
              SizedBox(
                height: 12,
              ),
              Text('Choose the plan that\'s right for your needs.'),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Marketplace', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400
                    ),),
                    SizedBox(height: 12,),
                    Text('For starting out', style: TextStyle(color: Get.theme.hintColor, fontWeight: FontWeight.w400)),
                    SizedBox(height: 20,),
                    // Text('5% Service fee¹'),
                    RichText(
                      text: TextSpan(
                        text: '5% Service fee',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(2, -6), // moves up and a bit right
                              child: Text(
                                '1',
                                textScaleFactor: 0.7, // smaller size
                                style: TextStyle(color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24,),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.grey.shade200,
                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )
                        ),
                        child: Text('Current plan', style: TextStyle(
                      fontSize: 16, color: Colors.grey
                    ),)),
                    Divider(height: 40,),
                    Text('Marketplace plan includes:',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w300
                    ),),
                    SizedBox(height: 12,),
                    _buildText("Oebitwork's global freelance marketplace"),
                    _buildText("Access to AI-powered features"),
                    _buildText("Collaboration and project tracking tools"),
                    _buildText("Standard reporting"),
                    _buildText("Pay as work is completed")
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Business Plus', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    SizedBox(height: 12,),
                    Text('For growing', style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300
                    ),),
                    SizedBox(height: 24,),
                    RichText(
                      text: TextSpan(
                        text: '10% Service fee',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(2, -6), // moves up and a bit right
                              child: Text(
                                '2',
                                textScaleFactor: 0.7, // smaller size
                                style: TextStyle(color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24,),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.grey.shade200,
                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                          )
                        ),
                        child: Text('Select plan', style: TextStyle(
                          color: Colors.grey
                        ),)
                    ),
                    Divider(height: 40,),
                    Text('Everything in Marketplace, and also:', style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w300
                    ),),
                    SizedBox(height: 12,),
                    Text('TALENT', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    _buildText('Access to pre-screened top 1% of talent'),
                    Text('SUPPORT AND SERVICES', style: TextStyle(
                      fontSize: 16
                    ),),
                    SizedBox(height: 12,),
                    _buildText('Expertly matched talent sourced and shortlisted within 2 business days³'),
                    _buildText('Premium customer support 24/7'),
                    Text('GOVERNANCE', style: TextStyle(
                      fontSize: 16
                    ),),
                    SizedBox(height: 12,),
                    _buildText('Dashboard and reporting insights'),
                    _buildText('Monthly invoicing with Net 30 terms\u2074')
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enterprise', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    SizedBox(height: 12,),
                    Text('For scaling', style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300
                    ),),
                    SizedBox( height: 32,),
                    Text('Contact sales for pricing estimates'),
                    SizedBox(height: 32,),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                            backgroundColor: Get.theme.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        child: Text('Contact sales',style: TextStyle(
                      color: Colors.white
                    ),)),
                    Divider(height: 40,),
                    Text('Everything in Business Plus, and also:', style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w300
                    ),),
                    SizedBox(height: 12,),
                    Text('TALENT', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    _buildText('Diversity certified talent'),
                    Text('SUPPORT AND SERVICES', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    _buildText('Dedicated account team'),
                    _buildText('Program management'),
                    Text('GOVERNANCE', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 12,),
                    _buildText('Hiring approval and talent onboarding workflows'),
                    _buildText('customized reporting and invoicing'),
                    _buildText('SSO and Integrations including VMS, ATS, and HRIS'),
                    _buildText('Compliance services subscription'),
                   ],
                ),
              ),
              SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('1.', style: TextStyle(color: Colors.grey, fontSize: 12),),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(text: TextSpan(
                      style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
                      children: [
                        TextSpan(
                          text: '5% Marketplace fee. Eligible ACH payments discounted to 3%. A '
                        ),
                        TextSpan(text: 'contract initiation fee', style: TextStyle(
                          color: Get.theme.primaryColor,
                        )),
                        TextSpan(text: ' is charged per contract.')
                      ]
                    )),
                  )
                ],),
              ),
             // _buildRowText('1','5% Marketplace fee. Eligible ACH payments discounted to 3%. A contract initiation fee is charged per contract.'),
              _buildRowText('2','10% Business Plus fee. Eligible ACH payments discounted to 8% No contracts initiation fee, with the exception of fixed-price contracts of \$100 USD or less'),
              _buildRowText('3','1 shortlist per job post.'),
              _buildRowText('4','Monthly invoicing with 30-day payment terms for U.S. based companies only, will require an application and approval.'),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildText(String text){
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 8.0, left: 12.0),
            child: Icon(Icons.square, size: 8.0,),
          ),
          Expanded(
              child: Text(text, style: TextStyle(fontSize: 16),))
        ],
      ),
    );
  }

  Widget _buildRowText(String number, String text){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number.',style: TextStyle(fontSize: 12, color: Colors.grey),),
          SizedBox(width: 5,),
          Expanded(child: Text(text,style: TextStyle(fontSize: 12, color: Colors.grey),)),
        ],
      ),
    );
  }
}
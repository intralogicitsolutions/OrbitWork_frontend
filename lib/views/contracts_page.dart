import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/component/earnings_available_bottomsheet.dart';
import 'package:orbitwork/controllers/contracts_controller.dart';
import 'package:orbitwork/widgets/custom_appbar.dart';

import '../component/backend_dev_work_bottomsheet.dart';
import '../routes/app_routes.dart';
import '../widgets/warning_message.dart';

class ContractsPage extends StatelessWidget {
  final ContractController controller = Get.put(ContractController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Contracts'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildWarningMessage(context),
              Obx(() => controller.isShowing.value
                  ? _showNotice()
                  : SizedBox()),
              Obx(() => controller.isVisible.value
                  ? _showUpgradePlan()
                  : SizedBox()),
             // _showUpgradePlan(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Earnings available now:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\$0.00',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.dividerColor,
                        width: 1, // Border thickness
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                            Container(
                                height: Get.height * 0.4,
                                child: EarningsAvailableBottomsheet()),
                            isScrollControlled: true,
                            isDismissible: true);
                      },
                      icon: Icon(
                        Icons.more_horiz_sharp,
                        color: Colors.green,
                        size: 20,
                        // color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                'Activate contracts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 12,
              ),
              _buildNewProject(),
              SizedBox(height: 12,),
              _buildDirectContracts(),
              SizedBox(height: 12,),
              SizedBox(
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 24,
              ),
              DefaultTabController(
                length: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: TabBar(
                        isScrollable: true,
                        labelPadding: EdgeInsets.symmetric(horizontal: 16),
                        tabAlignment: TabAlignment.start,
                        labelColor: theme.primaryColor,
                        unselectedLabelColor: theme.unselectedWidgetColor,
                        indicatorColor: theme.primaryColor,
                        tabs: const [
                          Tab(text: "All"),
                          Tab(text: "Hourly(2)"),
                          Tab(text: "Active Milestones(0)"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Backend Dev work with',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     'Backend Dev work with',
                  //     style: TextStyle(
                  //         color: Colors.green,
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.w500),
                  //   ),
                  // ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.dividerColor,
                        width: 1, // Border thickness
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                            Container(
                                height: Get.height * 0.4,
                                child: BackendDevWorkBottomsheet()),
                            isScrollControlled: true,
                            isDismissible: true);
                      },
                      icon: Icon(
                        Icons.more_horiz_sharp,
                        color: Colors.green,
                        size: 20,
                        // color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text('Hired by Client Name'),
              Text('Client Name'),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      //borderRadius: BorderRadius.zero, //Rectangular border
                    ),
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.normal),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Active',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                      text: '0.00 hrs, \$0.00 ',
                      style: TextStyle(color: Colors.green),
                    ),
                    TextSpan(
                      text: 'this week',
                    ),
                    // TextSpan(text: ', you can signal to clients that you\'re ready for new work now '),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text('Rate: \$0.00/hr, 12 hrs weekly limit'),
              SizedBox(
                height: 12,
              ),
              Text(
                'Sep 26,2024 - Present',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'See timesheet',
                    style: TextStyle(color: Colors.green),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showUpgradePlan() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [Colors.lightGreen.shade100, Colors.lime.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 4.0),
                    child: Icon(
                      Icons.local_offer_outlined,
                    ),
                  ),
                  Text(
                    'Exclusive Freelancer Plus perk',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  IconButton(onPressed: () {
                    controller.hideUpgradePlan();
                  }, icon: Icon(Icons.close)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Text(
                          'Join Freelancer Plus, and work smarter with 20% off an anual Microdoft 365 subsription. Limited time only.',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.membershipPlans);
                          },
                          child: Row(
                            children: [
                              Text(
                                'Upgrade plan',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }

  Widget _showNotice() {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(color: Color(0xFFFFF8E1)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Color(0xFF81770B),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            style:
                                TextStyle(color: Color(0xFF81770B), height: 1.5, fontSize: 16),
                            children: [
                          TextSpan(
                              text:
                                  'All freelancers are required to complete a '),
                          TextSpan(
                              text: 'W9 or a W-8BEN',
                              style: TextStyle(
                                  decoration: TextDecoration.underline)),
                          TextSpan(text: ' from to withdraw money.')
                        ])),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: IconButton(
                      onPressed: () {controller.dismissWarningText();},
                      icon: Icon(
                        Icons.close,
                        color: Color(0xFF81770B),
                      ),
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                ],
              ),
            )),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildNewProject(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('There are no active contracts.',
              textAlign: TextAlign.center,
              style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 16,),
            Text('Contracts you\'re actively working on will appear here.', textAlign: TextAlign.center,),
            SizedBox(height: 16,),
            ElevatedButton(onPressed: () {
            },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                ),
                child: Text('Search for new projects', style: TextStyle(
                  color: Colors.white
            ),))

          ],
        ),
      ),
    );
  }

  Widget _buildDirectContracts(){
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Direct contracts',
              style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 16,),
            Text('Create simple contracts with your non-Orbitwork clients, protected in Escrow, leading to quick payment.', ),
            SizedBox(height: 16,),
            Center(
              child: ElevatedButton(onPressed: () {
                Get.toNamed(AppRoutes.directContracts);
              },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  ),
                  child: Text('Create a direct contract', style: TextStyle(
                      color: Colors.white
                  ),)),
            )
          ],
        ),
      ),
    );
  }
}

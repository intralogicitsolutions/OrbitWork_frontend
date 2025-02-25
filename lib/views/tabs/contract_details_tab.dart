import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../component/request_manual_time_bottomsheet.dart';
import '../../controllers/workroom_timesheet_controller.dart';
import '../../models/contract_activity_model.dart';
import '../../routes/app_routes.dart';

class ContractDetailsPage extends StatelessWidget {
  final bool? showAppbar;
  final controller = Get.put(TimesheetController());

  ContractDetailsPage({Key? key,  this.showAppbar = false,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppbar == true ? AppBar(
        title: Text('Contract details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
        ],
      ): null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() => Text(
                        'Backend Dev work with ${controller.userName}',
                      style: const TextStyle(fontSize: 16),
                    )),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.viewOffer);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Text(
                        'View original offer',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildContractDetailRow('Contract type', controller.contractType),
                    _buildDivider(),
                    _buildContractDetailRow('Rate', controller.rate, isGreen: true),
                    _buildDivider(),
                    _buildContractDetailRow('Rate increase', controller.rateIncrease),
                    _buildDivider(),
                    _buildContractDetailRow('Weekly limit', controller.weeklyLimit),
                    _buildDivider(),
                    _buildManualTimeRow(),
                    _buildDivider(),
                    _buildContractDetailRow('Start date', controller.startDate),
                    _buildDivider(),
                    Obx(() => controller.isShowDetails.value ? _showDetails() : SizedBox()),
                    _buildShowDetailsButton(),
                    SizedBox(height: 24,),
                    _buildRequestFeedback(),
                    SizedBox(height: 24,),
                    _buildActivity(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractDetailRow(String label, Rx<String> value, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Obx(() => Text(
              value.value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isGreen ? Colors.green : Colors.black,
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildManualTimeRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manual time',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
               '${controller.manualTime.value} - ',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )),
             // const Text(' - '),
              TextButton(
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                        height: Get.height * 0.9,
                        child: RequestManualTimeBottomsheet()),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    enableDrag: true,
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Request',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      height: 1,
    );
  }

  Widget _showDetails(){
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Details', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500
          ),),
          _buildContractDetailRow('Verified name', controller.verifiedName),
          _buildDivider(),_buildDivider(),
          _buildContractDetailRow('Contract ID', controller.contractId),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildShowDetailsButton(){
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: OutlinedButton(
          onPressed: () { controller.isShowDetails.value = !controller.isShowDetails.value;},
          style: OutlinedButton.styleFrom(
            padding:
            EdgeInsets.symmetric(vertical: 4, horizontal: 24),
            side: BorderSide(color: Colors.grey.shade300, width: 2),
            foregroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Obx(() {
              return Text(
               // 'Show details',
                controller.isShowDetails.value ? 'Hide details' : 'Show details',
                style: TextStyle(color: Colors.green),
              );
            }
          )),
    );
  }


  Widget _buildRequestFeedback(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/icon/advertising.png',
              height: 50,
              width: 50,
            ),
            SizedBox(height: 16,),
            Text('Share your success on your profile', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 16,),
            Text('Request feedback from your client. The feedback will appear on your profile, and does not impact your Job Success Score.',
            textAlign: TextAlign.center,
            ),
            SizedBox(height: 24,),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.green,
                  minimumSize: const Size(40, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Request feedback', style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }

  Widget _buildActivity(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent activity', style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500
        ),),
        SizedBox(height: 24,),
        Container(
         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Date',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  //textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        Obx(() =>
            Column(
              children: controller.activities.map((activity) =>
                  _buildActivityRow(activity)).toList(),
            )),
      ],
    );
  }

  Widget _buildActivityRow(ContractActivity activity) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            // flex: 2,
            child: Text(
              activity.date,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Text(
                activity.description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Text(
          //     '${transaction.isPositive ? '+' : '-'}\$${transaction.amount
          //         .toStringAsFixed(2)}',
          //     style: TextStyle(
          //       color: transaction.isPositive ? Colors.green : Colors.black,
          //       fontSize: 16,
          //       fontWeight: FontWeight.w500,
          //     ),
          //     textAlign: TextAlign.right,
          //   ),
          // ),
        ],
      ),
    );
  }
}


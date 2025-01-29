import 'package:flutter/material.dart';
import 'package:orbitwork/widgets/custom_appbar.dart';

class ContractsPage extends StatelessWidget {
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
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Earnings available now:',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                      onPressed: () {},
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
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
                  children: [
                    TabBar(
                      labelColor: theme.primaryColor,
                      unselectedLabelColor: theme.unselectedWidgetColor,
                      indicatorColor: theme.primaryColor,
                      tabs: const [
                        Tab(text: "All"),
                        Tab(text: "Hourly(2)"),
                        Tab(text: "Active Milestones(0)"),
                      ],
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
                      onPressed: () {},
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
                height: 20,
              ),
              Text('Hired by Client Name'),
              Text('Client Name'),
              SizedBox(
                height: 24,
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
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(text: '0.00 hrs, \$0.00 ',  style: TextStyle(color: Colors.green),),
                    TextSpan(
                      text: 'this week',
                    ),
                    // TextSpan(text: ', you can signal to clients that you\'re ready for new work now '),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Text('Rate: \$0.00/hr, 12 hrs weekly limit'),
              SizedBox(height: 24,),
              Text('Sep 26,2024 - Present', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'See timesheet', style: TextStyle(color: Colors.green),),
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
}

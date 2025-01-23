import 'package:flutter/material.dart';

class JobAlertsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: theme.hoverColor,
            borderRadius: BorderRadius.circular(10)
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Text(
                "Job alerts",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Be the 1st to apply with instant job alerts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text("30 days of priority job alerts"),
            ),
            ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text("Personalized based on your proposals"),
            ),
            ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text("Sent by email, the Orbitwork mobile app, and right here on orbitwork.com"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 250, 241, 199),
                          borderRadius: BorderRadius.circular(10)
                        ),
                child: Center(
                  child: Row(
                    children: [
                      Text('⚠'),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          " You'll need at least 65 connects to apply for jobs.",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          style: TextStyle(color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
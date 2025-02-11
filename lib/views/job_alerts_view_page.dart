import 'package:flutter/material.dart';

class JobAlertsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                color: theme.hoverColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Job alerts",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,),
                    child: Text(
                      "Be the 1st to apply with instant job alerts",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  customRow(icon: Icons.square, title: "30 days of priority job alerts"),
                  customRow(icon: Icons.square, title: "Personalized based on your proposals"),
                  customRow(icon: Icons.square, title: "Sent by email, the Orbitwork mobile app, and right here on orbitwork.com"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 250, 241, 199),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,  // Aligns content to the center vertically
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('⚠'),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "You'll need at least 65 connects to apply for jobs.",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.visible,
                                style: TextStyle(color: Colors.red),
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
          ),
        ),
      ],
    );

  }
  Widget customRow({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 8),
          SizedBox(width: 8), // Add some space between icon and text
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 14), // You can adjust the text style here
            ),
          ),
        ],
      ),
    );
  }

}
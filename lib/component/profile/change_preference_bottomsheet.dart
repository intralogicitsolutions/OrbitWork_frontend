import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/change_preference_controller.dart';

class ChangePreferenceBottomsheet extends StatelessWidget {
  final controller = Get.put(ChangePreferenceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Get.back(),
      //   ),
      //   title: Text(
      //     'Profile settings',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 20,
      //       fontWeight: FontWeight.w500,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.more_vert, color: Colors.black),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Circular Design
              Center(
                child: CustomPaint(
                  size: Size(200, 200),
                  painter: CircularDesignPainter(),
                ),
              ),
              SizedBox(height: 40),

              // Title
              Text(
                'Update your AI\npreferences',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 24),
              // Description
              Text(
                'Allow your Upwork data to be used for AI training and improvement. Third parties won\'t be able to use this data to train their own models.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16),

              // Learn more link
              Row(
                children: [
                  Text(
                    'You can change this any time. ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Learn more',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),

              // Allow Button
              ElevatedButton(
                onPressed: () {
                  controller.toggleAIData(true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Allow',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                ),
              ),
              TextButton(onPressed: () {}, child: Text('Don\'t Allow',  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.green
              ),))
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painter for the circular design
class CircularDesignPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Draw multiple offset circles to create the spiral effect
    for (var i = 0; i < 12; i++) {
      final path = Path();
      path.addOval(
        Rect.fromCircle(
          center: center,
          radius: radius + (i * 2),
        ),
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
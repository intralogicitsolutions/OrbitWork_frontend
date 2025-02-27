import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/routes/app_routes.dart';

// class BuyMorePage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Orbitwork'),
//         actions: [
//           IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
//         ],
//       ),
//       body: Column(
//         children: [
//           Text('Looking for something?', style: TextStyle(
//             fontSize: 20, fontWeight: FontWeight.w500
//           ),),
//           SizedBox(height: 24,),
//           Text('We can\'t find this page. But we can help you find'),
//           RichText(text: TextSpan(
//             style: TextStyle(
//               color: Get.theme.secondaryHeaderColor
//             ),
//             children: [
//               TextSpan(text: 'new opportunities: '),
//               TextSpan(text: 'hire talent', style: TextStyle(
//                 decoration: TextDecoration.underline,
//                 decorationColor: Get.theme.primaryColor,
//                 color: Get.theme.primaryColor
//               )),
//               TextSpan(text: ', '),
//               TextSpan(text: 'find work'),
//               TextSpan(text: 'or'),
//               TextSpan(text: 'get help', style: TextStyle(
//                   decoration: TextDecoration.underline,
//                   color: Get.theme.primaryColor,
//                   decorationColor: Get.theme.primaryColor,
//               )),
//             ]
//           )),
//           SizedBox(height: 24,),
//           GestureDetector(
//             onTap: () {},
//             child: Text('Go to Homepage', style: TextStyle(
//               color: Get.theme.primaryColor
//             ),),
//           ),
//           Spacer(),
//           Text('Error 404 (N)'),
//           Text('Trace ID: 9188106b4a46ff67-BOM'),
//           SizedBox(height: 24,),
//           Text('© 2015 - 2025 Orbitwork® Global Inc.')
//         ],
//       ),
//     );
//   }
//
// }

class BuyMorePage extends StatelessWidget {
  const BuyMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Orbitwork',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // UFO with cat illustration
              SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // UFO top part (green circle)
                    Positioned(
                      top: 20,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFA3E4B8),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // UFO main part (dark green disk)
                    Positioned(
                      top: 40,
                      child: Container(
                        width: 120,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0e5647),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Light beam
                    Positioned(
                      top: 60,
                      child: ClipPath(
                        clipper: BeamClipper(),
                        child: Container(
                          width: 100,
                          height: 120,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFD9A9D9),
                                Color(0xFFFFD699),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Cat in the beam
                    Positioned(
                      top: 100,
                      child: Container(
                        width: 50,
                        height: 40,
                        child: CustomPaint(
                          painter: CatPainter(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Error message text
              const Text(
                'Looking for something?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'We can\'t find this page. But we can help you find',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        children: [
                      TextSpan(text: 'new opportunities: '),
                      TextSpan(
                          text: 'hire talent',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Get.theme.primaryColor,
                              color: Get.theme.primaryColor)),
                      TextSpan(text: ', '),
                      TextSpan(text: 'find work', style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Get.theme.primaryColor,
                          color: Get.theme.primaryColor) ),
                      TextSpan(text: ' or '),
                      TextSpan(
                          text: 'get help',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Get.theme.primaryColor,
                            decorationColor: Get.theme.primaryColor,
                          )),
                    ])),
              ),
              const SizedBox(height: 24),
              // Homepage button
              ElevatedButton(
                onPressed: () => Get.offNamed(AppRoutes.jobs),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  side: const BorderSide(color: Colors.green),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'Go to Homepage',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              // Error details and copyright
              const Text(
                'Error 404 (N)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Trace ID: 918834ab58636ec8-BOM',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '© 2015 - 2025 Upwork® Global Inc.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              // Bottom indicator
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom clipper for the beam effect
class BeamClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2 - 10, 0);
    path.lineTo(size.width / 2 + 10, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Custom painter for the cat
class CatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Body
    final bodyPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.3,
        size.width * 0.5,
        size.height * 0.4,
      )
      ..quadraticBezierTo(
        size.width * 0.6,
        size.height * 0.3,
        size.width * 0.7,
        size.height * 0.5,
      )
      ..lineTo(size.width * 0.7, size.height * 0.8)
      ..quadraticBezierTo(
        size.width * 0.6,
        size.height * 0.9,
        size.width * 0.5,
        size.height * 0.8,
      )
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.9,
        size.width * 0.3,
        size.height * 0.8,
      )
      ..close();

    canvas.drawPath(bodyPath, paint);

    // Tail
    final tailPath = Path()
      ..moveTo(size.width * 0.7, size.height * 0.6)
      ..quadraticBezierTo(
        size.width * 0.9,
        size.height * 0.4,
        size.width * 0.9,
        size.height * 0.2,
      );

    final tailPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawPath(tailPath, tailPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// // Main app that integrates GetX routes
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Upwork Clone',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       initialRoute: '/404',
//       getPages: [
//         GetPage(name: '/', page: () => const HomePage()),
//         GetPage(name: '/404', page: () => const BuyMorePage()),
//         GetPage(name: '/hire-talent', page: () => const HireTalentPage()),
//         GetPage(name: '/find-work', page: () => const FindWorkPage()),
//         GetPage(name: '/help', page: () => const HelpPage()),
//       ],
//     );
//   }
// }
//
// // Other pages - implement these based on your needs
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Upwork Homepage')),
//       body: const Center(child: Text('Homepage')),
//     );
//   }
// }
//
// class HireTalentPage extends StatelessWidget {
//   const HireTalentPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Hire Talent')),
//       body: const Center(child: Text('Hire Talent Page')),
//     );
//   }
// }
//
// class FindWorkPage extends StatelessWidget {
//   const FindWorkPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Find Work')),
//       body: const Center(child: Text('Find Work Page')),
//     );
//   }
// }
//
// class HelpPage extends StatelessWidget {
//   const HelpPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Help')),
//       body: const Center(child: Text('Help Page')),
//     );
//   }
// }
//
// void main() {
//   runApp(const MyApp());
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';
import 'package:open_filex/open_filex.dart';
//
// class PdfViewerPage extends StatefulWidget {
//   final String pdfUrl;
//
//   PdfViewerPage({Key? key, required this.pdfUrl}) : super(key: key);
//
//   @override
//   _PdfViewerPageState createState() => _PdfViewerPageState();
// }
//
// class _PdfViewerPageState extends State<PdfViewerPage> {
//   late PdfControllerPinch pdfController;
//
//   @override
//   void initState() {
//     super.initState();
//     pdfController = PdfControllerPinch(document: PdfDocument.openFile(widget.pdfUrl));
//   }
//
//   @override
//   void dispose() {
//     pdfController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Document Viewer"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.open_in_new),
//             onPressed: () {
//               _openFile(widget.pdfUrl);
//             },
//           ),
//         ],
//       ),
//       body: PdfViewPinch(
//         controller: pdfController,
//         scrollDirection: Axis.vertical,
//         builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
//           options: const DefaultBuilderOptions(),
//           documentLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
//           pageLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
//           errorBuilder: (_, error) => Center(child: Text("Failed to load PDF: $error")),
//         ),
//       ),
//     );
//   }
//
//   void _openFile(String filePath) {
//     try {
//       OpenFilex.open(filePath);
//     } catch (e) {
//       Get.snackbar("Error", "Cannot open file: $e", backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
// }


class PdfViewerPage extends StatefulWidget {
  final String pdfPath;
  PdfViewerPage({Key? key, required this.pdfPath}) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PdfControllerPinch pdfController;

  @override
  void initState() {
    super.initState();
    pdfController = PdfControllerPinch(document: PdfDocument.openFile(widget.pdfPath));
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Viewer")),
      body: PdfViewPinch(controller: pdfController),
    );
  }
}

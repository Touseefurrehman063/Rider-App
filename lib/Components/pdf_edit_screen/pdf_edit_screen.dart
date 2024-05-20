import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// Import the chosen PDF editing library (e.g., pdf_editing)

class PDFViewerAndSignScreen extends StatefulWidget {
  final String pdfPath;

  const PDFViewerAndSignScreen({Key? key, required this.pdfPath})
      : super(key: key);

  @override
  State<PDFViewerAndSignScreen> createState() => _PDFViewerAndSignScreenState();
}

class _PDFViewerAndSignScreenState extends State<PDFViewerAndSignScreen> {
  // Signature data (replace with actual capture mechanism)
  String signatureData = '';
  bool isPositioningSignature = false;

  Offset? signaturePosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer and Sign'),
      ),
      body: Stack(
        children: [
          SfPdfViewer.network(widget.pdfPath),
          if (isPositioningSignature)
            Positioned(
              left: signaturePosition?.dx ?? 0.0,
              top: signaturePosition?.dy ?? 0.0,
              child: GestureDetector(
                onPanUpdate: (details) =>
                    setState(() => signaturePosition = details.globalPosition),
                child: Image.network(
                  signatureData, // Provide default value or handle null case
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () async {
          // Capture user signature (replace with actual implementation)
          signatureData = await captureSignature();
          setState(() => isPositioningSignature = true);
        },
      ),
      persistentFooterButtons: [
        TextButton(
          child: const Text('Save'),
          onPressed: () async {
            if (signaturePosition != null) {
              await saveEditedPDF(
                  widget.pdfPath, signatureData, signaturePosition!);
              // Show success or error message based on saving result
            } else {
              // Handle the case where signatureData or signaturePosition is null
            }
          },
        ),
      ],
    );
  }

  // Replace with actual signature capture implementation
  captureSignature() async {
    final SignatureController signatureController = SignatureController();

    bool isCompleted = false;

    await showDialog(
        context: context, // Replace with your navigator key
        barrierDismissible: false,
        builder: (context) => AlertDialog(
                title: const Text('Capture Signature'),
                content: Signature(
                  controller: signatureController,
                  height: MediaQuery.of(context).size.height / 3,
                  backgroundColor: Colors.white,
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Clear'),
                    onPressed: () =>
                        setState(() => signatureController.clear()),
                  ),
                  TextButton(
                    child: const Text('Done'),
                    onPressed: () {
                      isCompleted = true;
                      Navigator.of(context).pop();
                    },
                  ),
                ]));
    Future<String> saveSignatureImage() async {
      try {
        // Get the signature bytes
        final signature = await signatureController.toPngBytes();
        if (signature == null) {
          throw Exception("Failed to get signature bytes.");
        }

        // Save the signature image
        final directory = await getApplicationDocumentsDirectory();
        final path = '${directory.path}/signature.png';
        final file = File(path);
        await file.writeAsBytes(signature);

        return path; // Return the path to the saved signature image
      } catch (e) {
        print("Error saving signature image: $e");
        return ''; // Return empty string on error
      }
    }

    final signature = await signatureController.toPngBytes();

    if (!isCompleted) return ''; // Handle cancellation (optional)

    // // Save the signature image (replace with actual saving logic)
    // final directory = await getApplicationDocumentsDirectory();
    // final path = '${directory.path}/signature.png';
    // final file = File(path);
    // await file.writeAsBytes(signature!);

    // Return the path to the saved signature image
  }

  // Replace with actual PDF editing library functionality
  Future<void> saveEditedPDF(
      String pdfPath, String signatureData, Offset? signaturePosition) async {
    // Use the editing library to modify the PDF with the signature
    // ...
  }
}

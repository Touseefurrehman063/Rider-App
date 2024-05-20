import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;
  final String pdfname;

  const PDFViewerScreen(
      {Key? key, required this.pdfPath, required this.pdfname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pdfname ?? ""),
      ),
      body: SfPdfViewer.network(pdfPath),
    );
  }
}

// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

// class SignaturePadApp extends StatelessWidget {
//   final String pdfPath;
//   const SignaturePadApp({Key? key, required this.pdfPath}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MyHomePage(
//       pdfPath: pdfPath,
//     );
//   }
// }

// @immutable
// class MyHomePage extends StatefulWidget {
//   String pdfPath;
//   MyHomePage({Key? key, required this.pdfPath}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final GlobalKey<SfSignaturePadState> _signaturePadGlobalKey = GlobalKey();
//   Uint8List? _documentBytes;

//   @override
//   void initState() {
//     super.initState();
//   }

//   //Add the signature in the PDF document.
// //   void _handleSigningProcess() async {
// //     //Save the signature as PNG image.
// //     final data =
// //         await _signaturePadGlobalKey.currentState!.toImage(pixelRatio: 3.0);

// //     final bytes = await data.toByteData(format: ui.ImageByteFormat.png);

// //     final Uri pdfUri = Uri.parse(
// //         widget.pdfPath); // Assuming widget.pdfPath is the URL of the PDF
// //     final http.Response response = await http.get(pdfUri);
// //     final Uint8List documentBytes = response.bodyBytes;
// // //click error
// //     // Fetch the certificate bytes from the network (if needed)
// //     final Uint8List cert = response.bodyBytes;
// //     final buffer = cert.buffer;

// //     ByteData certBytes = ByteData.view(buffer);
// //     final Uint8List certificateBytes = certBytes.buffer.asUint8List();
// //     PdfDocument document = PdfDocument(inputBytes: documentBytes);
// //     PdfPage page = document.pages[0];
// //     PdfSignatureField signatureField = PdfSignatureField(page, 'signature',
// //         bounds: const Rect.fromLTRB(300, 500, 550, 700),
// //         signature: PdfSignature(
// //             //Create a certificate instance from the PFX file with a private key.
// //             certificate: PdfCertificate(certificateBytes, 'password123'),
// //             contactInfo: 'johndoe@owned.us',
// //             locationInfo: 'Honolulu, Hawaii',
// //             reason: 'I am author of this document.',
// //             digestAlgorithm: DigestAlgorithm.sha256,
// //             cryptographicStandard: CryptographicStandard.cms));

// //     //Get the signature field appearance graphics.
// //     PdfGraphics? graphics = signatureField.appearance.normal.graphics;

// //     //Draw the signature image in the PDF page.
// //     graphics?.drawImage(PdfBitmap(certBytes.buffer.asUint8List()),
// //         const Rect.fromLTWH(0, 0, 250, 200));

// //     //Add a signature field to the form.
// //     document.form.fields.add(signatureField);

// //     //Flatten the PDF form field annotation
// //     document.form.flattenAllFields();

// //     _documentBytes = Uint8List.fromList(document.save() as List<int>);
// //     document.dispose();
// //     setState(() {});
// //   }
//   Future<String> downloadAndSaveFile(String fileUrl, String fileName) async {
//     // Get the temporary directory for storing files
//     Directory tempDir = await getTemporaryDirectory();
//     String tempPath = tempDir.path;

//     // Create a file object with the appropriate path
//     String filePath = '$tempPath/$fileName';

//     // Send a GET request to the file URL
//     http.Response response = await http.get(Uri.parse(fileUrl));

//     // Write the body of the response to the file
//     File file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);

//     // Optionally, copy the file to a permanent location
//     // For example, you can move it to the documents directory
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String appDocPath = appDocDir.path;
//     String permanentFilePath = '$appDocPath/$fileName';
//     await file.copy(permanentFilePath);
//     print('File downloaded and saved to: $permanentFilePath');
//     return permanentFilePath;
//   }

//   void _handleSigningProcess() async {
//     //Save the signature as PNG image.
//     final data =
//         await _signaturePadGlobalKey.currentState!.toImage(pixelRatio: 3.0);
//     final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
//     log(widget.pdfPath);
//     var path = await downloadAndSaveFile(
//         widget.pdfPath, widget.pdfPath.split('=').last);
//     List<int> databytes = await File(path).readAsBytes();
//     // Convert bytes to ByteData
//     ByteData byteData = ByteData.view(Uint8List.fromList(databytes).buffer);
//     // final ByteData docBytes = await rootBundle.load(path);
//     final Uint8List documentBytes = byteData.buffer.asUint8List();
//     ByteData certBytes = ByteData.view(Uint8List.fromList(databytes).buffer);
//     final Uint8List certificateBytes = certBytes.buffer.asUint8List();

//     //Load the document
//     PdfDocument document = PdfDocument(inputBytes: documentBytes);

//     //Get the first page of the document. The page in which signature need to be added.
//     PdfPage page = document.pages[0];

//     //Create a digital signature and set the signature information.
//     PdfSignatureField signatureField = PdfSignatureField(page, 'signature',
//         bounds: const Rect.fromLTRB(300, 500, 550, 700),
//         signature: PdfSignature(
//             //Create a certificate instance from the PFX file with a private key.
//             certificate: PdfCertificate(certificateBytes, 'password123'),
//             contactInfo: 'johndoe@owned.us',
//             locationInfo: 'Honolulu, Hawaii',
//             reason: 'I am author of this document.',
//             digestAlgorithm: DigestAlgorithm.sha512,
//             cryptographicStandard: CryptographicStandard.cades));

//     //Get the signature field appearance graphics.
//     PdfGraphics? graphics = signatureField.appearance.normal.graphics;

//     //Draw the signature image in the PDF page.
//     graphics?.drawImage(PdfBitmap(bytes!.buffer.asUint8List()),
//         const Rect.fromLTWH(0, 0, 120, 200));

//     //Add a signature field to the form.
//     document.form.fields.add(signatureField);

//     //Flatten the PDF form field annotation
//     document.form.flattenAllFields();

//     _documentBytes = Uint8List.fromList(await document.save());
//     document.dispose();
//     setState(() {});
//   }

//   //Clear the signature in the SfSignaturePad.
//   void _handleClearButtonPressed() {
//     _signaturePadGlobalKey.currentState!.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Consent'),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: widget.pdfPath.isNotEmpty
//                   ? SfPdfViewer.network(widget.pdfPath)
//                   : const Center(child: CircularProgressIndicator()),
//             ),
//             Container(
//               height: 170,
//               decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       height: 100,
//                       width: 300,
//                       decoration:
//                           BoxDecoration(border: Border.all(color: Colors.grey)),
//                       child: SfSignaturePad(
//                           key: _signaturePadGlobalKey,
//                           backgroundColor: Colors.white,
//                           strokeColor: Colors.black,
//                           minimumStrokeWidth: 1.0,
//                           maximumStrokeWidth: 4.0),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
//                         child: ElevatedButton(
//                           onPressed: _handleSigningProcess,
//                           child:
//                               const Text('Add signature and load the document'),
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: _handleClearButtonPressed,
//                         child: const Text('Clear'),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }

// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riderapp/Components/custom_container/custom_container.dart';
// import 'package:flutter_riderapp/Utilities.dart';
// import 'package:flutter_riderapp/controllers/consent_controller/consent_controller.dart';
// import 'package:flutter_riderapp/helpers/color_manager.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// Future<void> consentDialog(BuildContext context) async {
//   final CustomContainerController containerController =
//       CustomContainerController();

//   List<Widget> customContainers = [
//     CustomContainer(controller: containerController)
//   ];

//   await showDialog(
//     barrierDismissible: true,
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(15.0)),
//             ),
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             content: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                   const SizedBox(height: 10),
//                   Column(children: customContainers),
//                   Center(
//                     child: TextButton(
//                       onPressed: () {
//                         setState(() {
//                           customContainers.add(
//                               CustomContainer(controller: containerController));
//                         });
//                       },
//                       child: Text(
//                         "Add more +",
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: Get.width * 0.05),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             for (File file in containerController.files) {
//                               await uploadPicture(file);
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: ColorManager.kDarkBlue,
//                             fixedSize: const Size(380, 4),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                           ),
//                           child: Text(
//                             'Submit',
//                             style: GoogleFonts.poppins(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: ColorManager.kWhiteColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }

// Future<String> uploadPicture(File file) async {
//   String r = '';
//   var url = '$ip/api/account/UploadPicture';

//   var request = http.MultipartRequest('POST', Uri.parse(url));
//   request.files.add(await http.MultipartFile.fromPath('image', file.path));

//   final res = await request.send();

//   if (res.statusCode == 200) {
//     dynamic data = jsonDecode(await res.stream.bytesToString());
//     r = data["Path"];

//     print('Upload success: ');
//   } else {
//     print('Upload failed with status ${res.statusCode}');
//   }

//   return r;
// }

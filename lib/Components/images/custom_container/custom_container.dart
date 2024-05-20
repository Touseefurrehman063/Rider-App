import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riderapp/Models/consent_model/consent_model.dart';
import 'package:flutter_riderapp/controllers/consent_controller/consent_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:signature/signature.dart';

// class FileModel {
//   String? filePath;
//   String textFieldText;
//   String? acceptReject;
//   FileModel({this.filePath, required this.textFieldText, this.acceptReject});
// }

class FilePickerCard extends StatefulWidget {
  final ConsentModel fileModel;
  final ValueChanged<String?> onFileSelected;
  final ValueChanged<String> onTextChanged;
  final ValueChanged<String> onAcceptRejectChanged;
  const FilePickerCard({
    Key? key,
    required this.fileModel,
    required this.onFileSelected,
    required this.onTextChanged,
    required this.onAcceptRejectChanged,
  }) : super(key: key);
  @override
  _FilePickerCardState createState() => _FilePickerCardState();
}

class _FilePickerCardState extends State<FilePickerCard> {
  String? filePath;
  SignatureController signcontroller = SignatureController(
    penStrokeWidth: 3,
    penColor: ColorManager.kDarkBlue,
    exportBackgroundColor: ColorManager.kGreyColor,
    exportPenColor: ColorManager.kblackColor,
  );
  // Uint8List? exportedImage;
  @override
  Widget build(BuildContext context) {
    var cont = Get.put<CustomContainerController>(CustomContainerController());
    String? acceptRejectValue = widget.fileModel.consentFormStatus;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         // Handle clear action
              //       },
              //       icon: const Icon(
              //         Icons.clear_rounded,
              //         color: Colors.red,
              //         size: 20,
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: Get.height * 0.01),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorManager.kPrimaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.1,
                    vertical: Get.height * 0.015,
                  ),
                ),
                onPressed: () async {
                  showModalBottomSheet(
                      context: context, builder: (builder) => bottomsheet());
                },
                child: const Center(child: Text('Choose File ...')),
              ),
              SizedBox(height: Get.height * 0.01),

              _imageFile?.name != null
                  ? Center(
                      child: Image.file(
                        File(_imageFile!.path),
                        width: Get.width * 0.25,
                        height: Get.height * 0.15,
                        fit: BoxFit.fill,
                      ),
                    )
                  : filePath != null &&
                          ['jpeg', 'jpg', 'png']
                              .contains(filePath!.split('.').last.toLowerCase())
                      ? Center(
                          child: Image.file(
                            File(filePath!),
                            width: Get.width * 0.25,
                            height: Get.height * 0.15,
                            fit: BoxFit.fill,
                          ),
                        )
                      : filePath != null
                          ? Center(
                              child: SizedBox(
                                height: Get.height * 0.15,
                                width: Get.width * 0.25,
                                child: PDFView(
                                  filePath: filePath!,
                                  // defaultPage: 1,
                                ),
                              ),
                            )
                          : Container(),

              SizedBox(height: Get.height * 0.01),
              TextField(
                onChanged: widget.onTextChanged,
                decoration: InputDecoration(
                  hintText: 'Remarks',
                  hintStyle: GoogleFonts.poppins(fontSize: 10),
                  border: const OutlineInputBorder(),
                ),
              ),
              // SizedBox(height: Get.height * 0.02),
              // Text(
              //   "Signature:",
              //   style: GoogleFonts.poppins(fontSize: 12),
              // ),
              // SizedBox(height: Get.height * 0.01),
              // Signature(
              //   controller: signcontroller,
              //   width: Get.width,
              //   height: Get.height * 0.2,
              //   backgroundColor: Colors.yellow.shade200,
              // ),

              // SizedBox(height: Get.height * 0.02),
              // Center(
              //     child: Row(
              //   mainAxisSize: MainAxisSize.min,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () async {
              //         cont.exportedImage = await signcontroller.toPngBytes();
              //         setState(() {});
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: ColorManager.kDarkBlue,
              //         fixedSize: const Size(80, 4),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //       ),
              //       child: Text(
              //         'Save',
              //         style: GoogleFonts.poppins(
              //           fontSize: 12,
              //           fontWeight: FontWeight.bold,
              //           color: ColorManager.kWhiteColor,
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: Get.width * 0.1),
              //     ElevatedButton(
              //       onPressed: () {
              //         signcontroller.clear();
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: ColorManager.kRedColor,
              //         fixedSize: const Size(80, 4),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //       ),
              //       child: Text(
              //         'Clear',
              //         style: GoogleFonts.poppins(
              //           fontSize: 12,
              //           fontWeight: FontWeight.bold,
              //           color: ColorManager.kWhiteColor,
              //         ),
              //       ),
              //     )
              //   ],
              // )),

              // SizedBox(height: Get.height * 0.02),
              // if (cont.exportedImage != null) Image.memory(cont.exportedImage!),
              SizedBox(height: Get.height * 0.02),
              Center(
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 0.7,
                      child: Radio<String>(
                        value: "1",
                        groupValue: acceptRejectValue,
                        onChanged: (value) {
                          setState(() {
                            acceptRejectValue = value;
                          });
                          widget.onAcceptRejectChanged(value!);
                        },
                      ),
                    ),
                    Text(
                      'Accept',
                      style: GoogleFonts.poppins(fontSize: 10),
                    ),
                    const SizedBox(width: 6.0),
                    Transform.scale(
                      scale: 0.7,
                      child: Radio<String>(
                        value: '2',
                        groupValue: acceptRejectValue,
                        onChanged: (value) {
                          setState(() {
                            acceptRejectValue = value;
                          });
                          widget.onAcceptRejectChanged(value!);
                        },
                      ),
                    ),
                    Text(
                      'Reject',
                      style: GoogleFonts.poppins(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Source",
            style: GoogleFonts.raleway(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  TakePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                label: Text(
                  "Camera",
                  style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.file_open),
                onPressed: () async {
                  // TakePhoto(ImageSource.gallery);
                  filePath = await FilePicker.platform.pickFiles().then(
                    (result) {
                      if (result != null) {
                        print("File picked: ${result.files.single.path}");
                        return result.files.single.path;
                      } else {
                        print("No file picked");
                        return null;
                      }
                    },
                  );
                  widget.onFileSelected(filePath);
                  widget.onFileSelected(filePath);
                  Navigator.pop(context);
                },
                label: Text(
                  "File",
                  style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  final _picker = ImagePicker();
  late File _heicImage;
  XFile? _imageFile;
  void TakePhoto(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
      widget.onFileSelected(pickedFile.path);
    }
  }
}

class CustomContainer extends StatefulWidget {
  final CustomContainerController controller;

  const CustomContainer({Key? key, required this.controller}) : super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  final TextEditingController remarks = TextEditingController();
  bool? _selected;
  final _picker = ImagePicker();
  late File _heicImage;

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<CustomContainerController>(CustomContainerController());
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle clear action
                    },
                    icon: const Icon(
                      Icons.clear_rounded,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ],
              ),
              // SizedBox(height: Get.height * 0.01),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorManager.kDarkBlue,
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.18,
                    vertical: Get.height * 0.015,
                  ),
                ),
                onPressed: () {
                  takeFile(ImageSource.gallery);
                },
                child: const Text('Choose File ...'),
              ),
              SizedBox(height: Get.height * 0.01),
              TextField(
                controller: remarks,
                decoration: InputDecoration(
                  hintText: 'Remarks',
                  hintStyle: GoogleFonts.poppins(fontSize: 10),
                  border: const OutlineInputBorder(),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: Radio(
                      value: true,
                      groupValue: _selected,
                      onChanged: (bool? value) {
                        setState(() {
                          _selected = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    'Accept',
                    style: GoogleFonts.poppins(fontSize: 10),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: Radio(
                      value: false,
                      groupValue: _selected,
                      onChanged: (bool? value) {
                        setState(() {
                          _selected = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    'Reject',
                    style: GoogleFonts.poppins(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void takeFile(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _heicImage = File(pickedFile.path);
      });
      widget.controller.saveContainerInfo(
        image: _heicImage,
        remarks: remarks.text,
        accepted: _selected ?? false,
      );
      @override
      void dispose() {
        remarks.dispose();
        super.dispose();
      }
    }
  }
}

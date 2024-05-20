import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Components/pdf_edit_screen/pdf_edit_screen.dart';
import 'package:flutter_riderapp/Components/pdf_viewer/pdf_viewer.dart';
import 'package:flutter_riderapp/Models/consent_model/consent_model.dart';
import 'package:flutter_riderapp/Models/pdf_model/pdf_model.dart';
import 'package:flutter_riderapp/Screen/ViewInformation/edit_patient.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/controllers/consent_controller/consent_controller.dart';
import 'package:flutter_riderapp/data/Notification_repo/auth_repo.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class FileModel {
//   String? filePath;
//   String textFieldText;
//   String? acceptReject;
//   FileModel({this.filePath, required this.textFieldText, this.acceptReject});
// }

class DigitalFilePickerCard extends StatefulWidget {
  final ConsentModel fileModel;
  final ValueChanged<String?> onFileSelected;
  final ValueChanged<String> onTextChanged;
  final ValueChanged<String> onAcceptRejectChanged;
  dynamic index;
  DigitalFilePickerCard({
    Key? key,
    required this.fileModel,
    required this.onFileSelected,
    required this.onTextChanged,
    required this.onAcceptRejectChanged,
    required this.index,
  }) : super(key: key);
  @override
  _DigitalFilePickerCardState createState() => _DigitalFilePickerCardState();
}

class _DigitalFilePickerCardState extends State<DigitalFilePickerCard> {
  _getPdf() async {
    AuthRepo ar = AuthRepo();
    List<PdfData>? pdfList = await ar.getPdf();
    if (pdfList != null) {
      CustomContainerController.i.updatePdflist(pdfList);
    } else {
      print("Error: pdfList is null");
    }
  }

  String? filePath;
  SignatureController signcontroller = SignatureController(
    penStrokeWidth: 3,
    penColor: ColorManager.kDarkBlue,
    exportBackgroundColor: ColorManager.kGreyColor,
    exportPenColor: ColorManager.kblackColor,
  );
  // Uint8List? exportedImage;
  XFile? _imageFile;
  @override
  void initState() {
    _getPdf();
    CustomContainerController.i.clearExportedImage();
    super.initState();
  }

  String n = "";
  @override
  Widget build(BuildContext context) {
    var cont = Get.put<CustomContainerController>(CustomContainerController());
    // var edit = Get.put<EditPatientController>(EditPatientController());
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
              SizedBox(height: Get.height * 0.01),
              GetBuilder<CustomContainerController>(builder: (cont) {
                return EditProfileCustomTextField(
                  suffixIcon: const Icon(Icons.arrow_drop_down),

                  onTap: () async {
                    cont.selectedpdf = null;

                    PdfData generic =
                        await pdfdropdown(context, cont.selectedpdflist);
                    cont.selectedpdf = null;
                    cont.updateselectedpdf(generic);
                    // cont.pdflist.add(gener);
                    cont.pdflist.add(generic);
                    if (generic.id == null) {
                      cont.selectedpdf = generic;
                      cont.selectedpdf =
                          (generic.id == null) ? null : cont.selectedpdf;
                    }
                    n = generic.name!;
                    // cont.updatepdf(cont.selectedpdf?.name);
                    setState(() {});
                  },
                  readonly: true,
                  // labelText: 'Title'.tr,
                  hintText:
                      cont.selectedpdf?.id == "" || cont.selectedpdf?.id == null
                          ? 'Please Select Consent Form'.tr
                          : n,
                );
              }),
              cont.selectedpdf?.filePath == null ||
                      cont.selectedpdf?.filePath == ""
                  ? Center(
                      child: Text(
                        "",
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                    )
                  : Center(
                      child: SizedBox(
                          height: Get.height * 0.15,
                          width: Get.width * 0.2,
                          child: SfPdfViewer.network(
                              ip + cont.selectedpdf?.filePath)),
                    ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Center(
                child: cont.selectedpdf?.filePath != null &&
                        cont.selectedpdf!.filePath.isNotEmpty
                    ? ElevatedButton(
                        onPressed: () async {
                          if (cont.selectedpdf?.filePath != null &&
                              cont.selectedpdf!.filePath.isNotEmpty) {
                            // Open PDF viewer when tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFViewerScreen(
                                    pdfname: cont.selectedpdf!.name!,
                                    pdfPath: ip + cont.selectedpdf!.filePath),
                              ),
                            );
                          }
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.kDarkBlue,
                          fixedSize: const Size(80, 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'View',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.kWhiteColor,
                          ),
                        ))
                    : const SizedBox.shrink(),
              ),
              cont.selectedpdf?.filePath != null &&
                      cont.selectedpdf!.filePath.isNotEmpty
                  ? Text(
                      "Signature:",
                      style: GoogleFonts.poppins(fontSize: 12),
                    )
                  : const SizedBox.shrink(),
              cont.selectedpdf?.filePath != null &&
                      cont.selectedpdf!.filePath.isNotEmpty
                  ? SizedBox(height: Get.height * 0.01)
                  : const SizedBox.shrink(),
              cont.selectedpdf?.filePath != null &&
                      cont.selectedpdf!.filePath.isNotEmpty
                  ? Signature(
                      controller: signcontroller,
                      width: Get.width,
                      height: Get.height * 0.2,
                      backgroundColor: ColorManager.kWhiteColor,
                    )
                  : const SizedBox.shrink(),
              cont.selectedpdf?.filePath != null &&
                      cont.selectedpdf!.filePath.isNotEmpty
                  ? SizedBox(height: Get.height * 0.02)
                  : const SizedBox.shrink(),
              cont.selectedpdf?.filePath != null &&
                      cont.selectedpdf!.filePath.isNotEmpty
                  ? Center(
                      child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            cont.exportedImage =
                                await signcontroller.toPngBytes();
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.kDarkBlue,
                            fixedSize: const Size(80, 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.kWhiteColor,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.1),
                        ElevatedButton(
                          onPressed: () async {
                            signcontroller.clear();
                            cont.clearExportedImage();
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.kRedColor,
                            fixedSize: const Size(80, 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Clear',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.kWhiteColor,
                            ),
                          ),
                        )
                      ],
                    ))
                  : const SizedBox.shrink(),
              // SizedBox(height: Get.height * 0.02),
              if (cont.exportedImage != null)
                cont.selectedpdf?.filePath != null &&
                        cont.selectedpdf!.filePath.isNotEmpty
                    ? Image.memory(cont.exportedImage!)
                    : const SizedBox.shrink(),
              cont.selectedpdf?.filePath != null &&
                      cont.selectedpdf!.filePath.isNotEmpty
                  ? SizedBox(height: Get.height * 0.02)
                  : const SizedBox.shrink(),
              cont.selectedpdf?.filePath != null &&
                      cont.selectedpdf!.filePath.isNotEmpty
                  ? Center(
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
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

pdfdropdown(BuildContext context, List<dynamic> list) async {
  TextEditingController search = TextEditingController();
  dynamic generic;
  String title = "";
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: Get.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          hintStyle: GoogleFonts.poppins(
                              color: ColorManager.kPrimaryColor),
                          hintText: 'search'.tr,
                          filled: true,
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorManager.kPrimaryLightColor),
                              borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryLightColor),
                          ),
                          fillColor: ColorManager.kPrimaryLightColor,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ColorManager.kPrimaryColor,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorManager.kPrimaryLightColor),
                            borderRadius: BorderRadius.all(
                              Radius.circular(0.0),
                            ),
                          ),
                        ),
                        controller: search,
                        onChanged: (val) {
                          title = val;
                          setState(() {
                            title = val;
                          });
                        },
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: ((context, index) {
                              if (search.text.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    generic = list[index];
                                    Navigator.pop(context);
                                    //    LabInvestigationController.i.updateLabTest(generic!);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      Text(
                                        list[index].name.toString(),
                                        style: const TextStyle(
                                            color: ColorManager.kblackColor),
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                );
                              } else if (list[index]
                                  .name
                                  .toString()
                                  .toLowerCase()
                                  .contains(title.toLowerCase())) {
                                return InkWell(
                                  onTap: () {
                                    generic = list[index];
                                    Navigator.pop(context);
                                    //  LabInvestigationController.i.updateLabTest(generic!);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      Text(
                                        list[index].name.toString(),
                                        style: const TextStyle(
                                            color: ColorManager.kblackColor),
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
  if (generic != null) {
    return generic;
  }
  return [];
  //  search.clear();
}

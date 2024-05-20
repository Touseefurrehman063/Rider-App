import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/container_info/container_info.dart';
import 'package:flutter_riderapp/Models/pdf_model/pdf_model.dart';
import 'package:flutter_riderapp/data/Notification_repo/auth_repo.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:signature/signature.dart';

class CustomContainerController extends GetxController {
  final List<ContainerInfo> containerInfoList = [];
  bool isDigitalSelected = true;
  Uint8List? exportedImage;
  PdfData? selectedpdf = PdfData();
  List<PdfData> selectedpdflist = [];
  List<PdfData> pdflist = [];

  void saveContainerInfo({
    required File image,
    required String remarks,
    required bool accepted,
  }) {
    containerInfoList.add(
      ContainerInfo(
        image: image,
        remarks: remarks,
        accepted: accepted,
      ),
    );
  }

  updateselectedpdf(PdfData pdf) {
    selectedpdf = pdf;
    update();
  }

  String pdfname = "";
  updatepdf(name) {
    for (int i = 0; i < selectedpdflist.length; i++) {
      selectedpdflist[i].name = name;
      pdfname = name;
    }
    update();
  }

  clearpdflist() {
    selectedpdflist.clear();
    selectedpdf?.filePath = "";
    selectedpdf?.id = "";
    selectedpdf?.name = "";
    pdflist.clear();
    // selectedpdf = null;
    // update();
  }

  void clearExportedImage() {
    exportedImage = null;
  }

  // List<PdfData> personalTitleList = [];
  // PTitle? selectedpersonalTitle = PTitle();
  updatePdflist(List<PdfData> plist) {
    selectedpdflist = plist;

    update();
  }

  getPDf() async {
    AuthRepo ar = AuthRepo();
    CustomContainerController.i.updatePdflist(
      await ar.getPdf(),
    );
  }

  static CustomContainerController get i =>
      Get.put(CustomContainerController());
}

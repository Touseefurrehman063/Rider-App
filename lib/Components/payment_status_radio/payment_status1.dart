import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/controllers/addres_controller/address_controller.dart';
import 'package:flutter_riderapp/controllers/google_maps_controller/google_maps_controller.dart';
import 'package:flutter_riderapp/controllers/labinvestigation_controller/add_labinvestigation.dart';
import 'package:flutter_riderapp/controllers/labinvestigation_controller/lab_investigation_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

int? sampleValue = 0;

class PaymentStatusRadioButton1 extends StatefulWidget {
  const PaymentStatusRadioButton1({super.key});

  @override
  _PaymentStatusRadioButton1State createState() =>
      _PaymentStatusRadioButton1State();
}

class _PaymentStatusRadioButton1State extends State<PaymentStatusRadioButton1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LabInvestigationController1>(builder: (cont) {
      return GetBuilder<LabAddressController>(builder: (address) {
        return SizedBox(
          height: Get.height * 0.05,
          width: Get.width * 1,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Radio<int>(
                // visualDensity: const VisualDensity(horizontal: -2),
                fillColor:
                    MaterialStateProperty.all(ColorManager.kPrimaryColor),
                value: 0,
                groupValue: cont.selectedstatusvalue,
                onChanged: (value) {
                  cont.updateSelectedStatus(value!);
                  // log('${address.latitude.toString()} --- ${address.longitude.toString()}');
                },
              ),
              Text(
                "Pending",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w900,
                    color: ColorManager.kPrimaryColor,
                    fontSize: 12),
              ),
              SizedBox(
                width: Get.width * 0.05,
              ),
              Radio<int>(
                // visualDensity: const VisualDensity(horizontal: -4),
                fillColor:
                    MaterialStateProperty.all(ColorManager.kPrimaryColor),
                value: 1,
                groupValue: cont.selectedstatusvalue,
                onChanged: (value) {
                  cont.updateSelectedStatus(value!);

                  // address.updateAddress('');
                  // log('${address.latitude.toString()} --- ${address.longitude.toString()}');
                },
              ),
              Text(
                "Paid",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: ColorManager.kPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 12),
              ),
            ],
          ),
        );
      });
    });
  }
}

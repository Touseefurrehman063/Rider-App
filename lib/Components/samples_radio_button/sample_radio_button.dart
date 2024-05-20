import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/controllers/google_maps_controller/google_maps_controller.dart';
import 'package:flutter_riderapp/controllers/labinvestigation_controller/lab_investigation_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

int? sampleValue = 0;

class SamplesRadioButton extends StatefulWidget {
  const SamplesRadioButton({super.key});

  @override
  _SamplesRadioButtonState createState() => _SamplesRadioButtonState();
}

class _SamplesRadioButtonState extends State<SamplesRadioButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LabInvestigationController>(builder: (cont) {
      return GetBuilder<AddressController>(builder: (address) {
        return SizedBox(
          height: Get.height * 0.05,
          width: Get.width * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Radio<int>(
                visualDensity: const VisualDensity(horizontal: -4),
                fillColor:
                    MaterialStateProperty.all(ColorManager.kPrimaryColor),
                value: 0,
                groupValue: cont.selectedLabValue,
                onChanged: (value) {
                  cont.updateSelectedLab(value!);
                  log('${address.latitude.toString()} --- ${address.longitude.toString()}');
                },
              ),
              Text(
                "Samples From Home",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w900,
                    color: ColorManager.kPrimaryColor,
                    fontSize: 12),
              ),
              Radio<int>(
                visualDensity: const VisualDensity(horizontal: -4),
                fillColor:
                    MaterialStateProperty.all(ColorManager.kPrimaryColor),
                value: 1,
                groupValue: cont.selectedLabValue,
                onChanged: (value) {
                  cont.updateSelectedLab(value!);

                  address.updateAddress('');
                  log('${address.latitude.toString()} --- ${address.longitude.toString()}');
                },
              ),
              Text(
                "Samples In Lab",
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

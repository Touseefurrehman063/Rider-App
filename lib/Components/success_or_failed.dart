import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Components/custom_button.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_today_appoinments.dart';
import 'package:flutter_riderapp/Screen/Dashboard/_dashboard.dart';
import 'package:flutter_riderapp/Screen/Dashboard/firstview.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:flutter_riderapp/helpers/values_manager.dart';
import 'package:get/get.dart';

class AppointSuccessfulOrFailedWidget extends StatelessWidget {
  final String? imagePath;
  final bool? isLabInvestigationBooking;
  final Function()? onPressedFirst;
  final Function()? onPressedSecond;

  final bool? titleImage;
  final String? image;
  final String? successOrFailedHeader;
  final String? appoinmentFailedorSuccessSmalltext;
  final String? firstButtonText;
  final String? secondButtonText;

  const AppointSuccessfulOrFailedWidget({
    super.key,
    this.image,
    this.successOrFailedHeader,
    this.appoinmentFailedorSuccessSmalltext,
    this.firstButtonText,
    this.secondButtonText,
    this.titleImage = true,
    this.onPressedFirst,
    this.onPressedSecond,
    this.isLabInvestigationBooking = false,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p20)
          .copyWith(left: 20, right: 20, bottom: 20),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 4,
              blurStyle: BlurStyle.inner,
              color: Colors.grey[300]!,
              blurRadius: 10,
              offset: const Offset(-2, 2), // Shadow position
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.kWhiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: Get.height * 0.03,
          // ),
          isLabInvestigationBooking == true
              ? Image.asset(
                  imagePath ?? Images.logo,
                  height: Get.height * 0.1,
                )
              : imagePath != null
                  ? Image.asset(
                      imagePath!,
                      height: Get.height * 0.1,
                    )
                  : const SizedBox.shrink(),
          SizedBox(
            height: Get.height * 0.01,
          ),
          // Image.asset(
          //   image!,
          //   height: Get.height * 0.15,
          // ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text(
            'Congratulations',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 22,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text(
            'Appointment Succesfully Booked',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 13, color: ColorManager.kblackColor),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          PrimaryButton(
              fontSize: 12,
              title: 'View Appointment',
              onPressed: onPressedFirst ??
                  () {
                    // Get.offAll(() => const DrawerScreen());
                    // BottomBarController.i.navigateToPage(1);
                    Get.offAll(() => TodayAppoinments(
                          empId: userprofile!.id!,
                        ));
                  },
              color: ColorManager.kPrimaryColor,
              textcolor: ColorManager.kWhiteColor),
          SizedBox(
            height: Get.height * 0.01,
          ),
          PrimaryButton(
              fontSize: 12,
              title: '$secondButtonText',
              onPressed: onPressedSecond ??
                  () {
                    Get.offAll(() => FirstView());
                  },
              color: ColorManager.kPrimaryLightColor,
              textcolor: ColorManager.kPrimaryColor),
        ],
      ),
    );
  }
}

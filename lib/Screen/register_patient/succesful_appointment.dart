import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/Components/success_or_failed.dart';
import 'package:flutter_riderapp/helpers/values_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessFulAppointScreen extends StatefulWidget {
  final String? imagePath;
  final bool? isLabInvestigationBooking;
  final String? firstButtonText;
  final Function()? onPressedFirst;
  final Function()? onPressedSecond;
  final String? appoinmentFailedorSuccessSmalltext;
  final String? title;

  const SuccessFulAppointScreen(
      {super.key,
      this.appoinmentFailedorSuccessSmalltext,
      this.title,
      this.onPressedFirst,
      this.onPressedSecond,
      this.firstButtonText,
      this.isLabInvestigationBooking,
      this.imagePath});

  @override
  State<SuccessFulAppointScreen> createState() =>
      _SuccessFulAppointScreenState();
}

class _SuccessFulAppointScreenState extends State<SuccessFulAppointScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff0F64C6),
            )),
        // title: Text(
        //   'registration'.tr,
        //   textAlign: TextAlign.center,
        //   style: GoogleFonts.raleway(
        //     fontSize: 24,
        //     fontWeight: FontWeight.w700,
        //     height: 1.175,
        //     color: const Color(0xFF1272D3),
        //   ),
        // ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // const BackgroundLogoimage(),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppointSuccessfulOrFailedWidget(
                  imagePath: widget.imagePath,
                  isLabInvestigationBooking: widget.isLabInvestigationBooking,
                  onPressedFirst: widget.onPressedFirst,
                  onPressedSecond: widget.onPressedSecond,
                  image: Images.correct,
                  successOrFailedHeader: '${widget.title}',
                  appoinmentFailedorSuccessSmalltext:
                      '${widget.appoinmentFailedorSuccessSmalltext}',
                  firstButtonText: widget.firstButtonText ?? 'ok'.tr,
                  secondButtonText: 'cancel'.tr,
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Screen/Dashboard/_dashboard.dart';
import 'package:flutter_riderapp/Screen/Families_screen/_patient_registration.dart';
import 'package:flutter_riderapp/Screen/register_patient/register_patient.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Screen/Nodata/Nodata.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_appointments_history.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_splash_screen.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_today_appoinments.dart';
import 'package:flutter_riderapp/Widgets/registration_selection.dart';
import 'package:flutter_riderapp/controllers/Auth_Controller/auth_controller.dart';
import 'package:flutter_riderapp/controllers/internet_connectivity/connectivity_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class FirstView extends StatefulWidget {
  User? user;
  FirstView({this.user, super.key});

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  String _getGreetingMessage() {
    var now = DateTime.now();
    var hour = now.hour;

    if (hour < 12) {
      return 'goodmorning'.tr;
    } else if (hour < 14) {
      return 'goodAfterNoon'.tr;
    } else if (hour < 17) {
      return 'goodEvening'.tr;
    } else {
      return 'goodNight'.tr;
    }
  }

  Future<void> saveLoginState() async {
    var sharedpref = await SharedPreferences.getInstance();
    sharedpref.setBool(SplashscreenState.KEYLOGIN, true);
  }

  Future<ConnectivityResult> internetCheck() async {
    ConnectivityResult result =
        await NetworkController.i.connectivity.checkConnectivity();
    // log(result.toString());
    if (result.name == "none") {
      Get.rawSnackbar(
          messageText: const Text('Network Connection Error',
              style: TextStyle(color: Colors.black, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400] ?? Colors.red,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    } else {}
    return result;
  }

  @override
  void initState() {
    internetCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 12),
                  child: Image.asset(
                    'assets/main.png',
                    fit: BoxFit.cover,
                    height: Get.height * 0.35,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: double.infinity, height: Get.height * 0.015),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Image.asset(
                          //   "assets/pp.jpg",
                          //   height: MediaQuery.of(context).size.height * 0.1,
                          // ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: ColorManager.kDarkBlue,
                            child: userprofile?.imagePath == null
                                ? const CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/pp.jpg"),
                                    radius: 28,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        ip2 + userprofile!.imagePath!),
                                    radius: 28,
                                  ),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.readexPro(
                                    fontSize: constraints.maxWidth / 35,
                                    fontWeight: FontWeight.w700,
                                    height: 1.25,
                                    color: const Color(0xff1272d3),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'hi'.tr,
                                      style: GoogleFonts.raleway(
                                        fontSize: constraints.maxWidth / 15,
                                        fontWeight: FontWeight.w800,
                                        height: 1.175,
                                        color: const Color(0xff1272d3),
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${(userprofile?.firstName ?? " Rider").length > 10 ? '${(userprofile?.firstName ?? " Rider").substring(0, 15)}...' : (userprofile?.firstName ?? " Rider")}',
                                      style: GoogleFonts.raleway(
                                        fontSize: constraints.maxWidth / 15,
                                        fontWeight: FontWeight.w800,
                                        height: 1.175,
                                        color: const Color(0xff1272d3),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\n',
                                      style: GoogleFonts.readexPro(
                                        fontSize: constraints.maxWidth / 20,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff1272d3),
                                      ),
                                    ),
                                    TextSpan(
                                      text: _getGreetingMessage(),
                                      style: GoogleFonts.raleway(
                                        fontSize: constraints.maxWidth / 30,
                                        fontWeight: FontWeight.w700,
                                        // letterSpacing: 4.5,
                                        color: const Color(0xff1272d3),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    AuthController.i.updateScreen("today");
                                    await saveLoginState();
                                    homechk = false;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TodayAppoinments(
                                          empId: userprofile?.id ?? "",
                                        ),
                                      ),
                                    );
                                    print('Image tapped!');
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: Get.height * 0.25),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/cont1.png',
                                          height: Get.height * 0.20,
                                        ),
                                        Positioned(
                                          top: Get.height * 0.12,
                                          child: Text(
                                            'todayappointments'.tr,
                                            style: GoogleFonts.raleway(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    AuthController.i.updateScreen("history");
                                    await saveLoginState();
                                    homechk = false;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AppointmentHistory(
                                          empId: userprofile?.id ?? "",
                                        ),
                                      ),
                                    );
                                    print('Image tapped!');
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: Get.height * 0.25),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/cont2.jpg',
                                          height: Get.height * 0.20,
                                        ),
                                        Positioned(
                                          top: Get.height * 0.12,
                                          child: Text(
                                            'appointmenthistory'.tr,
                                            style: GoogleFonts.raleway(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )

                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             AppointmentHistory(
                                //                 empId: userprofile?.id ?? ""),
                                //       ),
                                //     );
                                //   },
                                //   child: Padding(
                                //     padding: EdgeInsets.only(
                                //         top: constraints.maxHeight / 3.8),
                                //     child: Image.asset(
                                //       'assets/cont2.jpg',

                                //       height: Get.height * 0.20,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(const PatientRegistration());
                                    // RegistrationSelectionPopup(
                                    //     context, constraints);
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/cont3.png',
                                        height: Get.height * 0.20,
                                      ),
                                      Positioned(
                                        top: Get.height * 0.12,
                                        child: Text(
                                          'registrationordering'.tr,
                                          style: GoogleFonts.raleway(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // GestureDetector(
                                //   onTap: () {
                                //     RegistrationSelectionPopup(
                                //         context, constraints);
                                //     // ScaffoldMessenger.of(context).showSnackBar(
                                //     //   const SnackBar(
                                //     //     content: Text('Registring and Ordering'),
                                //     //     duration: Duration(seconds: 3),
                                //     //   ),
                                //     // );
                                //     // print('Image tapped!');

                                //     // ScaffoldMessenger.of(context).showSnackBar(
                                //     //   const SnackBar(
                                //     //     content: Text('Registring and Ordering'),
                                //     //     duration: Duration(seconds: 3),
                                //     //   ),
                                //     // );
                                //     print('Image tapped!');
                                //   },
                                //   child: Image.asset(
                                //     'assets/cont3.png',
                                //     height: Get.height * 0.20,
                                //   ),
                                // ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const RegisterPatient());
                                    print("Image Tapped");
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/cont2.jpg',
                                        height: Get.height * 0.20,
                                      ),
                                      Positioned(
                                        top: Get.height * 0.13,
                                        child: Text(
                                          'Patient Vault'.tr,
                                          style: GoogleFonts.raleway(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

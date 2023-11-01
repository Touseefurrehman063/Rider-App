import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Screen/Nodata/Nodata.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_appointments_history.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_splash_screen.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_today_appoinments.dart';
import 'package:flutter_riderapp/Widgets/registration_selection.dart';
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

    if (hour < 10) {
      return 'goodmorning'.tr;
    } else if (hour < 18) {
      return 'goodAfterNoon'.tr;
    } else if (hour < 22) {
      return 'goodEvening'.tr;
    } else {
      return 'goodNight'.tr;
    }
  }

  Future<void> saveLoginState() async {
    var sharedpref = await SharedPreferences.getInstance();
    sharedpref.setBool(SplashscreenState.KEYLOGIN, true);
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
                      vertical: 25.0, horizontal: 10),
                  child: Image.asset(
                    'assets/main.png',
                    fit: BoxFit.fitWidth,
                    height: Get.height * 0.35,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: constraints.maxHeight / 16,
                    ),
                    SizedBox(
                      height: constraints.maxHeight / 9,
                      width: constraints.maxWidth / 1.3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/pp.jpg",
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: RichText(
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
                                            ' ${(userprofile?.fullName ?? "Helpful Rider").length > 10 ? '${(userprofile?.fullName ?? "Helpful Rider").substring(0, 10)}...' : (userprofile?.fullName ?? "Helpful Rider")}',
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
                                    await saveLoginState();
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
                                    padding: EdgeInsets.only(
                                        top: constraints.maxHeight / 3.8),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/cont1.png',
                                          height: Get.height * 0.20,
                                        ),
                                        Positioned(
                                          top: 70.0,
                                          child: Text(
                                            'todayappointments'.tr,
                                            style: GoogleFonts.raleway(
                                              fontSize: 13,
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
                                    await saveLoginState();
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
                                    padding: EdgeInsets.only(
                                        top: constraints.maxHeight / 3.8),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/cont2.jpg',
                                          height: Get.height * 0.20,
                                        ),
                                        Positioned(
                                          top: 70.0,
                                          child: Text(
                                            'appointmenthistory'.tr,
                                            style: GoogleFonts.raleway(
                                              fontSize: 13,
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
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    RegistrationSelectionPopup(
                                        context, constraints);
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/cont3.png',
                                        height: Get.height * 0.20,
                                      ),
                                      Positioned(
                                        top: 70.0,
                                        child: Text(
                                          'registrationordering'.tr,
                                          style: GoogleFonts.raleway(
                                            fontSize: 13,
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
                                    Get.to(const NoDataFound());
                                    print("Image Tapped");
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/cont4.png',
                                        height: Get.height * 0.20,
                                      ),
                                       Positioned(
                                        top:
                                            40.0, 
                                        child: Text(
                                          'comingsoon'.tr,
                                          style: const TextStyle(
                                            fontSize:
                                                13, 
                                            color: Colors
                                                .white, 
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
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

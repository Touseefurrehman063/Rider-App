import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Screen/Login/_login.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_welcome_4.dart';
import 'package:flutter_riderapp/main.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome3 extends StatefulWidget {
  const Welcome3({super.key});
  @override
  State<Welcome3> createState() => _Welcome3State();
}

class _Welcome3State extends State<Welcome3> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/Vector.png',
              alignment: Alignment.topCenter,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: Get.height * 0.045),
                child: TextButton(
                  onPressed: () {
                    print("button pressed");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Text(
                    'Start Ride',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: Get.height * 0.013),
                  child: Image.asset(
                    'assets/Frame1.png',
                    height: Get.height * 0.38,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.06,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: Get.height * 0.06),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: InkWell(
                      onTap: () {
                        log(initScreen.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Welcome4()),
                        );
                      },
                      child: Image.asset('assets/arrow.png'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

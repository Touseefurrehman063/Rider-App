import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Screen/Login/_login.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_welcome_5.dart';
import 'package:flutter_riderapp/main.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome4 extends StatefulWidget {
  const Welcome4({super.key});
  @override
  State<Welcome4> createState() => _Welcome4State();
}

class _Welcome4State extends State<Welcome4> {
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
                    // print("button pressed");
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01),
                      child: Text(
                        'Arrived &',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.003),
                      child: Text(
                        'Sampling',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                ),
                Image.asset('assets/Frame3.png', height: Get.height * 0.28),
                SizedBox(
                  height: Get.height * 0.08,
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
                              builder: (context) => const Welcome5()),
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

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Screen/Login/_login.dart';
import 'package:flutter_riderapp/main.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_welcome_2.dart';
class Welcome1 extends StatefulWidget {
  const Welcome1({super.key});
  @override
  State<Welcome1> createState() => _Welcome1State();
}
class _Welcome1State extends State<Welcome1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding:
                   EdgeInsets.symmetric(horizontal: 10.0, vertical: Get.height*0.045),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.only(bottom:Get.height*0.5),
                child: Text(
                  'helpful'.tr,
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
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.15,
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(bottom:Get.height*0.05),
                    child: Image.asset('assets/bike.png'),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom:Get.height*0.06),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: InkWell(
                        onTap: () {
                          log(initScreen.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Welcome2()),
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
    );
  }
}
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Screen/Login/_login.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_welcome_3.dart';
import 'package:flutter_riderapp/main.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome2 extends StatefulWidget {
  const Welcome2({super.key});
  @override
  State<Welcome2> createState() => _Welcome2State();
}

class _Welcome2State extends State<Welcome2> {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.14,
                      ),
                      child: Text(
                        'Check',
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
                          left: MediaQuery.of(context).size.width * 0.003,
                          bottom: Get.height * 0.05),
                      child: Text(
                        'Appointments',
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

//1. To Turn over a new leaf => (d) To Change the old habits and adopt new ones
//2. A fair crack of the -whip =>  (c) A period of importance
//3. To talk ones head off => (d) To Talk Excessively
//4. To hold somthing in leash =>(a)  To restrain
//5. To play fast and loose => (b) To be undependable

//6. The Wrangle over an ass's shadow=>  (b) To Querral over Trifle
//7. All Agog => (c) Restless
//8. To Frame a Person => (b) To make one appear guilty
//9. To Close Shave => (d) A narrow escape
//10. To take with a grain of salt=>(a) To take with some reservation

//11. To keep ones head =>(b) To keep calm
//12. To cross Sword => (a) To Fight
//13. A snake in the Grass => (c) Unrecoganisable danger
//14. To give up the ghost =>(c) To die
//15. Hobson's Choice => (b)Accept or leave the offer

//16 To be at loggerheads => (b) To be at anmity or strife
//17 To talk through ones hat => (b) To talk nonsense
//18  To snap one's Finger => (d) To become contemptious of
//19 A pipe Dream => (c) An impracticable plan
//20 To give up the ghost => (a) to die

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                ),
                Image.asset(
                  'assets/Frame.png',
                  height: Get.height * 0.35,
                ),
                SizedBox(
                  height: Get.height * 0.04,
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
                              builder: (context) => const Welcome3()),
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

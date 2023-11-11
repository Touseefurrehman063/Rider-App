import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Screen/Login/_login.dart';
import 'package:flutter_riderapp/main.dart';
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
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                child: Text(
                  'Helpful',
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
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              Image.asset('assets/bike.png'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
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
            ],
          ),
        ],
      ),
    );
  }
}
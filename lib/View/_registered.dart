
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riderapp/View/_login.dart';

class Registered extends StatefulWidget {
  const Registered({super.key});

  @override
  State<Registered> createState() => _RegisteredState();
}

class _RegisteredState extends State<Registered> {

  @override


  Widget build(BuildContext context) {
    return  Scaffold(
body: Container(
  height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/helpbackgraound.png'),
            alignment: Alignment.centerLeft,
          ),
        ),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.04),
              child: Image.asset("assets/help.png",
              height: MediaQuery.of(context).size.height*0.07,
              width: 180,
              
            
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.23,),
                SizedBox(
                  
                  child: Text("Registered",style: GoogleFonts.poppins(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue,),)),
                SizedBox(
                  
                  child: Text("Your request has been registered",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black,),)),
                  SizedBox(
                  
                  child: Text("Our Support Team will contact shortly ",style: GoogleFonts.poppins(fontSize: 12,color: Colors.black,),)),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                CupertinoButton(

                  
                  onPressed: () {
     Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: ((context) {
                          return const Login();
                        })),
                      );

                  },
                  
                  color:CupertinoColors.activeBlue,  padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
            borderRadius: BorderRadius.circular(8),

                  
                  child: Text("LOGIN",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15),), ),
                
              ],
            )

            
            
            ])
),
      
    );
  }
}
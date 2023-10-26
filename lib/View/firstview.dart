import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/View/_appointments_history.dart';
import 'package:flutter_riderapp/View/_splash_screen.dart';
import 'package:flutter_riderapp/View/_today_appoinments.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class FirstView extends StatefulWidget {
 
  User? user;
   FirstView({this.user,super.key});

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {

 


   String _getGreetingMessage() {
    
    var now = DateTime.now();
    var hour = now.hour;

    if (hour < 10) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else if (hour < 22) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
  Future<void> saveLoginState() async {
  
    var sharedpref = await SharedPreferences.getInstance();
    sharedpref.setBool(SplashscreenState.KEYLOGIN, true);
   

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body:
      
       LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Stack(
              children: [
                Image.asset(
                  'assets/main.png',
                  fit: BoxFit.fitWidth,
                  height: constraints.maxHeight / 1.8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: constraints.maxHeight /17,
                      
                      
                    ),
                     SizedBox(
                        
                        height: constraints.maxHeight / 8,
                        width: constraints.maxWidth / 1.3,
                        child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           
                             
                             
                            
                              
                                 Image.asset( 
                                  "assets/pp.jpg",
                                  height: MediaQuery.of(context).size.height*0.1,
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
                                          text: 'Hi, ${(userprofile?.fullName ?? "Tabib Rider").length > 10 ? (userprofile?.fullName ?? "Tabib Rider").substring(0, 10) + '...' : (userprofile?.fullName ?? "Tabib Rider")}',

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
                                            letterSpacing: 4.5,
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
                                            builder: (context) =>
                                                TodayAppoinments(empId: userprofile?.id??""),
                                          ),
                                        );
                                        print('Image tapped!');
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: constraints.maxHeight / 3.5),
                                        child: Image.asset(
                                          'assets/cont1.png',
                                          height: Get.height*0.20,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AppointmentHistory(empId: userprofile?.id??""),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: constraints.maxHeight / 3.5),
                                    child: Image.asset(
                                      'assets/cont2.jpg',
                                           height: Get.height*0.20,
                                    ),
                                  ),
                                ),
                                  ],
                                ),
                            //     SizedBox(
                            //       height: MediaQuery.of(context).size.height*0.03,
                            //     ),
                            //     Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // children: [
                            //   GestureDetector(
                            //     onTap: () {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //         const SnackBar(
                            //           content: Text('Registring and Ordering'),
                            //           duration: Duration(seconds: 3),
                            //         ),
                            //       );
                            //       print('Image tapped!');
                            //     },
                            //       child: Image.asset(
                            //           'assets/cont3.png',
                            //                height: Get.height*0.20,
                            //         ),
                                
                            //   ),
                            //   GestureDetector(
                            // onTap: () {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text('Coming Soon'),
                            //       duration: Duration(seconds: 3),
                            //     ),
                            //   );
                            // },
                            //   child: Image.asset(
                            //     'assets/cont4.png',
                            //   ),
                                          
                            //               ),
                            // ],
                            //               ),
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
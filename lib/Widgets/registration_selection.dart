
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Screen/Families_screen/_patient_registration.dart';
import 'package:flutter_riderapp/Widgets/appimages.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';


void RegistrationSelectionPopup(
    BuildContext context,
    BoxConstraints constraints
  //  TextEditingController fullNameController,
) {
  showDialog<void>(

      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(

            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: SizedBox(

               width: MediaQuery.of(context).size.height * 0.39,

               // decoration:
               //      BoxDecoration(borderRadius: BorderRadius.circular(100),),
                  //   gradient: AppConstant.themValue! ? AppConstant.dialogGradient : null,),
              child: SingleChildScrollView(
                child:
                   Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                AppImages.cross,
                                height: 21,
                                width: 21,
                              )),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.01,
                        ),

                        CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: ((context) {
                                  return const PatientRegistration();
                                })),
                              );

                            },
                            color:CupertinoColors.activeBlue,
                            borderRadius: BorderRadius.circular(8),

                            child: Padding(
                              padding: const EdgeInsets.only(right:20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    AppImages.RegistrationIcon,
                                    height: 40,
                                  ),
                                  Text(
                                    'registration'.tr,
                                    style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),
                                  )
                                ],
                              ),
                            )
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.01,
                        ),
                        CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            onPressed: () {
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(builder: ((context) {
                              //     return const Login();
                              //   })),
                              // );

                            },
                            color:CupertinoColors.activeBlue,
                            borderRadius: BorderRadius.circular(8),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Image.asset(
                                    AppImages.RegistrationPatientIcon,
                                     height: 35,
                                
                                  ),
                                ),
                                Text(
                                  'registerpatient'.tr,
                                  style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),
                                )
                              ],
                            )
                        ),

                      ])
              ),
            ),
          );
        });
      });
}
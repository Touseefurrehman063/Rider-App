import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Repositeries/Notificationrepo/notification_repo.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_appointments_history.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Widgets/custom_notification.dart';
import 'package:flutter_riderapp/controllers/Notification/notification_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';




// ignore: must_be_immutable
class notification extends StatefulWidget {


   const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  User? user;
  String EndDate = "";
  String StartDate = "";
    int start = 0;
    int length=10;

 @override
  void initState() {
    // TODO: implement initState
     NotificationRepository().getnotifications(userprofile!.id.toString(), formatLastMonthDate().toString(), formatDate(DateTime.now()).toString(), 10, 0);
   

    super.initState();
  }
 String formatLastMonthDate() {
  final now = DateTime.now();
  final lastMonth = DateTime(now.year, now.month - 1, now.day);

  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(lastMonth);
}

  @override
  Widget build(BuildContext context) {
//     return Scaffold(

//       appBar: AppBar(
//         shadowColor: Colors.white,
//         backgroundColor: Colors.white,
//         elevation: 0.0,
        
//         title: SizedBox(
//           width: 150,
//                               height: MediaQuery.of(context).size.height*0.05,
          
//           child: Text("Notification",style: GoogleFonts.poppins(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 24),)),
    
//   ),

      
//     drawer: const DrawerContent(),
//   body:Container(
    
//  child: Center(child: Text("No Notifications found",style: GoogleFonts.poppins(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 30),))),
  

//     );
return  SafeArea(child: Scaffold(
   appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0.0,
        
        title: SizedBox(
          width: 150,
                              height: MediaQuery.of(context).size.height*0.09,
          
          child: Center(child: Text("notification".tr,style: GoogleFonts.poppins(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 24),))),
    
  ),

      body: GetBuilder<notificationscontroller>(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children:  [
               Padding(
                 padding: EdgeInsets.only(right:Get.width*0.7),
                 child:  Text("notification".tr,style: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
               ),
              
                const Padding(
                  padding: EdgeInsets.only(left:10.0),
                  child: CustomNotification(),
                ),
              //   SizedBox(height: Get.height*0.05,),
              //   Padding(
              //    padding: EdgeInsets.only(right:Get.width*0.7),
              //    child: const Text("Yesterday",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
              //  ),
              //   const CustomNotification(),
                
              ],
            ),
          );
        }
      ),
    ));
  }


}

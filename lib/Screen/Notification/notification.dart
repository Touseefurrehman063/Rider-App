import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Widgets/custom_notification.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';




// ignore: must_be_immutable
class notification extends StatefulWidget {


   const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {

 


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
                              height: MediaQuery.of(context).size.height*0.05,
          
          child: Text("Notification",style: GoogleFonts.poppins(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 24),)),
    
  ),

      body: SingleChildScrollView(
        child: Column(
          children:  [
           Padding(
             padding: EdgeInsets.only(right:Get.width*0.8),
             child: const Text("Today",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
           ),
          
            const CustomNotification(),
            SizedBox(height: Get.height*0.05,),
            Padding(
             padding: EdgeInsets.only(right:Get.width*0.7),
             child: const Text("Yesterday",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
           ),
            const CustomNotification(),
            
          ],
        ),
      ),
    ));
  }


}

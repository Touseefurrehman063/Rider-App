import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Widgets/custom_notification.dart';
import 'package:get/get.dart';

class HomeNotification extends StatefulWidget {
const HomeNotification({super.key});

  @override
  State<HomeNotification> createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(

      body: Padding(padding: EdgeInsets.all(20),
      child: Column(
        children: [
         const  Text("Today",style: TextStyle(fontSize: 16,color: Colors.black),),
          SizedBox(height: Get.height*0.05,),
          CustomNotification(),
          
        ],
      ),
      
      ),
    ));
  }
}
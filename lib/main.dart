import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/View/_splash_screen.dart';
import 'package:flutter_riderapp/data/Notification_repo/Notification_repo.dart';
import 'package:get/get.dart'; 

int? initScreen;

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationsRepo().initLocalNotifications();
  await NotificationsRepo().initNotifications();
  await NotificationsRepo().firebaseInit();
  runApp(const MyApp(),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key}); 
  @override
  Widget build(BuildContext context) {  
    return const GetMaterialApp(
      debugShowCheckedModeBanner:false,
      home: Splashscreen()
    );
  }
}


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/LocalDb/localDB.dart';
import 'package:flutter_riderapp/Models/languages_Model/languagesmodel.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_splash_screen.dart';
import 'package:flutter_riderapp/Widgets/Utils/init.dart';
import 'package:flutter_riderapp/Widgets/languages.dart';
import 'package:flutter_riderapp/controllers/Languages_controller/languages_controller.dart';
import 'package:flutter_riderapp/data/Notification_repo/Notification_repo.dart';
import 'package:get/get.dart';

int? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationsRepo().initLocalNotifications();
  await NotificationsRepo().initNotifications();
  await NotificationsRepo().firebaseInit();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.ltr,
      translations: Localization(),
      locale: const Locale('en', 'US'),
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
    );
  }
}

getLocale() async {
  LanguageModel? lang = await LocalDb().getLanguage();
  if (lang == null) {
    lang = LanguageModel(
        id: 1, name: 'English', image: null, locale: const Locale('en', 'US'));
    Get.updateLocale(lang.locale!);
    LanguageController.i.selected = AppConstants.languages[0];
  } else {
    Get.updateLocale(lang.locale!);
  }
  if (lang.id == 1) {
    LanguageController.i.selected = AppConstants.languages[0];
  } else if (lang.id == 2) {
    LanguageController.i.selected = AppConstants.languages[1];
  } else {
    LanguageController.i.selected = AppConstants.languages[2];
  }
}


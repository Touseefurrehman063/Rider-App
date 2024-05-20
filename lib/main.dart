import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/LocalDb/localDB.dart';
import 'package:flutter_riderapp/Models/languages_Model/languagesmodel.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_splash_screen.dart';
import 'package:flutter_riderapp/Screen/google_maps/google_mpas.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Widgets/Utils/init.dart';
import 'package:flutter_riderapp/Widgets/languages.dart';
import 'package:flutter_riderapp/controllers/Languages_controller/languages_controller.dart';
import 'package:flutter_riderapp/controllers/google_maps_controller/google_maps_controller.dart';
import 'package:flutter_riderapp/data/Notification_repo/Notification_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationsRepo().initLocalNotifications();
  await NotificationsRepo().initNotifications();
  await NotificationsRepo().firebaseInit();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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

Future<Position?> determinePosition() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      log('$permission 2');
      openAppSettings();
    }
  } else if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    Get.to(() => const GoogleMaps());
    await AddressController.i.getcurrentLocation().then(
      (value) async {
        AddressController.i.latitude = value.latitude;
        AddressController.i.longitude = value.longitude;
        await AddressController.i
            .initialAddress(value.latitude, value.longitude);
        AddressController.i.markers.clear();
        AddressController.i.markers.add(Marker(
            infoWindow: const InfoWindow(
                title: 'Current Location', snippet: 'current Location'),
            position: LatLng(value.latitude, value.longitude),
            markerId: const MarkerId('1')));
      },
    );
  }
  return null;
}

String containsFile(String? path) {
  if (path != null && path.split('/').contains('File')) {
    return ip2;
  } else {
    return ip2;
  }
}

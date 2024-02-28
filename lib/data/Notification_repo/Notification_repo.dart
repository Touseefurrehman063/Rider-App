// import 'dart:developer';

// import 'dart:math' as dm;

// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_riderapp/Repositeries/localdb.dart';

// class NotificationsRepo {
//   final _fcm = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _plugin =
//       FlutterLocalNotificationsPlugin();

// // final _messageStreamController = BehaviorSubject<RemoteMessage>();

//   Future<void> initNotifications() async {
//     _fcm.requestPermission();
//     // ignore: unused_local_variable
//     final fcm = await _fcm.getToken().then((value) {
//       // _fcm.subscribeToTopic('all');
//       log('saved token is $value');
//       LocalDB().saveDeviceToken(value);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       await handleBackgroundMessage(message);
//     });

//   }

//   Future<void> showNotifications(RemoteMessage message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//         dm.Random.secure().nextInt(100000).toString(),
//         'High Importance Notification');
//     AndroidNotificationDetails details = AndroidNotificationDetails(
//       channel.id.toString(),
//       channel.name.toString(),
//       channelDescription: 'Channel Description',
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'Ticker',
//     );

//     DarwinNotificationDetails darwin = const DarwinNotificationDetails(
//         presentAlert: true, presentBadge: true, presentSound: true);

//     NotificationDetails notifs =
//         NotificationDetails(android: details, iOS: darwin);

//     Future.delayed(Duration.zero, () {
//       _plugin.show(0, message.notification?.title.toString(),
//           message.notification?.body.toString(), notifs);
//         log(message.data.toString());
//     });
//   }

//   firebaseInit() {
//     FirebaseMessaging.onMessage.listen((message) async {

//       log(message.notification!.body.toString());
//       log(message.data.toString());
//       await showNotifications(message);
//     });
//   }

//   initLocalNotifications() async {
//     var androidInitializationSettings =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iosInitializationSettings = const DarwinInitializationSettings();

//     var init = InitializationSettings(
//         android: androidInitializationSettings, iOS: iosInitializationSettings);

//     await _plugin.initialize(
//       init,
//       onDidReceiveNotificationResponse: (details) {

//       },
//     );
//   }

//   Future<void> handleBackgroundMessage(RemoteMessage message) async {}
// }

// ignore_for_file: unused_local_variable, file_names, avoid_print

import 'dart:developer';
import 'dart:math' as dm;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riderapp/Repositeries/localdb.dart';

class NotificationsRepo {
  final _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

// final _messageStreamController = BehaviorSubject<RemoteMessage>();

  Future<void> initNotifications() async {
    _fcm.requestPermission();
    final fcm = await _fcm.getToken().then((value) {
      // _fcm.subscribeToTopic('all');
      log('saved token is $value');
      LocalDB().saveDeviceToken(value);
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    //   await handleBackgroundMessage(message);
    //   await showNotifications(message);
    // });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // print foreground message here.
      await showNotifications(message);
      await handleBackgroundMessage(message);
      // print('Handling a foreground message ${message.messageId}');
      // print('Notification Message: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        dm.Random.secure().nextInt(100000).toString(),
        'High Importance Notification');
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      // android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    AndroidNotificationDetails details = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'Ticker',
      icon: '@mipmap/ic_launcher',
    );

    DarwinNotificationDetails darwin = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notifs =
        NotificationDetails(android: details, iOS: darwin);

    Future.delayed(Duration.zero, () {
      _plugin.show(0, message.notification?.title.toString(),
          message.notification?.body.toString(), notifs);
      log(message.data.toString());
    });
  }

  firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) async {
      log(message.notification!.body.toString());
      log(message.data.toString());
      await showNotifications(message);
    });
  }

  initLocalNotifications() async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var init = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _plugin.initialize(
      init,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {}
}

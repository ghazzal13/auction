// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   // static final onNotifications = BehaviorSubject<String?>();

//   static Future initialize() async {
//     // const settings = InitializationSettings(
//     //     android: AndroidInitializationSettings("@mipmap/ic_launcher"));
//     // _flutterLocalNotificationsPlugin.initialize(settings,
//     //     onSelectNotification: ((payload) async {
//     //   onNotifications.add(payload);
//     // }));

//     // final InitializationSettings initializationSettings =
//     //     InitializationSettings(
//     //         android: AndroidInitializationSettings("@mipmap/ic_launcher"));
//     // _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   // static Future _notificationDetails() async {
//   //   return const NotificationDetails(
//   //       android: AndroidNotificationDetails(
//   //     'channel id',
//   //     'channel name',
//   //     channelDescription: 'channel description',
//   //     importance: Importance.max,
//   //   ));
//   // }

//   // static Future showNotification(
//   //         {int id = 1, String? title, String? body, String? payload}) async =>
//   //     _flutterLocalNotificationsPlugin.show(
//   //         id, title, body, await _notificationDetails(),
//   //         payload: payload);

//   static void display(RemoteMessage message) async {
//     try {
//       print("In Notification method");
//       Random random = new Random();
//       int id = random.nextInt(1000);
//       const NotificationDetails notificationDetails =   NotificationDetails(
//           android: AndroidNotificationDetails("mychanel", "my chanel",
//               channelDescription: 'your channel description',
//               importance: Importance.max,
//               priority: Priority.high,
//              ));
//       print("my id is ${id.toString()}");
//       await _flutterLocalNotificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//       );
//     } on Exception catch (e) {
//       print('Error>>>$e');
//     }
//   }
// }

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );
  static Future initialize() async {
    const settings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _flutterLocalNotificationsPlugin.initialize(settings,
        onSelectNotification: ((payload) async {
      onNotifications.add(payload);
    }));

    // final InitializationSettings initializationSettings =
    //     InitializationSettings(
    //         android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    // _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // static Future showNotification(
  //         {int id = 1, String? title, String? body, String? payload}) async =>
  //     _flutterLocalNotificationsPlugin.show(
  //         id, title, body, await _notificationDetails(),
  //         payload: payload);

  static void display(RemoteMessage message) async {
    Random random = Random();
    int id = random.nextInt(1000);
    const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
      "mychanel",
      "my chanel",
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    ));

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(notification.hashCode,
          notification.title, notification.body, notificationDetails
          // NotificationDetails(
          //   android: AndroidNotificationDetails(
          //     channel.id,
          //     channel.name,
          //     channelDescription: channel.description,
          //     icon: android.smallIcon,
          //     // other properties...
          //   ),
          //  )
          );
    }
  }
}





// print("my id is ${id.toString()}");
    // await _flutterLocalNotificationsPlugin.show(
    //   id,
    //   message.notification!.title,
    //   message.notification!.body,
    //   notificationDetails,
    // );
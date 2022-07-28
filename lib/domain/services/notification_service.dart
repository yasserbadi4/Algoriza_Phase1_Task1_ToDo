// import 'dart:js';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:my_todo_phase1/presentation/schedule_screen/schedule.dart';
//
// class NotificationHelper
// {
//   FlutterLocalNotificationsPlugin
//   flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin(); //
//
//   initializeNotification() async {
//     //tz.initializeTimeZones();
//     final IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings(
//         requestSoundPermission: false,
//         requestBadgePermission: false,
//         requestAlertPermission: false,
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification
//     );
//
//
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings("tasks");
//
//       final InitializationSettings initializationSettings =
//       InitializationSettings(
//       iOS: initializationSettingsIOS,
//       android:initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onSelectNotification: selectNotification);
//
//   }
//   }
//
// Future onDidReceiveLocalNotification(
//     int id, String? title, String? body, String? payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   showDialog(
//     //context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: Text(title!),
//       content: Text(body!),
//       actions: [
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           child: Text('Ok'),
//           onPressed: () async {
//             Navigator.of(context, rootNavigator: true).pop();
//             await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ScheduleScreen(),
//               ),
//             );
//           },
//         )
//       ],
//     ), context:
//   );
// }
// Future selectNotification(String? payload) async {
//   if (payload != null) {
//     //selectedNotificationPayload = "The best";
//     //selectNotificationSubject.add(payload);
//     print('notification payload: $payload');
//   } else {
//     print("Notification Done");
//   }
//
//   if(payload=="Theme Changed"){
//     //going nowhere
//   }else{
//
//
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//         builder: (context) => ScheduleScreen();
//   }
// }
// }
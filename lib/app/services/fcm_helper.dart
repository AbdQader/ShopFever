// import 'dart:math';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:logger/logger.dart';
// import 'package:pick_up_jo_client/app/data/local/shared_pref.dart';
//
// class FcmHelper {
//   static late FirebaseMessaging messaging;
//   static late FlutterLocalNotificationsPlugin notificationPlugin;
//
//   ///this function will initialize firebase and fcm instance
//   static Future<void> initFcm() async {
//     //initialize fcm and firebase core
//     await Firebase.initializeApp();
//     messaging = FirebaseMessaging.instance;
//
//     //initialize notification
//     initNotification();
//
//     //notification settings handler
//     await setupFcmNotificationSettings();
//
//     //generate token if it not already generated
//     await handleFcmToken();
//
//     //background and forground handlers
//     FirebaseMessaging.onMessage.listen(fcmForgroundHandler);
//     FirebaseMessaging.onBackgroundMessage(fcmBackgroundHandler);
//   }
//
//   ///handle fcm notification settings (sound,bade..etc)
//   static Future<void> setupFcmNotificationSettings() async {
//     //show notification with sound and badge
//     messaging.setForegroundNotificationPresentationOptions(
//         alert: true, sound: true, badge: true);
//
//     //NotificationSettings settings =
//     await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }
//
//   ///generate and save fcm token if its not already generated (generate only for 1 time)
//   static Future<void> handleFcmToken() async {
//     try{
//       //check if the token was already generated and saved and stop function if it is..
//       String? savedToken = SharedPref.getFcmToken();
//       if (savedToken != null) return;
//
//       //let fcm generate token for us
//       String? token = await messaging.getToken(
//         vapidKey: "BGpdLRs......",
//       );
//
//       //fail to generate token
//       if (token == null) {
//         //close app safly
//         //SystemNavigator.pop();
//         return; //stop method
//       }
//
//       //if token was generated successfully (save it to shared pref)
//       SharedPref.saveFcmToken(token);
//       Logger().e('Token => ${token}');
//       Logger().e('Token => ${SharedPref.getFcmToken()}');
//     }catch(error){
//       Logger().e('Error => ${error}');
//     }
//   }
//
//   ///handle fcm notification when app is closed/terminated
//   static Future<void> fcmBackgroundHandler(RemoteMessage message) async {
//     Logger().e('Message from background');
//     await showNotification(title: 'Title', body: 'Body');
//   }
//
//   //handle fcm notification when app is open
//   static Future<void> fcmForgroundHandler(RemoteMessage message) async {
//     Logger().e('Message from forground');
//     await showNotification(title: 'Title', body: 'Body');
//   }
//
//   //display notification for user with sound
//   static Future<void> showNotification(
//       {required String title, required String body}) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('Pick up jo client', 'Orders channel',
//             'this channel is used for order notificaitons',
//             importance: Importance.max,
//             priority: Priority.high,
//             showWhen: true);
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await notificationPlugin.show(Random().nextInt(999), 'plain title',
//         'plain body', platformChannelSpecifics,
//         payload: 'item x');
//   }
//
//   ///init notification
//   static initNotification() {
//     notificationPlugin = FlutterLocalNotificationsPlugin();
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings();
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsIOS);
//
//     notificationPlugin.initialize(initializationSettings);
//   }
// }

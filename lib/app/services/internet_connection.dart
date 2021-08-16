// import 'dart:async';
//
// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class InternetConnection {
//   ///keep listening to internet connection status
//   static void listenToInternetConnection() {
//     //instance of connectivity to be able to check internet connection
//     final Connectivity connectivity = Connectivity();
//
//     //this will only check for internet when app launch
//     connectivity.checkConnectivity().then((result) {
//       _handleInternetConnectionState(result);
//     });
//
//     //this will keep listening to internet connection all the time (when app is working)
//     connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       _handleInternetConnectionState(result);
//     });
//   }
//
//   ///this function will show dialog if there is no internet
//   static void _handleInternetConnectionState(ConnectivityResult result) {
//     if (result == ConnectivityResult.none) {
//       Get.dialog(
//         AlertDialog(
//           title: Text('No Internet'),
//           content: Text('There is no fucking internet..'),
//         ),
//         barrierDismissible: false,
//       );
//     } else {
//       if (Get.isDialogOpen != null) {
//         if (Get.isDialogOpen!) {
//           Get.back();
//         }
//       }
//     }
//   }
// }

// import 'dart:convert';
// import 'dart:html';
// import 'package:flutter/material.dart';
// import 'package:flutter_node_practice/services/data_helper.dart';


// class BroadcastService {
//   final BroadcastChannel _channel = BroadcastChannel('logout_channel');

//   void initialize() {
//     _channel.onMessage.listen((MessageEvent event) {
//       try {
//         final messageData = jsonDecode(event.data ?? {});
//         print("message data: $messageData");
//         String shopId = DataHelper().getShopID;
//         print("shop id 2: $shopId");
//         if (messageData['message'] == 'logout' &&
//             messageData['sessionId'] != sessionId &&
//             messageData['shopId'] == shopId) {
//           _showLogoutDialog();
//         }
//       } catch (e) {
//         print('Error decoding message data: $e');
//       }
//     });
//   }

//   void _showLogoutDialog() {
//     showDialog(
//       context: navigatorKey.currentContext!,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return const SessionExpiredDialog();
//       },
//     );
//   }
// }

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

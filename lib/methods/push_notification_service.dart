import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ridewave/global/global_var.dart';
import 'package:http/http.dart' as http;

class PushNotificationService {
  static sendNotificationToSelectedDriver(
      String deviceToken, BuildContext context, String tripID) async {
    Map<String, String> headerNotificationMap = {
      "Content-Type": "application/json",
      "Authorization":
          "key=$serverKeyFCM", // Pastikan kunci diawali dengan 'key='
    };

    Map titleBodyNotificationMap = {
      "title": "Request from $userName - $userFaculty!",
      "body": "Click here to respond the request.",
    };

    Map dataMapNotification = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "tripID": tripID,
    };

    Map bodyNotificationMap = {
      "notification": titleBodyNotificationMap,
      "data": dataMapNotification,
      "priority": "high",
      "to": deviceToken,
    };

    try {
      http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: headerNotificationMap,
        body: jsonEncode(bodyNotificationMap),
      );

      if (response.statusCode == 200) {
      } else {}
    // ignore: empty_catches
    } catch (e) {}
  }
}

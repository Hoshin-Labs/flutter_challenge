import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
  final int id;
  final String title;
  final String body;
  final String payload;
}

class LocalNotfications {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  // ignore: avoid_positional_boolean_parameters
  Future<void> initialize({
    bool requestAlertPermission = true,
    bool requestBadgePermission = true,
    bool requestSoundPermission = true,
  }) async {
    const androidinitializationSettings = AndroidInitializationSettings('app_icon');

    const initializationSettings = InitializationSettings(
      android: androidinitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
  
    );
  }

  Future selectNotification(String? payload, BuildContext context) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  Future<void> showNotification(String title, String body) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await LocalNotfications().flutterLocalNotificationsPlugin.show(
          DateTime.now().microsecond,
          title,
          body,
          platformChannelSpecifics,
          payload: 'item x',
        );
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/app/core/presentation/notifications/local_notifications.dart';

class PushNotifications {
  PushNotifications() {
    _messaging = FirebaseMessaging.instance;
    requestNotificationPermission();
    subscribe();
  }
  late final FirebaseMessaging _messaging;
  late final NotificationSettings settings;

  Future<void> subscribe() async {
    try {
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> requestNotificationPermission() async {
    settings = await _messaging.requestPermission();
  }

  Future<void> initialize(BackgroundMessageHandler handler) async {
    FirebaseMessaging.onMessage.listen(_messageHandler);
    FirebaseMessaging.onBackgroundMessage(handler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onAppOpenedFromBackground);
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _onTerminatedAppOpenedFromBackground(initialMessage);
    }
  }

  void _messageHandler(RemoteMessage message) {
    if (message.notification != null) {
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );
      const platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      if (message.notification != null) {
        LocalNotfications().flutterLocalNotificationsPlugin.show(
              DateTime.now().microsecond,
              message.notification!.title ?? '<App-Name>',
              message.notification!.body ?? 'Notification body',
              platformChannelSpecifics,
            );
      }
    }
  }

  void _onAppOpenedFromBackground(RemoteMessage message) {
    if (message.notification != null) {
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );
      const platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      if (message.notification != null) {
        LocalNotfications().flutterLocalNotificationsPlugin.show(
              DateTime.now().microsecond,
              message.notification!.title ?? '<App-Name>',
              message.notification!.body ?? 'Notification body',
              platformChannelSpecifics,
            );
      }
    }
  }

  void _onTerminatedAppOpenedFromBackground(RemoteMessage message) {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    if (message.notification != null) {
      LocalNotfications().flutterLocalNotificationsPlugin.show(
            DateTime.now().microsecond,
            message.notification!.title ?? '<App-Name>',
            message.notification!.body ?? 'Notification body',
            platformChannelSpecifics,
          );
    }
  }
}

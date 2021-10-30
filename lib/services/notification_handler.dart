import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void onMessageForegroundHandler(RemoteMessage message) {
  FirebaseCrashlytics.instance.log('onMessageForegroundHandler');
  RemoteNotification? notification = message.notification;

  if (notification != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails('channel_id', 'channel_name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker'),
        ));
  }
}

Future<void> onMessagingBackgroundHandler(RemoteMessage message) async {
  FirebaseCrashlytics.instance.log('onMessagingBackgroundHandler');
  await Firebase.initializeApp();

  RemoteNotification? notification = message.notification;

  if (notification != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails('channel_id', 'channel_name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker'),
        ));
  }
}

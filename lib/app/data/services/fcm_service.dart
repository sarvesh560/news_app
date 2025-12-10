import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _local =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _local.initialize(initSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'For important notifications',
      importance: Importance.high,
    );

    await _local
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((message) {
      showNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
    });
  }

  static Future<void> requestPermission() async {
    await _messaging.requestPermission();
    String? token = await _messaging.getToken();
    print("FCM TOKEN: $token");
  }

  static void showNotification({String? title, String? body}) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notifDetails = NotificationDetails(android: androidDetails);

    await _local.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title ?? "Notification",
      body ?? "",
      notifDetails,
    );
  }
}

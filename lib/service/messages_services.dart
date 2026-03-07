import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagesServices {
  final firebase = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel androidNotificationChannel =
      AndroidNotificationChannel(
        "high_importance_channel",
        "High Importance Notifications",
        description: "This channel is used for important notifications",
        importance: Importance.high,
      );

  Future<void> messagePermission() async {
    final settings = await firebase.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User accept the message");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("Notifications enabled (silent mode)");
    } else {
      debugPrint("User denied to gain notification of this app");
    }
  }

  Future<String?> getToken() async {
    return await firebase.getToken();
  }

  Future<void> showNotification(RemoteMessage message) async {
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          androidNotificationChannel.id.toString(),
          androidNotificationChannel.name.toString(),
          sound: RawResourceAndroidNotificationSound("notification_rigton"),
          importance: androidNotificationChannel.importance,
          channelDescription: androidNotificationChannel.description,
          color: Colors.green,
          // fullScreenIntent: true,
          icon: "@mipmap/ic_launcher",
          // ledColor: Colors.lightGreenAccent,
          priority: Priority.high,
          // visibility: NotificationVisibility.public,
          // ticker: "ticker",
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    String title =
        message.data['title'] ??
        message.notification?.title.toString() ??
        'Checking test notification title';
    String body =
        message.data['body'] ??
        message.notification?.body.toString() ??
        'Checking test notification body';
    Future.delayed(Duration.zero, () async {
      await flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        notificationDetails,
      );
    });
  }

  void messageInit() {
    FirebaseMessaging.onMessage.listen((message) async {
      debugPrint(message.notification?.title.toString());
      debugPrint(message.notification?.body.toString());
      await showNotification(message);
    });
  }

  Future<void> initLocalNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (response) {},
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidNotificationChannel);
  }
  void messageShowing(){
    messagePermission();
    messageInit();
    initLocalNotification();
  }
}

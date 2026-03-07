import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagesServices {
  //create an instance of firebaseMessaging
  final firebase = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //this define the android notification channel
  static const AndroidNotificationChannel androidNotificationChannel =
      AndroidNotificationChannel(
        "high_importance_channel",
        "High Importance Notifications",
        description: "This channel is used for important notifications",
        importance: Importance.high,
      );

  ///this is used for giving permission from user for notification
  Future<void> messagePermission() async {
    final settings = await firebase.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User accept the message");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("Notifications enabled (silent mode)");
    } else {
      debugPrint("User denied to get notification of this app");
    }
  }

  //this is used for getting the current device token
  Future<String?> getToken() async {
    return await firebase.getToken();
  }

  //this will show the notification
  Future<void> showNotification(RemoteMessage message) async {
    //this define the notification detail for ios
    final DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentBanner: true,
          presentSound: true,
        );
    //this will define the notification detail for android
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
    //here we write the defined variables of notification details
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
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
      //this will show the notification of title and body
      await flutterLocalNotificationsPlugin.show(
        1,
        title,
        body,
        notificationDetails,
      );
    });
  }

  //here we initialize message for showing the notification
  void messageInit() {
    FirebaseMessaging.onMessage.listen((message) async {
      debugPrint(message.notification?.title.toString());
      debugPrint(message.notification?.body.toString());
      await showNotification(message);
    });
  }

  //here we initialize the local notification with android and ios setting
  Future<void> initLocalNotification() async {
    //this will define the notification setting for ios
    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
          requestCriticalPermission: true,
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    //this will define the notification setting for android
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    //define the initialization setting for ios and android
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (response) {},
    );
    //this will used for platform specific implementation mean that On Android 8.0+ (API 26+) is required
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  //all function call for showing the notification to user from firebase app
  void messageShowing() {
    messagePermission();
    messageInit();
    initLocalNotification();
  }
}

import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MessagingService {
  final _localNotification = FlutterLocalNotificationsPlugin();
  final _firebase = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'high_importance_notification',
      description: 'this channel is used for important notification ',
      importance: Importance.defaultImportance);
  Future<void> initNotifications() async {
    await _firebase.requestPermission();
    final fcmToken = await _firebase.getToken();
    debugPrint("Token : $fcmToken");
    initPushNotification();
    initialFirebaseMessaging();
    initLocalNotification();
  }

  initPushNotification() {
    initialFirebaseMessaging();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    setupInteractedMessage();
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  Future initLocalNotification() async {
    //handle interaction perform specific action
    //const ios =IosIntializtionsetting();
    const android = AndroidInitializationSettings('ic_launcher');
    const InitializationSettings settings =
        InitializationSettings(android: android);
    await _localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
          //handleMessage(message)
        }
      },
    );
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  void _handleMessage(RemoteMessage message) {
    //navigate
    if (message.data['name'] == "nader sayed") {
      debugPrint(
          '////////////////////////////////////////success 1 background //${message.data}//////////////////////////////////////////');
    }
  }

  initialFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');
      final notification = message.notification;
      if (notification != null) {
        _localNotification.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: 'ic_launcher'),
            ),
            payload: jsonEncode(message.toMap()));
        debugPrint(
            '////////////////////////////////////////notification//////////////////////////////////////////');
      } else {
        debugPrint(
            '////////////////////////////////////////error//////////////////////////////////////////');
      }
    });
  }
}

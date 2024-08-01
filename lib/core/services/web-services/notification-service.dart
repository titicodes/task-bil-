import 'dart:convert';
import 'dart:io';

import 'package:web_socket_channel/io.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  IOWebSocketChannel? channel;

  getNotifications() async {
    var message = {"command": "get_general_notifications", "page_number": 1};
    var data = {
      "command": "get_new_chat_notifications",
      "newest_timestamp": "${DateTime.now()}"
    };

    channel!.sink.add(jsonEncode(message));
    channel!.sink.add(jsonEncode(data));
  }

  initSocket(String token) async {
    Map<String, String> headers = {
      'Authorization': 'Token $token',
      'Origin': 'https://taskitly.com/',
      'Connection': 'Upgrade',
      'Upgrade': 'websocket',
    };

    String socketUrl = 'wss://taskitly.com/ws/notification/';

    // Append headers to the WebSocket URL
    Uri modifiedUri = Uri.parse(socketUrl);

    try {
      channel = IOWebSocketChannel.connect(
        modifiedUri,
        protocols: ['websocket'],
        headers: headers,
      );

      await channel!.ready
          .onError((error, stackTrace) => print("FROM SOCKET ERROR $error"))
          .catchError((error, stackTrace) => print("FROM SOCKET $error"))
          .whenComplete(() async {
        print("Connected");
        await getNotifications();
      });
    } catch (err) {
      print('Error connecting to WebSocket: $err');
    }
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("NOTIFICATION RECIEVED");

  Noti.handleMessage(message);
}

class Noti {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            provisional: false,
            critical: false);
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestCriticalPermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          showBigTextNotification(title: "$title", body: "$body");
        });
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);

    FirebaseMessaging.onMessage.listen(handleMessage);
    Platform.isIOS
        ? FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage)
        : () {};
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //   alert: true, // Required to display a heads up notification
    //   badge: true,
    //   sound: true,
    // );
  }

  // static initializeLocal() async {
  //   FirebaseMessaging.onMessage.listen(handleMessage);
  //   FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  //   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true, // Required to display a heads up notification
  //     badge: true,
  //     sound: true,
  //   );
  // }

  static handleMessage(RemoteMessage? message) {
    // print(jsonEncode(message?.notification));
    if (message != null) {
      showBigTextNotification(
          title: "${message.notification?.title}",
          body: "${message.notification?.body}");
    }
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'Taskitly', // id
      'Taskitly', // title
      channelDescription: "Taskitly",
      playSound: true,
      icon: 'mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails(
            interruptionLevel: InterruptionLevel.critical,
            presentAlert: true,
            presentBadge: true,
            presentBanner: true,
            presentList: true,
            presentSound: true,
            sound: 'default'
            // sound: 'sounds.wav'
            ));
    await flutterLocalNotificationsPlugin.show(0, title, body, not);
  }
}

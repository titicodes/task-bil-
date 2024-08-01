import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/reuseables.dart';
import '../../core/models/chat/unread-chat-model.dart';
import '../../core/models/new-notification-response.dart';
import '../../core/models/notification-response.dart';
import '../../core/services/local-service/storage-service.dart';
import '../../core/services/web-services/notification-service.dart';
import '../../locator.dart';
import '../base/base.vm.dart';
import 'bills-view/bill-view-ui.dart';
import 'bills-view/coming_soon/coming_soon_ui.dart';
import 'browse-view/browse-view-ui.dart';
import 'chat-view/chat-home-view.ui.dart';
import 'home-view/home-view-ui.dart';
import 'request-view/request-view-ui.dart';
import 'settings-view/settings-view-ui.dart';

class HomeTabViewModel extends BaseViewModel {
  init(int initialIndex) async {
    pages = [
      const HomeViewScreen(),
      userService.isUserServiceProvider
          ? const ChatHomeView()
          : const BrowseViewScreen(),
      // const BrowseViewScreen(),
      RequestViewScreen(
        someValueNotifier: someValueNotifier,
      ),
      //const BillViewScreen(),
      const ComingSoonScreen(),
      const SettingsViewScreen()
    ];
    selectedPage = initialIndex;
    notifyListeners();
    appCache.initialIndex = 0;
    Platform.isIOS ? await initFirebaseMessaging() : () {};
    sendToken();
    await notificationSocket();
    unreadCount();
  }

  Future<void> initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      String? token = await messaging.getAPNSToken();
      // Handle the token (e.g., send it to your server)
      print('APNS Token: $token');
    } catch (e) {
      print('Error getting APNS token: $e');
    }
  }

  List<Notifications> allNotifications = [];

  saveChat(List<Notifications> allNotification) {
    allNotifications = allNotification;
    print(allNotifications.length);
    notifyListeners();
  }

  unreadCount() async {
    var data = {"command": "get_unread_chat_notifications_count"};

    locator<NotificationService>().channel!.sink.add(jsonEncode(data));
  }

  // Define observable property
  final ValueNotifier<int> _someValueNotifier = ValueNotifier<int>(0);

  // Getter to access observable property
  ValueNotifier<int> get someValueNotifier => _someValueNotifier;

  // Method to update value
  void updateValue(int newValue) {
    _someValueNotifier.value = newValue;
    notifyListeners();
  }

  notificationSocket() {
    locator<NotificationService>().channel!.stream.listen(
      (onmessage) async {
        print("NOTIFICATION $onmessage");
        if (NotificationResponses.fromJson(jsonDecode(onmessage))
                .notifications
                ?.isNotEmpty ??
            false) {
          var not = NotificationResponses.fromJson(jsonDecode(onmessage));
          await saveChat(not.notifications ?? []);
          await repository.storeNotification(not);
        }
        if (NotificationIncomingResponse.fromJson(jsonDecode(onmessage))
                .message !=
            null) {
          Platform.isIOS ? await initFirebaseMessaging() : null;

          var not =
              NotificationIncomingResponse.fromJson(jsonDecode(onmessage));
          String? data = await locator<StorageService>()
              .readItem(key: DbTable.NOTIFICATION_TABLE_NAME);
          if (data == null) {
            NotificationResponses newNotification = NotificationResponses(
                generalMsgType: 0,
                notifications: [not.message ?? Notifications()]);
            await repository.storeNotification(newNotification);
          } else {
            NotificationResponses oldNotificationResponse =
                NotificationResponses.fromJson(jsonDecode(data));
            List<Notifications> update =
                oldNotificationResponse.notifications ?? [];
            update.insert(0, not.message ?? Notifications());
            await saveChat(update);
            NotificationResponses newNotification = NotificationResponses(
                generalMsgType: oldNotificationResponse.generalMsgType,
                notifications: update);
            await repository.storeNotification(newNotification);
          }

          // await repository.sendNotification(
          //     title: (not.message?.notificationType??"").toCapitalized(),
          //     message: (not.message?.verb??"").toTitleCase()
          // );
        }
        if (UnreadMessageCountResponse.fromJson(jsonDecode(onmessage)).count !=
            null) {
          var not = UnreadMessageCountResponse.fromJson(jsonDecode(onmessage));
          updateValue(not.count ?? 0);
          // unreadCount();
        }
      },
      onDone: () {
        print('WebSocket channel closed');
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
    );
  }

  sendToken() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      var response = await repository.sendToken(
          data: fcmToken ?? "", type: Platform.isIOS ? "ios" : "android");
    } catch (e) {
      print('$e');
    }
  }

  int selectedPage = 1;

  void onNavigationItem(index) {
    selectedPage = index;
    notifyListeners();
  }

  Future<void> pop({bool? animated}) async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', animated);
  }

  List<Widget> pages = [];
}

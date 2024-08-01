import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskitly/UI/home/home.navigation.vm.dart';
import 'package:taskitly/core/services/web-services/chat-service.dart';
import 'package:taskitly/locator.dart';
import 'package:taskitly/utils/show-bottom-sheet.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp.dart';

import 'dart:core';
import '../../../../core/models/chat/get-chat-detail-user-info.dart';
import '../../../../core/models/chat/get-messages.dart';
import '../../../../core/models/chat/join-room-response.dart';
import '../../../../core/models/chat/join_a_room_model.dart';
import '../../../../core/models/chat/send-message-response.dart';
import '../../../base/base.vm.dart';
import '../../request-view/nav-request-view-ui.dart';
import 'chat-detail-ui.dart';
import 'send-invoice-ui.dart';

class ChatDetailViewModel extends BaseViewModel {
  GetChatDetailResponse chatDetailResponse = GetChatDetailResponse();
  GetChatUserDetailResponse chatUserResponse = GetChatUserDetailResponse();
  GetChatMessagesResponse messagesResponse = GetChatMessagesResponse();
  List<Messages> messages = [];

  final ScrollController controller = ScrollController();

  _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeOut,
      );
    });
    notifyListeners();
  }

  final Completer<GetChatUserDetailResponse?> _responseCompleter =
      Completer<GetChatUserDetailResponse?>();
  final Completer<GetChatMessagesResponse?> _completer =
      Completer<GetChatMessagesResponse?>();
  final Completer<JoinRoomResponse?> _joinRoomCompleter =
      Completer<JoinRoomResponse?>();

  StreamSubscription<dynamic>? chats;

  closeWebSocketChannel() {
    locator<ChatServices>().channel?.sink.close();
    locator<ChatServices>().channel =
        null; // Optional: Set channel to null if you don't need it anymore
    notifyListeners();
  }

  initSo() async {
    await locator<ChatServices>()
        .initSocket(userService.loginResponse.token ?? "");
    notifyListeners();
  }

  initSocket() async {
    await closeWebSocketChannel();
    await initSo();

    // Listen for incoming messages
    chats = locator<ChatServices>().channel!.stream.listen(
      (onmessage) async {
        GetChatMessagesResponse? chatData;
        GetChatUserDetailResponse? userInfo;
        SendMessageResponse? sendMessageResponse;
        JoinRoomResponse? joinRoomResponse;
        print(onmessage);
        if (GetChatUserDetailResponse.fromJson(jsonDecode(onmessage)).details !=
            null) {
          userInfo = GetChatUserDetailResponse.fromJson(jsonDecode(onmessage));
          _responseCompleter.complete(userInfo);
        }
        if (GetChatMessagesResponse.fromJson(jsonDecode(onmessage)).messages !=
            null) {
          chatData = GetChatMessagesResponse.fromJson(jsonDecode(onmessage));
          _completer.complete(chatData);
        }
        if (JoinRoomResponse.fromJson(jsonDecode(onmessage)).join != null) {
          joinRoomResponse = JoinRoomResponse.fromJson(jsonDecode(onmessage));
          _joinRoomCompleter.complete(joinRoomResponse);
        }
        if (SendMessageResponse.fromJson(jsonDecode(onmessage))
                .naturalTimestamp !=
            null) {
          sendMessageResponse =
              SendMessageResponse.fromJson(jsonDecode(onmessage));
          Messages example = Messages(
              message: sendMessageResponse.message,
              naturalTimestamp: sendMessageResponse.naturalTimestamp,
              username: sendMessageResponse.username,
              userId: sendMessageResponse.userId,
              msgType: sendMessageResponse.msgType);
          if (example.username != userService.user.username) {
            // print("Send Notification");
            // await repository.sendNotification(
            //     title: "Message from ${chatUserResponse.details?.userInfo?.fields?.lastName} ${chatUserResponse.details?.userInfo?.fields?.firstName}",
            //     message: example.message??""
            // );
          }
          messages.add(example);
          GetChatMessagesResponse all = GetChatMessagesResponse(
              messages: messages,
              newPageNumber: messagesResponse.newPageNumber,
              messagesPayload: messagesResponse.messagesPayload);

          await repository.storeLatestMessages(
              all, "${appCache.chatDetailResponse.chatroomId}");
          await _scrollDown();
          notifyListeners();
        }
      },
      onDone: () {
        print('WebSocket channel closed');
        _responseCompleter.completeError('WebSocket channel closed');
        _completer.completeError('WebSocket channel closed');
      },
      onError: (error) {
        print('WebSocket error: $error');
        _responseCompleter.completeError(error);
        _completer.completeError(error);
      },
    );

    chats?.resume();
  }

  popChat(ChatDetailViewModel model, Messages message) {
    showAppBottomSheet(ReportBlock(
      model: model,
      message: message,
    ));
  }

  deleteChat(Messages message) async {
    startLoader();
    try {
      var response = await repository.deleteMessage(id: message.msgId ?? "");
      if (response?.status == true) {
        messages.removeWhere((element) => element == message);
        GetChatMessagesResponse all = GetChatMessagesResponse(
            messages: messages,
            newPageNumber: messagesResponse.newPageNumber,
            messagesPayload: messagesResponse.messagesPayload);
        await repository.storeLatestMessages(
            all, "${appCache.chatDetailResponse.chatroomId}");
        navigationService.goBack();
      }
      notifyListeners();
      stopLoader();
    } catch (err) {
      print(err);
      stopLoader();
    }
  }

  reportChat() async {
    var mess = messages
        .firstWhere((element) => element.userId != userService.user.uid);
    await showDisputeIssues(mess.userId ?? "", "report");
  }

  reportUser() async {
    var mess = messages
        .firstWhere((element) => element.userId != userService.user.uid);
    await showDisputeIssues(mess.userId ?? "", "report");
  }

  blockUser() async {
    var mess = messages
        .firstWhere((element) => element.userId != userService.user.uid);
    await showDisputeIssues(mess.userId ?? "", "block");
  }

  getImage() async {
    final files = ValueNotifier(<File>[]);
    List<File>? res = await Navigator.push(
      navigationService.navigatorKey.currentState!.context,
      MaterialPageRoute(
        builder: (context) => const WhatsappCamera(
          multiple: false,
        ),
      ),
    );
    if (res != null) await uploadImage(res[0]);
    notifyListeners();
    print(files.value.length);
  }

  uploadImage(File image) async {
    startLoader();
    try {
      var response = await repository.uploadImage(image);
      if (response != null) {
        await sendMessage(messages: response);
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  String formatTimeString(String input) {
    if (input.toLowerCase().contains('today')) {
      // Extract time from the string
      RegExp regExp = RegExp(r'(\d{1,2}:\d{2} [APMapm]{2})');
      Match? match = regExp.firstMatch(input);

      if (match != null) {
        return match.group(1) ?? input;
      }
    }

    // If "today" is not found, return the first part of the string
    List<String> parts = input.split(' ');
    return parts.isNotEmpty ? parts[0] : input;
  }

  onChange(String? val) {
    // formKey.currentState!.validate();
    // print(formKey.currentState?.validate());
    notifyListeners();
  }

  var messageController = TextEditingController();

  sendMessage({String? messages}) async {
    var message = {
      "command": "send",
      "room": appCache.chatDetailResponse.chatroomId,
      "message": messages ?? messageController.text.trim()
    };
    try {
      locator<ChatServices>().channel!.sink.add(jsonEncode(message));
      await clearController();
      notifyListeners();
    } catch (err) {
      print(err);
      notifyListeners();
    }
  }

  clearController() async {
    messageController.clear();
    notifyListeners();
  }

  int pageNumber = 1;
  int nextPage = 0;

  init() async {
    chatDetailResponse = appCache.chatDetailResponse;
    getLocalChatUser("${appCache.chatDetailResponse.chatroomId}");
    getLocalChatMessage("${appCache.chatDetailResponse.chatroomId}");
    await initSocket();
    getUserChatChat("${appCache.chatDetailResponse.chatroomId}");
    getChatMessage("${appCache.chatDetailResponse.chatroomId}");
    await joinRoom("${appCache.chatDetailResponse.chatroomId}");
    await _scrollDown();
  }

  getUserChatChat(String chatRoom) async {
    var message = {"command": "get_user_info", "room_id": chatRoom};
    try {
      locator<ChatServices>().channel!.sink.add(jsonEncode(message));
      var response = await _responseCompleter.future;
      if (response?.details != null) {
        chatUserResponse = response ?? GetChatUserDetailResponse();
        await repository.storeChatUser(response, chatRoom);
      }
      notifyListeners();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  getLocalChatUser(String chatRoom) async {
    try {
      var response = await repository.getLocalChatUser(chatRoom);
      if (response?.details != null) {
        chatUserResponse = response ?? GetChatUserDetailResponse();
      }
      notifyListeners();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  joinRoom(String chatRoom) async {
    var message = {"command": "join", "room": chatRoom};
    try {
      locator<ChatServices>().channel!.sink.add(jsonEncode(message));
      await _joinRoomCompleter.future;
      notifyListeners();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  getChatMessage(String chatRoom) async {
    var message = {
      "command": "get_room_chat_messages",
      "room_id": chatRoom,
      "page_number": pageNumber
    };
    try {
      locator<ChatServices>().channel!.sink.add(jsonEncode(message));

      var response = await _completer.future;
      if (response?.messagesPayload != null) {
        messagesResponse = response ?? GetChatMessagesResponse();
        messages = response?.messages ?? [];
        nextPage = response?.newPageNumber ?? 0;
        await repository.storeLatestMessages(response, chatRoom);
      }
      notifyListeners();
      await _scrollDown();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  getLocalChatMessage(String chatRoom) async {
    try {
      var response = await repository.getLocalChatMessages(chatRoom);
      if (response?.messagesPayload != null) {
        messagesResponse = response ?? GetChatMessagesResponse();
        messages = response?.messages ?? [];
        nextPage = response?.newPageNumber ?? 0;
      }
      notifyListeners();
      await _scrollDown();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  popCreateInvoice(ChatDetailViewModel model) async {
    var isSuccessful =
        await navigationService.navigateToWidget(SendInvoiceScreen(mod: model));
    if (isSuccessful != null) {
      await sendMessage(messages: jsonEncode(isSuccessful));
    }
  }

  goToViewBookingsMore() {
    // appCache.initialIndex = 2;
    navigationService.navigateToWidget(NavRequestViewScreen(
      someValueNotifier: locator<HomeTabViewModel>().someValueNotifier,
    ));
  }

  List<String> skills = [];
}

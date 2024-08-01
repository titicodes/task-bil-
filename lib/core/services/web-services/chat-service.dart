import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taskitly/core/models/chat/send-message-response.dart';
import 'package:taskitly/core/services/web-services/base-api.dart';
import 'package:web_socket_channel/io.dart';
import '../../models/all_message_list.dart';
import '../../models/chat/join_a_room_model.dart';
import 'package:path/path.dart';

class ChatServices {
  IOWebSocketChannel? channel;

  initSocket(String token) async {
    Map<String, String> headers = {
      'Authorization': 'Token $token',
      'Origin': 'https://taskitly.com/',
      'Connection': 'Upgrade',
      'Upgrade': 'websocket',
    };

    try {
      String socketUrl = 'wss://taskitly.com/ws/chat/';

      Uri modifiedUri = Uri.parse(socketUrl);

      channel = IOWebSocketChannel.connect(
        modifiedUri,
        protocols: ['websocket'],
        headers: headers,
      );

      await channel!.ready
          .onError((error, stackTrace) => print("FROM SOCKET ERROR $error"))
          .catchError((error, stackTrace) => print("FROM SOCKET $error"))
          .whenComplete(() => print("Connected"));
    } catch (err) {
      print('Error connecting to WebSocket: $err');
    }
  }

  Future<GetChatDetailResponse?> getChatRoomData(String userID) async {
    try {
      Response response = await connect().post(
          "/chat/create_or_return_private_chat/",
          data: {"user2_id": userID});
      GetChatDetailResponse responseData =
          GetChatDetailResponse.fromJson(jsonDecode(response.data));
      return responseData;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<String?> uploadImage(File image) async {
    try {
      String? urlImage;
      UploadTask? uploadTask;

      final path = 'chatImage/${basename(image.path)}';

      print(path);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(File(image.path));

      final snapshot = await uploadTask.whenComplete(() {});

      urlImage = await snapshot.ref.getDownloadURL();
      print(urlImage);
      return urlImage;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<GetLastMessagesResponse?> getLatestChatsData() async {
    try {
      Response response = await privateConnect().get(
        "/chat/",
      );
      List<Map<String, dynamic>> chatList =
          jsonDecode(response.data)["data"].cast<Map<String, dynamic>>();
      chatList.sort((a, b) {
        DateTime timeA = DateTime.parse(a['last_message']['timestamp']);
        DateTime timeB = DateTime.parse(b['last_message']['timestamp']);
        return timeB.compareTo(timeA); // Compare timestamps in descending order
      });
      Map<String, dynamic> data = {"data": chatList};
      // print(data);
      GetLastMessagesResponse responseData =
          GetLastMessagesResponse.fromJson(data);
      return responseData;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<SendMessageResponse?> sendMessage(
      String chatRoomID, String messages) async {
    var message = {"command": "send", "room": chatRoomID, "message": messages};

    print(message);

    channel!.sink.add(jsonEncode(message));
    return null;
  }
}

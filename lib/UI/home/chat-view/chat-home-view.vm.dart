import '../../../core/models/all_message_list.dart';
import '../../../core/models/chat/join_a_room_model.dart';
import '../../../routes/routes.dart';
import '../../base/base.vm.dart';

class ChatHomeViewViewModel extends BaseViewModel {
  List<MessageData> userMessages = [];

  init() async {
    await getLocalBlockedUser();
    getLocalLatestChatsData();
    await getBlockedUsers();
  }

  getLocalLatestChatsData() async {
    try {
      var response = await repository.getLocalLatestChatsData();
      if (response != null) {
        List<MessageData>? messages = response
            .where((element) => element.lastMessage?.content != "")
            .toList();
        userMessages = messages
            .where((message) =>
                !blockedUsers.any((element) => element.uid == message.friendId))
            .toList();
        notifyListeners();
      }
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Stream<List<MessageData>?> getLatestChatsData() async* {
    var response = await repository.getLatestChatsData();
    if (response != null) {
      List<MessageData>? messages = response
          .where((element) => element.lastMessage?.content != "")
          .toList();
      userMessages = messages
          .where((message) =>
              !blockedUsers.any((element) => element.uid == message.friendId))
          .toList();
      notifyListeners();
      yield userMessages;
    } else {
      notifyListeners();
      yield null;
    }
  }

  goToChatDetail(MessageData val) async {
    GetChatDetailResponse chatDetailResponse = GetChatDetailResponse(
        user2Id: val.friendId ?? "",
        chatroomId: int.tryParse(val.lastMessage?.room ?? "") ?? 0);
    appCache.chatDetailResponse = chatDetailResponse;
    navigationService.navigateTo(chatDetailRoute).whenComplete(getBlockedUsers);
  }
}

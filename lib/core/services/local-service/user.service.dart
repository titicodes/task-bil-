import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskitly/core/models/new_login_response.dart';
import 'package:taskitly/core/models/registration-response.dart';
import 'package:taskitly/core/services/web-services/chat-service.dart';
import 'package:taskitly/core/services/web-services/notification-service.dart';
import 'package:taskitly/utils/snack_message.dart';
import '../../../constants/reuseables.dart';
import '../../../locator.dart';
import '../../../routes/routes.dart';
import '../../models/login-response.dart';
import '../../models/user-response.dart';
import 'storage-service.dart';

class UserService {
  User user = User();
  StorageService storageService = locator<StorageService>();
  final ChatServices _chatService = locator<ChatServices>();
  final NotificationService _notificationService =
      locator<NotificationService>();
  bool isUserLoggedIn = false;
  bool isUserServiceProvider = false;
  NewLoginResponse loginResponse = NewLoginResponse();
  RegisterResponse registerResponse = RegisterResponse();

  storeToken(NewLoginResponse? response) async {
    final box = GetStorage();
    box.write(DbTable.TOKEN_TABLE_NAME, response?.token);
    await storageService.storeItem(
        key: DbTable.LOGIN_TABLE_NAME, value: jsonEncode(response));
    loginResponse = response ?? NewLoginResponse();
    String? userToken = box.read(DbTable.TOKEN_TABLE_NAME);
    print("SAVED TOKEN::: $userToken");
    locator<UserService>().initializer();
  }

  getToken() async {
    final box = GetStorage();
    String? tokens = box.read(DbTable.TOKEN_TABLE_NAME);
    return tokens;
  }

  initializer() async {
    final box = GetStorage();
    String? userToken = box.read(DbTable.TOKEN_TABLE_NAME);
    String? userData =
        await storageService.readItem(key: DbTable.LOGIN_TABLE_NAME);

    if (userToken == null) {
      user = User();
      isUserLoggedIn = false;
    } else {
      await locator<NotificationService>().channel?.sink.close();
      await locator<ChatServices>().channel?.sink.close();
      locator<ChatServices>().channel = null;
      locator<NotificationService>().channel = null;
      await _chatService.initSocket(userToken);
      await _notificationService.initSocket(userToken);
      if (userData != null) {
        loginResponse = NewLoginResponse.fromJson(jsonDecode(userData));
        isUserServiceProvider = loginResponse.servicepro ?? false;
      }
      isUserLoggedIn = true;
      await getStoreUser();
    }
    print("ACCESS TOKEN:::: $userToken");
    print("Is User Logged In:::: $isUserLoggedIn");
    print("Is User Service Provider = $isUserServiceProvider");
  }

  storeUser(User? response) async {
    print("Store User");
    await storageService.storeItem(
        key: DbTable.USER_TABLE_NAME, value: jsonEncode(response));
    user = response ?? User();
  }

  storePrivateUser(User? response) async {
    await storageService.storeItem(
        key: DbTable.USER_TABLE_NAME, value: jsonEncode(response));
    user = response ?? User();
  }

  logout() async {
    final box = GetStorage();
    box.erase();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await storageService.deleteItem(key: DbTable.USER_TABLE_NAME);
    await storageService.deleteItem(key: DbTable.TOKEN_TABLE_NAME);
    await storageService.deleteItem(key: DbTable.LOGIN_TABLE_NAME);
    await storageService.deleteItem(key: DbTable.BANK_LIST_TABLE_NAME);
    await storageService.deleteItem(key: DbTable.STORE_ALL_CHATS_TABLE_NAME);
    await storageService.deleteItem(key: DbTable.BOOKMARK_TABLE_NAME);
    await storageService.deleteItem(key: DbTable.SERVICE_DETAIL_TABLE_NAME);
    await locator<NotificationService>().channel?.sink.close();
    await locator<ChatServices>().channel?.sink.close();
    locator<ChatServices>().channel = null;
    locator<NotificationService>().channel = null;
    locator<NotificationService>().channel = null;
    isUserLoggedIn = false;
    user = User();
    navigationService.navigateToAndRemoveUntil(loginScreenRoute);
    showCustomToast("Session Has Ended, Log In to proceed");
  }

  Future<User?> getStoreUser() async {
    String? data = await storageService.readItem(key: DbTable.USER_TABLE_NAME);
    if (data == null) {
      var response = await repository.getUser();
      if (response == null) {
        user = User();
        await logout();
        return null;
      } else {
        user = response;
        return user;
      }
    } else {
      User userResponse = User.fromJson(jsonDecode(data));
      user = userResponse;
      return userResponse;
    }
  }
}

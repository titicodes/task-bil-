import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskitly/core/models/bvn_verification_response_model.dart';
import 'package:taskitly/core/models/fund_wallet_response.dart';
import 'package:taskitly/core/models/kyc_response.dart';
import 'package:taskitly/core/models/new_login_response.dart';
import 'package:taskitly/core/models/order_stats_response.dart';
import 'package:taskitly/core/models/service_provider_response_model.dart';
import 'package:taskitly/core/models/user-response.dart';
import 'package:taskitly/core/services/web-services/bills-service.dart';
import 'package:taskitly/core/services/web-services/chat-service.dart';
import 'package:taskitly/core/services/web-services/wallet_api_service.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../UI/base/base.vm.dart';
import '../../constants/reuseables.dart';
import '../../locator.dart';
import '../models/account-verify-response.dart';
import '../models/airtime_response_model.dart';
import '../models/all_message_list.dart';
import '../models/bank-list-response.dart';
import '../models/betting-response-model.dart';
import '../models/block-list-response.dart';
import '../models/bvn-response.dart';
import '../models/change-password-response.dart';
import '../models/chat/delete-message-response.dart';
import '../models/chat/get-chat-detail-user-info.dart';
import '../models/chat/get-messages.dart';
import '../models/chat/join_a_room_model.dart';
import '../models/chat/send-message-response.dart';
import '../models/create-service-response.dart';
import '../models/customer-enquiry-response.dart';
import '../models/default-response.dart';
import '../models/education_billers_response.dart';
import '../models/electricity_biller_type_res.dart';
import '../models/electricity_billers_response.dart';
import '../models/get-category-response.dart';
import '../models/get-order-response-model.dart';
import '../models/get-otp-response.dart';
import '../models/internet_response_model.dart';
import '../models/login-response.dart';
import '../models/mtn_data_response_model.dart';
import '../models/name-look-up-response.dart';
import '../models/notification-response.dart';
import '../models/prodiders-service-response.dart';
import '../models/registration-response.dart';
import '../models/send-invoice-response.dart';
import '../models/skills-response.dart';
import '../models/submit-review-model.dart';
import '../models/transaction-history-model.dart';
import '../models/tv_bill_Response.dart';
import '../models/tv_billers_response.dart';
import '../models/user_data.dart';
import '../models/verification-status.dart';
import '../services/local-service/app-cache.dart';
import '../services/local-service/storage-service.dart';
import '../services/local-service/user.service.dart';
import '../services/web-services/auth.api.dart';
import '../services/web-services/product-service.dart';
import '../services/web-services/services-service.dart';

class Repository {
  AuthenticationApiService auth = locator<AuthenticationApiService>();
  UserService userService = locator<UserService>();
  ProductService product = locator<ProductService>();
  BillsService billsService = locator<BillsService>();
  final ChatServices _chatServices = locator<ChatServices>();
  AppCache appCache = locator<AppCache>();
  ServicesService servicesService = locator<ServicesService>();
  StorageService storageService = locator<StorageService>();
  WalletAPIService walletS = locator<WalletAPIService>();
  final box = GetStorage();

  Future<RegisterResponse?> register({required UserData data}) async {
    var res = await auth.register(data: data);
    if (res?.token != null) {
      cache.userData = data;
      await userService.storeToken(NewLoginResponse(
          token: res?.token,
          uid: res?.uid,
          verifyStatus: false,
          servicepro: data.userType == "client" ? false : true));
    }
    return res;
  }

  Future<DefaultResponse?> verifyEmail({required UserData data}) async {
    return await auth.verifyEmail(data: data);
  }

  // Future<NewLoginResponse?> login({required UserData data}) async {
  //   var response = await auth.login(data: data);
  //   if (response?.verifyStatus == true) {
  //     await userService.storeToken(response);
  //   }
  //   return response;
  // }
  Future<NewLoginResponse?> login({required UserData data}) async {
    var response = await auth.login(data: data);
    if (response?.verifyStatus == true) {
      await userService.storeToken(response);
    }
    return response;
  }

  Future<User?> getUser() async {
    String? userToken = box.read(DbTable.TOKEN_TABLE_NAME);
    var response = await auth.getUser();
    if (response?.uid != null || userToken != null) {
      userToken = appCache.registerResponse.token;
      userService.storeUser(response);
    }
    return response;
  }

  Future<User?> getPrivateUser() async {
    var response = await auth.getPrivateUser();
    if (response?.uid != null) {
      userService.storePrivateUser(response);
    }
    return response;
  }

  Future<GetCategoryResponse?> getCategories({int? page}) async {
    var response = await product.getCategories(page: page);

    if (response?.results != null) {
      await storeCategory(response);
    }
    return response;
  }

  Future<String?> deleteAccount() async {
    return await auth.deleteAccount();
  }

  Future<GCMResponse?> sendToken(
      {required String data, required String type}) async {
    return await auth.sendToken(data: data, type: type);
  }

  Future<SendInvoiceResponse?> sendInvoice(
      {required String customerID,
      required List<String> skills,
      required String amount,
      required String startDate,
      required String endDate,
      String? additionalText}) async {
    return await servicesService.sendInvoice(
        customerID: customerID,
        skills: skills,
        amount: amount,
        startDate: startDate,
        endDate: endDate,
        additionalText: additionalText);
  }

  //::// GET ORDER SERVICE //:://
  Future<GetOrderResponse?> getOrderService({String? page}) async {
    var response = await servicesService.getOrderService(page: page);
    return response;
  }

  Future<NameLookUpResponse?> nameCheck({required String phoneNumber}) async {
    var response = await billsService.nameCheck(phoneNumber: phoneNumber);
    return response;
  }

  Future<User?> updateProfile({required UserData data}) async {
    var response = await auth.updateProfile(data: data);
    if (response?.uid != null) {
      userService.storeUser(response);
    }
    return response;
  }

  Future<GetSkillsResponse?> getCategoriesSkills(String categoryID,
      {int? page}) async {
    var response = await product.getCategoriesSkills(categoryID, page: page);
    if (response?.results != null) {
      await storeCategorySkills(response, categoryID);
    }
    return response;
  }

  Future<GetOtpResponse?> verifyPhone({required UserData data}) async {
    return await auth.verifyPhone(data: data);
  }

  Future<dynamic> sendLocation({
    required String latitude,
    required String longitude,
  }) async {
    return await servicesService.sendLocation(
        latitude: latitude, longitude: longitude);
  }

  Future<DefaultResponse?> unblockUser({required String userID}) async {
    return await auth.unblockUser(userID: userID);
  }

  Future<List<ProviderUserResponse>?> getProvidersFromCategory(
      String categoryID) async {
    var response = await product.getProvidersFromCategory(categoryID);
    if (response != null) {
      await storeProvidersFromCategory(response, categoryID);
    }
    return response;
  }

  storeProvidersFromCategory(
      List<ProviderUserResponse> list, String categoryID) async {
    print("Store Categories Skills");
    await storageService.storeItem(
        key: DbTable.SERVICE_TABLE_NAME + categoryID, value: jsonEncode(list));
  }

  Future<List<ProviderUserResponse>?> getLocalProvidersFromCategory(
      String categoryID) async {
    String? data = await storageService.readItem(
        key: DbTable.SERVICE_TABLE_NAME + categoryID);
    print("STORED DATA::: $data");
    if (data == null) {
      return null;
    } else {
      List<ProviderUserResponse> providers = geProviderUserListFromJson(data);
      print("Stored Category length::::: ${providers.length}");
      return providers;
    }
  }

  storeBookMark(ProviderUserResponse provider) async {
    print("Store Providers");
    List<ProviderUserResponse> providers = await getBookMarks() ?? [];
    if (providers.any((element) => element.uid == provider.uid)) {
      showCustomToast("This service provider has been already been bookmarked");
    } else {
      providers.add(provider);
      await storageService.storeItem(
          key: DbTable.BOOKMARK_TABLE_NAME, value: jsonEncode(providers));
      showCustomToast("Bookmark Successful", success: true);
    }
  }

  storeNotification(NotificationResponses provider) async {
    print("Store Notification");
    await storageService.storeItem(
        key: DbTable.NOTIFICATION_TABLE_NAME, value: jsonEncode(provider));
  }

  Future<NotificationResponses?> getLocalNotification() async {
    String? data =
        await storageService.readItem(key: DbTable.NOTIFICATION_TABLE_NAME);
    if (data == null) {
      return null;
    } else {
      NotificationResponses categoryResponse =
          NotificationResponses.fromJson(jsonDecode(data));
      return categoryResponse;
    }
  }

  Future<void> removeBookMark(ProviderUserResponse provider) async {
    print("Remove Providers");

    // Retrieve the list of bookmarks
    List<ProviderUserResponse> providers = await getBookMarks() ?? [];

    // Check if the provider is in the list of bookmarks
    if (providers.any((element) => element.uid == provider.uid)) {
      // Remove the provider from the list
      providers.removeWhere((element) => element.uid == provider.uid);

      // Store the updated list of bookmarks
      await storageService.storeItem(
          key: DbTable.BOOKMARK_TABLE_NAME, value: jsonEncode(providers));

      // Show a success message
      showCustomToast("Bookmark Removed Successfully", success: true);
    } else {
      // Show a message indicating the provider is not bookmarked
      showCustomToast("This service provider is not bookmarked");
    }

    print(providers.length); // Print the length of the updated list
  }

  Future<List<ProviderUserResponse>?> getBookMarks() async {
    String? data =
        await storageService.readItem(key: DbTable.BOOKMARK_TABLE_NAME);
    if (data == null) {
      return null;
    } else {
      List<ProviderUserResponse> providers = geProviderUserListFromJson(data);
      print("Stored Bookmarked services::::: $data");
      return providers;
    }
  }

  Future<CreateServiceResponse?> registerProvider(
      {required RegisterProviderData data}) async {
    return await auth.registerProvider(data: data);
  }

  // SERVICE PROVIDER DETAILS
  Future<String?> updateServiceProviderDetails(
      {required ProviderUserResponse data, required String serviceID}) async {
    var responseData = await auth.updateServiceProviderDetails(
        data: data, serviceID: serviceID);
    return responseData;
  }

  storeServiceProviderDetails(ServiceProviderResponseModel? response) async {
    print("Store Service Provider Details");
    await storageService.storeItem(
      key: DbTable.PROVIDER_DETAILS_TABLE,
      value: jsonEncode(response),
    );
  }

  Future<String?> updateOnlineOffline(
      {required ProviderUserResponse data, required String serviceID}) async {
    return await auth.updateOnlineOffline(data: data, serviceID: serviceID);
  }

  // Future<ProviderUserResponse?> getUserServiceDetail() async {
  //   var response = await auth.getUserServiceID();
  //   if (response?.uid != null) {
  //     await storeUserServiceDetail(response);
  //   }
  //   return response;
  // }
  Future<ProviderUserResponse?> getUserServiceDetail() async {
    String? userToken = box.read(DbTable.TOKEN_TABLE_NAME);

    if (userToken == null) {
      // User credentials not provided
      return null;
    }

    var response = await auth.getUserServiceID();

    if (response?.uid != null) {
      userToken = appCache.registerResponse.token;
      await storeUserServiceDetail(response);
    }

    return response;
  }

  storeUserServiceDetail(ProviderUserResponse? response) async {
    print("Store Service Detail");
    await storageService.storeItem(
        key: DbTable.SERVICE_DETAIL_TABLE_NAME, value: jsonEncode(response));
  }

  Future<ProviderUserResponse?> getLocalServiceDetail() async {
    String? data =
        await storageService.readItem(key: DbTable.SERVICE_DETAIL_TABLE_NAME);
    print("STORED SERVICE DETAIL DATA::: $data");
    if (data == null) {
      return null;
    } else {
      ProviderUserResponse categoryResponse =
          ProviderUserResponse.fromJson(jsonDecode(data));
      return categoryResponse;
    }
  }

  Future<String?> emailVerify() async {
    return await auth.emailVerify();
  }

  Future<DefaultResponse?> resetPassword({required UserData data}) async {
    return await auth.resetPassword(data: data);
  }

  Future<ChangePasswordResponse?> changePassword(
      {required UserData data}) async {
    return await auth.changePassword(data: data);
  }

  Future<String?> uploadImage(File image) async {
    return await _chatServices.uploadImage(image);
  }

  Future<GetOtpResponse?> forgetPassword({required UserData data}) async {
    return await auth.forgetPassword(data: data);
  }

  Future<GetOtpResponse?> verifyForgot(
      {required UserData data, required String pinID}) async {
    return await auth.verifyForgot(data: data, pinID: pinID);
  }

  Future<VerificationStatus?> userStatus() async {
    var res = await auth.userStatus();
    if (res != null) {
      await storeUserStatus(res);
    }
    return res;
  }

  storeUserStatus(VerificationStatus? response) async {
    print("Store User Status");
    await storageService.storeItem(
        key: DbTable.USER_STATUS_TABLE_NAME, value: jsonEncode(response));
  }

  Future<VerificationStatus?> getLocalUserStatus() async {
    String? data =
        await storageService.readItem(key: DbTable.USER_STATUS_TABLE_NAME);
    print("STORED DATA::: $data");
    if (data == null) {
      return null;
    } else {
      VerificationStatus categoryResponse =
          VerificationStatus.fromJson(jsonDecode(data));
      return categoryResponse;
    }
  }

  Future<BVNResponse?> verifyBVNAndKYC(
      {required String idNumber,
      String? dateOfBirth,
      required bool isBvn}) async {
    return await walletS.verifyBVNAndKYC(
        idNumber: idNumber, isBvn: isBvn, dateOfBirth: dateOfBirth);
  }

  Future<DefaultResponse?> verifyPhoneOtp(
      {required String otp, required String pinID, String? phoneNumber}) async {
    return await auth.verifyPhoneOtp(
        otp: otp, pinID: pinID, phoneNumber: phoneNumber);
  }

  storeCategory(GetCategoryResponse? response) async {
    print("Store Categories");
    await storageService.storeItem(
        key: DbTable.CATEGORIES_TABLE_NAME, value: jsonEncode(response));
  }

  storeCategorySkills(GetSkillsResponse? response, String skillID) async {
    print("Store Categories Skills");
    await storageService.storeItem(
        key: DbTable.CATEGORIES_TABLE_NAME + skillID,
        value: jsonEncode(response));
  }

  Future<GetCategoryResponse?> getLocalCategories() async {
    String? data =
        await storageService.readItem(key: DbTable.CATEGORIES_TABLE_NAME);
    print("STORED DATA::: $data");
    if (data == null) {
      return null;
    } else {
      GetCategoryResponse categoryResponse =
          GetCategoryResponse.fromJson(jsonDecode(data));
      print("Stored Category length::::: ${categoryResponse.results?.length}");
      return categoryResponse;
    }
  }

  Future<GetSkillsResponse?> getLocalSkills(String skillID) async {
    String? data = await storageService.readItem(
        key: DbTable.CATEGORIES_TABLE_NAME + skillID);
    print("STORED SKILL DATA::: $data");
    if (data == null) {
      return null;
    } else {
      GetSkillsResponse categoryResponse =
          GetSkillsResponse.fromJson(jsonDecode(data));
      print("Stored Category length::::: ${categoryResponse.results?.length}");
      return categoryResponse;
    }
  }

  //BILLS PAYMENT REPOSITORY CODE
  Future<AirtimeResponseModel?> getAirtime() async {
    var response = await billsService.getAirtimeBillers();
    if (response?.data != null) {
      await storeAirtimeProvider(response);
    }
    return response;
  }

  storeAirtimeProvider(AirtimeResponseModel? response) async {
    print("Store Airtime");
    await storageService.storeItem(
        key: DbTable.AIRTIME_TABLE_NAME, value: jsonEncode(response));
  }

  Future<AirtimeResponseModel?> getLocalAirtimeProvider() async {
    String? data =
        await storageService.readItem(key: DbTable.AIRTIME_TABLE_NAME);
    print("STORED AIRTIME DATA::: $data");
    if (data == null) {
      return null;
    } else {
      AirtimeResponseModel categoryResponse =
          AirtimeResponseModel.fromJson(jsonDecode(data));
      return categoryResponse;
    }
  }

  //DATA
  Future<ConvertedDataResponse?> getData({required String dataBillers}) async {
    var response = await billsService.getDataBillers(dataBillers: dataBillers);
    if (response?.data != null) {
      await storeDataProvider(response, dataBillers);
    }
    return response;
  }

  storeDataProvider(ConvertedDataResponse? response, String dataBiller) async {
    print("Store Data");
    await storageService.storeItem(
        key: DbTable.DATA_TABLE_NAME + dataBiller, value: jsonEncode(response));
  }

  Future<ConvertedDataResponse?> getLocalDataProvider(String dataBiller) async {
    String? data = await storageService.readItem(
        key: DbTable.DATA_TABLE_NAME + dataBiller);
    print("STORED DATA::: $data");
    if (data == null) {
      return null;
    } else {
      ConvertedDataResponse categoryResponse =
          ConvertedDataResponse.fromJson(jsonDecode(data));
      return categoryResponse;
    }
  }

  //ELECTRICITY
  Future<PowerDistributionResponse?> getElectricity() async {
    var response = await billsService.getElectricityBillers();
    if (response?.data != null) {
      await storeElectricityProvider(response);
    }
    return response;
  }

  /// CHATROOM
  Future<GetChatDetailResponse?> getChatRoomData(String userID) async {
    var response = await _chatServices.getChatRoomData(userID);
    if (response?.chatroomId != null) {
      await storeChatRoomData(response, userID);
    }
    return response;
  }

  Future<SendMessageResponse?> sendMessage(
      String chatRoomID, String messages) async {
    var response = await _chatServices.sendMessage(chatRoomID, messages);
    return response;
  }

  Future<List<MessageData>?> getLatestChatsData() async {
    var response = await _chatServices.getLatestChatsData();
    if (response?.data != null) {
      await storeLatestChats(response);
      List<MessageData> data = response?.data ?? [];
      return data;
    } else {
      return response?.data;
    }
  }

  storeLatestChats(GetLastMessagesResponse? response) async {
    await storageService.storeItem(
        key: DbTable.STORE_ALL_CHATS_TABLE_NAME, value: jsonEncode(response));
  }

  storeChatUser(GetChatUserDetailResponse? response, String roomID) async {
    print("Store chat user");
    await storageService.storeItem(
        key: DbTable.STORE_CHAT_USER_TABLE_NAME + roomID,
        value: jsonEncode(response));
  }

  Future<GetChatUserDetailResponse?> getLocalChatUser(String roomID) async {
    String? data = await storageService.readItem(
        key: DbTable.STORE_CHAT_USER_TABLE_NAME + roomID);
    print("STORED CHAT USER::: $data");
    if (data == null) {
      return null;
    } else {
      GetChatUserDetailResponse chatRoomData =
          GetChatUserDetailResponse.fromJson(jsonDecode(data));
      return chatRoomData;
    }
  }

  Future<GetChatMessagesResponse?> getLocalChatMessages(String roomID) async {
    String? data = await storageService.readItem(
        key: DbTable.STORE_CHAT_MESSAGES_TABLE_NAME + roomID);
    print("STORED CHAT MESSAGES::: $data");
    if (data == null) {
      return null;
    } else {
      GetChatMessagesResponse chatRoomData =
          GetChatMessagesResponse.fromJson(jsonDecode(data));
      return chatRoomData;
    }
  }

  storeLatestMessages(GetChatMessagesResponse? response, String roomID) async {
    await storageService.storeItem(
        key: DbTable.STORE_CHAT_MESSAGES_TABLE_NAME + roomID,
        value: jsonEncode(response));
  }

  Future<List<MessageData>?> getLocalLatestChatsData() async {
    String? data =
        await storageService.readItem(key: DbTable.STORE_ALL_CHATS_TABLE_NAME);
    print("STORED CHAT::: $data");
    if (data == null) {
      return null;
    } else {
      GetLastMessagesResponse chatRoomData =
          GetLastMessagesResponse.fromJson(jsonDecode(data));
      return chatRoomData.data ?? [];
    }
  }

  storeElectricityProvider(PowerDistributionResponse? response) async {
    print("Store Electricity");
    await storageService.storeItem(
        key: DbTable.ELECTRICITY_TABLE_NAME, value: jsonEncode(response));
  }

  storeChatRoomData(GetChatDetailResponse? response, String userID) async {
    print("Store Chat room data");
    await storageService.storeItem(
        key: DbTable.CHATROOM_DETAIL_TABLE_NAME + userID,
        value: jsonEncode(response));
  }

  Future<GetChatDetailResponse?> getLocalChatRoomData(String userID) async {
    String? data = await storageService.readItem(
        key: DbTable.CHATROOM_DETAIL_TABLE_NAME + userID);
    print("STORED CHATROOM DATA::: $data");
    if (data == null) {
      return null;
    } else {
      GetChatDetailResponse chatRoomData =
          GetChatDetailResponse.fromJson(jsonDecode(data));
      return chatRoomData;
    }
  }

  Future<PowerDistributionResponse?> getLocalElectricityProvider() async {
    String? data =
        await storageService.readItem(key: DbTable.ELECTRICITY_TABLE_NAME);
    print("STORED ELECTRICITY DATA::: $data");
    if (data == null) {
      return null;
    } else {
      PowerDistributionResponse categoryResponse =
          PowerDistributionResponse.fromJson(jsonDecode(data));
      return categoryResponse;
    }
  }

  Future<BillerTypeResponse?> getElectricityType(providerId) async {
    var response = await billsService.getElectricityBillersType(providerId);
    if (response?.data != null) {
      await storeElectricityTypeProvider(response);
    }
    return response;
  }

  storeElectricityTypeProvider(BillerTypeResponse? response) async {
    print("Store  Type");
    await storageService.storeItem(
        key: DbTable.ELECTRICITY_TYPE_TABLE_NAME, value: jsonEncode(response));
  }

  Future<BillerTypeResponse?> getLocalElectricityTypeProvider() async {
    String? data =
        await storageService.readItem(key: DbTable.ELECTRICITY_TYPE_TABLE_NAME);
    print("STORED  TYPE DATA::: $data");
    if (data == null) {
      return null;
    } else {
      BillerTypeResponse categoryResponse =
          BillerTypeResponse.fromJson(jsonDecode(data));
      return categoryResponse;
    }
  }

  //BETTING
  Future<BettingResponseModel?> getBetting() async {
    var response = await billsService.getBetingBillers();
    if (response?.data != null) {
      await storeBettingProvider(response);
    }
    return response;
  }

  storeBettingProvider(BettingResponseModel? response) async {
    print("Store Betting");
    await storageService.storeItem(
        key: DbTable.BETTING_TYPE_TABLE_NAME, value: jsonEncode(response));
  }

  Future<BettingResponseModel?> getLocalBettingProvider() async {
    String? data =
        await storageService.readItem(key: DbTable.BETTING_TYPE_TABLE_NAME);
    print("STORED BETTING DATA::: $data");
    if (data == null) {
      return null;
    } else {
      BettingResponseModel categoryResponse =
          BettingResponseModel.fromJson(jsonDecode(data));
      return categoryResponse;
    }
  }

  //TELEVISION
  Future<TvBillerResponse?> getTelevision() async {
    var response = await billsService.getTvBillers();
    if (response?.data != null) {
      await storeTelevisionProvider(response);
    }
    return response;
  }

  storeTelevisionProvider(TvBillerResponse? response) async {
    print("Store Tv");
    await storageService.storeItem(
        key: DbTable.TV_DATA, value: jsonEncode(response));
  }

  Future<TvBillerResponse?> getLocalTelevisionProvider() async {
    String? data = await storageService.readItem(key: DbTable.TV_DATA);
    print("STORED Tv DATA::: $data");
    if (data == null) {
      return null;
    } else {
      TvBillerResponse categoryResponse =
          TvBillerResponse.fromJson(jsonDecode(data));
      return categoryResponse;
    }
  }

  //INTERNET

  Future<InternetResponseModel?> getInternet() async {
    var response = await billsService.getInternetBillers();
    if (response?.data != null) {
      await storeInternetProvider(response);
    }
    return response;
  }

  storeInternetProvider(InternetResponseModel? response) async {
    print("Store Internet");
    await storageService.storeItem(
        key: DbTable.INTERNET_TYPE_TABLE_NAME, value: jsonEncode(response));
  }

  Future<InternetResponseModel?> getLocalInternetProvider() async {
    String? data =
        await storageService.readItem(key: DbTable.INTERNET_TYPE_TABLE_NAME);
    print("STORED Internet DATA::: $data");
    if (data == null) {
      return null;
    } else {
      InternetResponseModel categoryResponse =
          InternetResponseModel.fromJson(jsonDecode(data));
      return categoryResponse;
    }
  }

  // Education

  Future<EducationBillersResponse?> getEducation() async {
    var response = await billsService.getEducationBillers();
    if (response != null) {
      await storeEducationProvider(response);
    }
    return response;
  }

  storeEducationProvider(EducationBillersResponse? response) async {
    print("Store Airtime");
    await storageService.storeItem(
        key: DbTable.EDUCATION_TABLE_NAME, value: jsonEncode(response));
  }

  Future<EducationBillersResponse?> getLocalEducationProvider() async {
    String? data =
        await storageService.readItem(key: DbTable.EDUCATION_TABLE_NAME);
    print("STORED DATA::: $data");
    if (data == null) {
      return null;
    } else {
      EducationBillersResponse categoryResponse =
          EducationBillersResponse.fromJson(jsonDecode(data));
      return categoryResponse;
    }
  }

  //::// GET ALL BANK LISTs //:://
  Future<BankListResponse?> getBankList({String? page}) async {
    var response = await walletS.getBankList(page: page);
    if (response != null) {
      await storeBankList(response);
    }
    return response;
  }

  bool isBankResultAlreadyStored(
      BankResult bankResult, List<BankResult> storedList) {
    for (BankResult storedBank in storedList) {
      if (storedBank.code == bankResult.code &&
          storedBank.name == bankResult.name) {
        return true; // BankResult already exists in storedList
      }
    }
    return false; // BankResult does not exist in storedList
  }

  storeBankList(BankListResponse? response) async {
    List<BankResult> storedList = await getLocalBankList() ?? [];
    List<BankResult> banks = response?.results ?? [];
    print("Store Banks");
    if (banks.isNotEmpty) {
      for (var bank in banks) {
        if (!isBankResultAlreadyStored(bank, storedList)) {
          storedList.add(bank);
        }
      }

      StoreBankListResponse newResponse =
          StoreBankListResponse(results: storedList);
      await storageService.storeItem(
          key: DbTable.BANK_LIST_TABLE_NAME, value: jsonEncode(newResponse));
    }
  }

  Future<List<BankResult>?> getLocalBankList() async {
    String? data =
        await storageService.readItem(key: DbTable.BANK_LIST_TABLE_NAME);
    print("STORED DATA::: $data");
    if (data == null) {
      return null;
    } else {
      StoreBankListResponse bankListResponse =
          StoreBankListResponse.fromJson(jsonDecode(data));
      return bankListResponse.results;
    }
  }

  //BILLS PAYMENT CUSTOMER ENQUIRY
  Future<CustomerEnquiryResponse?> customerEnquiry({
    required String meterNumber,
    required String electricitySlug,
    required String elecetricityTypeSlug,
  }) async {
    return await billsService.checkCustomerEnquiry(
      meterNumber: meterNumber,
      electricitySlug: electricitySlug,
      elecetricityTypeSlug: elecetricityTypeSlug,
    );
  }

  //BILLS PAYMENT PIN Repo CODE
  Future<DefaultResponse?> verifyTransactionPin({
    required String productName,
    required String phoneNumber,
    required String amount,
    required String pin,
  }) async {
    return await billsService.payForAirtime(
      productName: productName,
      phoneNumber: phoneNumber,
      amount: amount,
      pin: pin,
    );
  }

  //BILLS PAYMENT PIN Repo CODE
  Future<DefaultResponse?> verifyGiftingTransactionPin({
    required String phoneNumber,
    required String amount,
    required String pin,
  }) async {
    return await billsService.payForGifting(
      phoneNumber: phoneNumber,
      amount: amount,
      pin: pin,
    );
  }

  // KYC & WALLET
  Future<Response?> verifyVotersCardkYC(
      {required String idNumber, required File? image}) async {
    return await walletS.verifyVotersCardkYC(idNumber: idNumber, image: image);
  }

  Future<Response?> verifyDriversLicensekYC(String idNumber) async {
    return await walletS.verifyDriversLicensekYC(idNumber: idNumber);
  }

  Future<Response?> verifyNINkYC(String idNumber) async {
    return await walletS.verifyNINkYC(idNumber: idNumber);
  }

  Future<Response?> verifyPassportkYC(
      {required String idNumber, required File? image}) async {
    return await walletS.verifyPassportkYC(idNumber: idNumber, image: image);
  }

  Future<Response?> initWalletCreation(String amount) async {
    return await walletS.initWalletCreation(amount: amount);
  }

  Future<dynamic> sendOrdersValidator({
    required String orderId,
    required bool valid,
  }) async {
    return await servicesService.sendOrdersValidator(
        orderId: orderId, valid: valid);
  }

  Future<dynamic> sendOrdersAction({
    required String orderId,
    required String action,
  }) async {
    return await servicesService.sendOrdersAction(
        orderId: orderId, action: action);
  }

  Future<dynamic> report({
    required String orderId,
    required String description,
  }) async {
    return await servicesService.report(
        orderId: orderId, description: description);
  }

  Future<SubmitReviewResponse?> reviewOrder({
    required String orderId,
    required String comment,
    required String rating,
  }) async {
    return await servicesService.reviewOrder(
        orderId: orderId, comment: comment, rating: rating);
  }

  Future<String?> sendNotification(
      {String? token, required String message, required String title}) async {
    return await auth.sendNotification(
        token: token, message: message, title: title);
  }

  // Future<CreateServiceResponse?> registerProvider(
  //     {required RegisterProviderData data}) async {
  //   return await auth.registerProvider(data: data);
  // }

  Future<DefaultResponse?> reportUser(
      {required String id,
      required String description,
      required String type}) async {
    var response =
        await auth.reportUser(id: id, description: description, type: type);
    if (response?.message != null && type == "block") {
      await locator<BaseViewModel>().getBlockedUsers();
    }
    return response;
  }

  Future<DefaultResponse?> reportChatUser(
      {required String id,
      required String description,
      required String type}) async {
    var response =
        await auth.reportChatUser(id: id, description: description, type: type);
    return response;
  }

  Future<DeleteMessageResponse?> deleteMessage({required String id}) async {
    var response = await auth.deleteMessage(id: id);
    return response;
  }

  Future<List<BlockListResponse>?> getBlockedUser() async {
    var response = await auth.getBlockedUser();
    if (response != null) {
      String convertedData = getBlockedUserListToJson(response);
      await storeBlockedUser(convertedData);
    }
    return response;
  }

  storeBlockedUser(String response) async {
    print("Store Blocked User:::$response");
    await storageService.storeItem(
        key: DbTable.BLOCKED_USER_LIST_TABLE_NAME, value: response);
  }

  Future<List<BlockListResponse>?> getLocalBlockedUser() async {
    String? data = await storageService.readItem(
        key: DbTable.BLOCKED_USER_LIST_TABLE_NAME);
    print("Stored Blocked User::: $data");
    if (data == null) {
      return null;
    } else {
      List<BlockListResponse> responseData = getBlockedUserListFromJson(data);
      return responseData;
    }
  }

  //::// Verify the bank account details //:://
  Future<AccountVerifyResponse?> verifyBankAccount({
    required String code,
    required String accountNumber,
  }) async {
    return await walletS.accountLookup(
        accountNumber: accountNumber, bankCode: code);
  }

  //::// confirm bank transaction //:://
  Future<DefaultResponse?> confirmTransaction({
    required int amount,
    required String naration,
    required String destBankCode,
    required String destAccountNumber,
    required String destAccountName,
    required String pin,
  }) async {
    return await walletS.confirmAccount(
        amount: amount,
        destAccountName: destAccountName,
        destAccountNumber: destAccountNumber,
        destBankCode: destBankCode,
        naration: naration,
        pin: pin);
  }

  Future<DefaultResponse?> changeTransactionPin(
      {required String otp, required String newPin}) {
    return auth.changeTransactionPin(otp: otp, newPin: newPin);
  }

  Future<TransactionHistoryModel?> getTransactionHistory() async {
    var response = await walletS.getTransactionHistory();
    if (response != null) {
      await storeTransactionHistory(response);
    }
    return response;
  }

  storeTransactionHistory(
      TransactionHistoryModel transactionHistoryModel) async {
    print("//:Store History://");
    await storageService.storeItem(
        key: DbTable.TRANSACTION_HISTORY_TABLE_NAME,
        value: jsonEncode(transactionHistoryModel));
  }

  Future<TransactionHistoryModel?> getLocalTransactionHistory() async {
    String? data = await storageService.readItem(
        key: DbTable.TRANSACTION_HISTORY_TABLE_NAME);
    print("STORED DATA::: $data");
    if (data == null) {
      return null;
    } else {
      TransactionHistoryModel historyResponse =
          TransactionHistoryModel.fromJson(jsonDecode(data));
      return historyResponse;
    }
  }

  // get Popular Service Providers
  Future<List<ProviderUserResponse>?> getPopularProviders(
      {String? categoryId}) async {
    try {
      var response = await product.getPopularProviders(categoryId: categoryId);
      if (response != null) {
        await storePopularProviders(response);
      }
      return response;
    } catch (error) {
      print("Error fetching popular providers: $error");
      return null; // Return null to indicate an error occurred
    }
  }

  storePopularProviders(List<ProviderUserResponse> list) async {
    print("Store Popular Providers");
    try {
      await storageService.storeItem(
        key: DbTable.POPULAR_SERVICE_PROVIDER,
        value: jsonEncode(list),
      );
    } catch (error) {
      print("Error storing popular providers: $error");
    }
  }

  // Retrieve popular providers from local storage
  Future<List<ProviderUserResponse>?> getLocalPopularServices() async {
    try {
      String? data =
          await storageService.readItem(key: DbTable.POPULAR_SERVICE_PROVIDER);
      if (data != null) {
        List<ProviderUserResponse> popularServiceResponse =
            geProviderUserListFromJson(data);
        return popularServiceResponse;
      }
    } catch (error) {
      print("Error retrieving popular providers: $error");
    }
    return null;
  }

  Future<BvnVerificationResponseModel?> kycBvn({
    required String idNumber,
    required String dob,
    required String type,
  }) async {
    return await walletS.kycVerification(
      idNumber: idNumber,
      dateOfBirth: dob,
      type: type,
    );
  }

  Future<FundWalletResponse?> fundWallet({required String amount}) async {
    try {
      var response = await walletS.fundWallet(amount: amount);
      if (response != null) {
        await storeFundWallet(response);
        return response;
      }
    } catch (e) {
      print("Error fetching fund wallet response: $e");
      return null;
    }
    return null;
  }

  Future<String> topUpWallet({required String amount}) async {
    try {
      var response = await walletS.topUpWallet(amount: amount);
      // if (response != null) {

      return response;
      // }
    } catch (e) {
      print("Error fetching fund wallet response: $e");
      throw Exception('Failed');
    }
  }

  storeFundWallet(FundWalletResponse? response) async {
    print("Stored Funding details");
    await storageService.storeItem(
        key: DbTable.FUND_WALLET_INFO, value: jsonEncode(response));
  }

  Future<FundWalletResponse?> getLocalFundWalletInfo() async {
    String? data = await storageService.readItem(key: DbTable.FUND_WALLET_INFO);
    print("STORED Funding DATA::: $data");
    if (data == null) {
      return null;
    } else {
      FundWalletResponse fundWalletResponse =
          FundWalletResponse.fromJson(jsonDecode(data));
      return fundWalletResponse;
    }
  }

  Future<BvnVerificationResponseModel?> ninKycVerification({
    required String idNumber,
    required String dob,
    required String type,
  }) async {
    return await walletS.kycVerification(
      idNumber: idNumber,
      dateOfBirth: dob,
      type: type,
    );
  }

  // Future<OrderStats?> fetchOrderStats({required String serviceId}) async {
  //   return await servicesService.getOrderStats(serviceId:serviceId);
  // }

  Future<dynamic> fetchOrderStats(
   {required String serviceId}
    
  ) async {
    return await servicesService.fetchOrderStats(
        serviceId:serviceId);
  }
  
}

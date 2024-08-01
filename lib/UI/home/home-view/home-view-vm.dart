import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskitly/UI/home/home-view/wallet-transaction/top_up_amount_modal.dart';
//import 'package:taskitly/UI/home/home-view/wallet-transaction/top-up-screen.dart';
import 'package:taskitly/UI/home/home-view/wallet-transaction/withdraw-screen.dart';
import 'package:taskitly/core/models/user-response.dart';
import 'package:taskitly/routes/routes.dart';
import 'package:taskitly/utils/show-bottom-sheet.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../constants/reuseables.dart';
import '../../../core/models/account-verify-response.dart';
import '../../../core/models/all_message_list.dart';
import '../../../core/models/all_selected_categories_list.dart';
import '../../../core/models/chat/join_a_room_model.dart';
import '../../../core/models/get-category-response.dart';
import '../../../core/models/get-order-response-model.dart';
import '../../../core/models/prodiders-service-response.dart';
import '../../../core/models/verification-status.dart';
import '../../base/base.vm.dart';
import '../../widgets/bottomSheet.dart';
import '../chat-view/chat-home-view.ui.dart';
import '../notification/notification-ui.dart';
import '../settings-view/verification/verification-home.ui.dart';
import 'wallet-transaction/pin-screen-ui.dart';

class HomeViewViewModel extends BaseViewModel {
  GetCategoryResponse? categoryResponse;
  AccountVerifyResponse? accountVerifyResponse;
  late BuildContext context;
  List<Category> categories = [];

  bool switchValue = false;

  ProviderUserResponse? serviceDetailsData;

  updateOnlineStatus() async {
    startLoader();
    var payload =
        ProviderUserResponse(provider: Provider(isOnline: switchValue));
    try {
      var response = await repository.updateOnlineOffline(
          data: payload, serviceID: serviceDetailsData?.uid ?? "");
      if (response != null) {
        await getServiceProviderDetails();
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  Stream<User?> getUserData() async* {
    while (true) {
      var response = await repository.getPrivateUser();
      yield response;
    }
  }

  List<MessageData> userMessages = [];

  getLocalLatestChatsData() async {
    try {
      var response = await repository.getLocalLatestChatsData();
      if (response != null) {
        userMessages = response
            .where((element) => element.lastMessage?.content != "")
            .toList();
        print(jsonEncode(response));
      }
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  getChatsData() async {
    await getLocalLatestChatsData();
    if (userMessages.isEmpty) {
      try {
        var response = await repository.getLatestChatsData();
        if (response != null) {
          userMessages = response
              .where((element) => element.lastMessage?.content != "")
              .toList();
          print(jsonEncode(response));
        }
      } catch (err) {
        print(err);
      }
      notifyListeners();
    }
  }

  navigateToChats() async {
    navigationService.navigateToWidget(const ChatHomeView());
  }

  goToChatDetail(MessageData val) async {
    GetChatDetailResponse chatDetailResponse = GetChatDetailResponse(
        user2Id: val.friendId ?? "",
        chatroomId: int.tryParse(val.lastMessage?.room ?? "") ?? 0);
    appCache.chatDetailResponse = chatDetailResponse;
    navigationService.navigateTo(chatDetailRoute);
  }

  // get service details data from storage
  Future<void> getStoredServiceProviderDetails() async {
    try {
      var response = await repository.getLocalServiceDetail();
      if (response != null) {
        serviceDetailsData = response;
        switchValue = serviceDetailsData?.provider?.isOnline ?? false;
      }
    } catch (err) {
      print(err);
    }
    print(jsonEncode(serviceDetailsData));
    notifyListeners();
  }

  GetOrderResponse? orderResponse;
  List<Results> orders = [];
  List<Results> tempOrder = [];
  bool isOrderAlreadyStored(Results bankResult, List<Results> storedList) {
    for (Results storedBank in storedList) {
      if (storedBank.uid == bankResult.uid &&
          storedBank.orderId == bankResult.orderId) {
        return true; // BankResult already exists in storedList
      }
    }
    return false; // BankResult does not exist in storedList
  }

  Future<List<Results>> getOrderServices({String? page}) async {
    startLoader();
    try {
      var response = await repository.getOrderService(page: page);
      orderResponse = response;
      if (response?.results != null) {
        // print(jsonEncode(response));
        List<Results> latest = response?.results ?? [];
        for (var order in latest) {
          if (!isOrderAlreadyStored(order, tempOrder)) {
            tempOrder.add(order);
          }
        }

        if (response?.next != null) {
          String next = response?.next ?? "";
          List<String> nexts = next.split("=");
          await getOrderServices(page: nexts[1]);
        }

        var oldorders = tempOrder
            .where((element) => element.status?.toLowerCase() != "completed")
            .toList();
        var newOrders = oldorders
            .where((element) => element.status?.toLowerCase() != "cancelled")
            .toList();
        orders = newOrders;
      }
      await repository.getPrivateUser();
      stopLoader();
      // notifyListeners();
      return orders;
    } catch (err) {
      stopLoader();
      // notifyListeners();
      return [];
    }
  }

  String formatDateTime(String dateTimeString) {
    // Parse the date string
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the date according to your preference
    String formattedDate = DateFormat('MMM d, yyyy HH:mm').format(dateTime);

    return formattedDate;
  }

  Future<void> getServiceProviderDetails() async {
    try {
      var res = await repository.getUserServiceDetail();
      if (res?.uid != null) {
        await getStoredServiceProviderDetails();
      }
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  onTap(Category selectedCategory) async {
    appCache.category = selectedCategory;
    navigationService.navigateTo(categoryDetailRoute);
  }

  goToViewBookingsMore() {
    appCache.initialIndex = 2;
    navigationService.navigateToAndRemoveUntil(homeRoute);
  }

  goToViewNotification() {
    navigationService.navigateToWidget(const NotificationHomeScreen());
  }

  onSwitchChanged(bool? value) async {
    switchValue = value!;
    await updateOnlineStatus();
    notifyListeners();
  }

  Future<void> refresh() async {
    await repository.getUser();
    await init();
  }

  VerificationStatus? status;

  init() async {
    context = navigationService.navigatorKey.currentState!.context;
    var res = await repository.getLocalUserStatus();
    status = res;
    emailVerified = res?.payload?.emailVerified ?? false;
    bvnVerified = res?.payload?.bvnVerified ?? false;
    if (userService.loginResponse.servicepro == false) {
      await getLocalCategories();
      getCategories();
      await gelLocalPopularService();
      if (categories.isNotEmpty) {
        String? categoryId = categories
            .first.uid; // Use an appropriate way to get the default category ID
        await getPopularProviders(categoryId: categoryId);
      }
    } else {
      getChatsData();
      getStoredServiceProviderDetails();
      await getOrderServices();
    }
  }

  goToRefer() {
    // referAndWinHomeRoute
    navigationService.navigateTo(referAndWinHomeRoute);
  }

  goToVerify() {
    navigationService.navigateToWidget(const VerificationHomeView());
  }

  onChange(String? value) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  Future<GetCategoryResponse?> getLocalCategories() async {
    startLoader();
    var response = await repository.getLocalCategories();
    categoryResponse = response;
    if (response?.results != null) {
      categories = response?.results ?? [];
    }
    stopLoader();
    notifyListeners();
    return response;
  }

  Future<GetCategoryResponse?> getCategories() async {
    startLoader();
    try {
      var response = await repository.getCategories();
      categoryResponse = response;
      if (response?.results != null) {
        categories = response?.results ?? [];
      }
      stopLoader();
      notifyListeners();
      return response;
    } catch (err) {
      print(err);
      stopLoader();
      notifyListeners();
      return null;
    }
  }

  bool emailVerified = false;
  bool bvnVerified = false;

  Stream<VerificationStatus?> userStatus() async* {
    var response = await repository.userStatus();
    emailVerified = response?.payload?.emailVerified ?? emailVerified;
    bvnVerified = response?.payload?.bvnVerified ?? bvnVerified;
    yield response;
  }

  goToCategory(Category category) {
    appCache.category = category;
    print(category);
  }

  goToViewMore() {
    appCache.initialIndex = 1;
    navigationService.navigateToAndRemoveUntil(homeRoute);
  }



  confirmTransaction(BuildContext context, String? amount, String? acountNumber,
      String? acountName, String? bankCode, String? narration) async {
    String? val = await showAppBottomSheet(const PinInputScreen());
    print(val);
    if (val != null) {
      String value = val ?? "";
      if (value.length == 4) {
        startLoader();
        try {
          var response = await repository.confirmTransaction(
              destAccountNumber: acountNumber!,
              amount: int.parse(amount ?? ""),
              destAccountName: acountName ?? "",
              destBankCode: bankCode!,
              naration: narration ?? "",
              pin: value);
          if (response != null) {
            showCustomToast(response.detail ?? "");
            print(jsonEncode(response));
            stopLoader();
          } else {
            showCustomToast("Wrong account inputs, try agian..");
          }
          stopLoader();
          notifyListeners();
        } catch (err) {
          print(err);
          stopLoader();
          notifyListeners();
        }
      }
    }

    // await navigationService.goBack();
  }

  topUp(String title, {Function? onTap, String? subtitle}) async {
    BuildContext context = navigationService.navigatorKey.currentState!.context;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      // builder: (_) => const BottomSheetScreen(child: TopUpScreen()),
      builder: (_) => const BottomSheetScreen(child: TopUpAmountModal()),
    );
  }

  confirm() async {
    showCustomToast(
      "Order Confirmed",
    );
  }

  withdrawal(HomeViewViewModel model) async {
    navigationService.navigateToWidget(const WithdrawScreen());
  }

  history() async {
    navigationService.navigateTo(transactionHistoryRoute);
  }

  transactionHistoryDetails() async {
    navigationService.navigateTo(transactionHistoryDetailsRoute);
  }

  List<ProviderUserResponse>? serviceResponse;

  // Future<List<ProviderUserResponse>?> getPopularProviders() async {
  //   startLoader();
  //   try {
  //     var response = await repository.getPopilarProviders(id);
  //     if (response != null && response.isNotEmpty) {
  //       serviceResponse = response;
  //       stopLoader();
  //       notifyListeners();
  //       return response;
  //     }
  //   } catch (err) {
  //     print("Error fetching popular providers: $err");
  //   }
  //   stopLoader();
  //   notifyListeners();
  //   return null;
  // }
  // Fetch popular providers by id
  Future<List<ProviderUserResponse>?> getPopularProviders(
      {String? categoryId}) async {
    startLoader();
    try {
      var response =
          await repository.getPopularProviders(categoryId: categoryId);
      if (response != null && response.isNotEmpty) {
        serviceResponse = response;
        stopLoader();
        notifyListeners();
        return response;
      } else {
        print("No data received from the server.");
      }
    } catch (err) {
      print("Error fetching popular providers: $err");
    }
    stopLoader();
    notifyListeners();
    return null;
  }

  gelLocalPopularService() async {
    startLoader();
    var response = await repository.getLocalPopularServices();
    if (response != null) {
      serviceResponse =
          (response ?? ProviderUserResponse()) as List<ProviderUserResponse>?;
      stopLoader();
      notifyListeners();
    }
  }
}

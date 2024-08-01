import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskitly/UI/base/base.ui.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/text_field.dart';
import 'package:taskitly/core/models/order_stats_response.dart';
import 'package:taskitly/utils/show-bottom-sheet.dart';
import 'package:taskitly/utils/snack_message.dart';
import 'package:taskitly/utils/text_styles.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../constants/palette.dart';
import '../../../../../constants/reuseables.dart';
import '../../../../../core/models/chat/join_a_room_model.dart';
import '../../../../../core/models/prodiders-service-response.dart';
import '../../../../../routes/routes.dart';
import '../../../../base/base.vm.dart';

class ProviderDetailViewViewModel extends BaseViewModel {
  List<ProviderUserResponse> bookMarkedProvider = [];
  var disputeTextController = TextEditingController();
  ProviderUserResponse? serviceDetailsData;

  late final PageController pageController;
  late final Timer timer;
  final int interval = 5; // Interval in seconds
  OrderStats? orderStats;
  double averageRating = 0.0;
  double ratingValue = 0;
  String serviceId = "";
  double completionRate = 0;

  bookMark(ProviderUserResponse serviceID) async {
    print(serviceID.companyName);
    await repository.storeBookMark(serviceID);
    await fetchBookMarkedProvider();
    notifyListeners();
  }

  fetchBookMarkedProvider() async {
    try {
      var response = await repository.getBookMarks();
      if (response != null) {
        bookMarkedProvider = response;
      }
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  removeBookMark(ProviderUserResponse provider) async {
    try {
      await repository.removeBookMark(provider);
      await fetchBookMarkedProvider();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  int currentIndex = 0;
  void onSelect(int? index) {
    int ins = index ?? 0;
    currentIndex = ins.round();
    notifyListeners();
  }

  init() async {
    pageController = PageController(viewportFraction: 0.9);
    serviceProvider = appCache.serviceProvider;
    print(jsonEncode(serviceProvider));
    await fetchBookMarkedProvider();
    // Initialize Timer
    timer = Timer.periodic(Duration(seconds: interval), (timer) {
      if (pageController.hasClients) {
        final int nextPage = (pageController.page?.toInt() ?? 0) + 1;
        pageController.animateToPage(
          nextPage % (serviceProvider.ratings?.length ?? 0),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
    serviceId = serviceDetailsData?.uid ?? "";
    if (serviceId.isNotEmpty) {
      await fetchOrderStats(serviceId: serviceId);
    }
  }

  ProviderUserResponse serviceProvider = ProviderUserResponse();
  GetChatDetailResponse chatDetailResponse = GetChatDetailResponse();

  onTap() async {
    await getChatDetails();
    if (chatDetailResponse.chatroomId != null) {
      appCache.chatDetailResponse = chatDetailResponse;
      navigationService
          .navigateTo(chatDetailRoute)
          .whenComplete(() => chatDetailResponse = GetChatDetailResponse());
    } else {
      showCustomToast("Chat Details not found");
    }
  }

  getChat() async {
    startLoader();
    try {
      var response =
          await repository.getChatRoomData(serviceProvider.provider?.uid ?? "");
      if (response?.chatroomId != null) {
        chatDetailResponse = response ?? GetChatDetailResponse();
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  getChatDetails() async {
    chatDetailResponse = GetChatDetailResponse();
    await getLocalChat();
    if (chatDetailResponse.chatroomId == null) {
      await getChat();
    }
    notifyListeners();
  }

  getLocalChat() async {
    var response = await repository
        .getLocalChatRoomData(serviceProvider.provider?.uid ?? "");
    if (response?.chatroomId != null) {
      chatDetailResponse = response ?? GetChatDetailResponse();
    }
    notifyListeners();
  }

  onChange(String? val) {
    notifyListeners();
  }

  showDispute(ProviderDetailViewViewModel model) async {
    showAppBottomSheet(DisputeView(model: model));
  }

  dispute({String? texts, String? userIDs, String? type}) async {
    startLoader();
    try {
      var response = await repository.reportUser(
          id: userIDs ?? serviceProvider.provider?.uid ?? "",
          description: texts ?? disputeTextController.text.trim(),
          type: type ?? "report");
      if (response?.status == true) {
        disputeTextController.clear();
        showCustomToast(response?.detail ?? "", success: true);
        navigationService.goBack();
      }
      stopLoader();
      notifyListeners();
    } catch (err) {
      print(err);
      stopLoader();
      notifyListeners();
    }
  }

  Future<dynamic> fetchOrderStats({required String serviceId}) async {
    startLoader();
    try {
      debugPrint('no fetched');
      var response = await repository.fetchOrderStats(serviceId: serviceId);
      debugPrint(response.toString());

      // Parse the response to a Map<String, dynamic>
      Map<String, dynamic> orderStats =
          response is String ? jsonDecode(response) : response;

      // Update averageRating and completionRate only if orderStats is not null
      if (orderStats != null) {
        averageRating = orderStats['average_rating'] ?? 0.0;
        completionRate = orderStats['completion_rate'] ?? 0.0;
      }
      debugPrint('success');
      stopLoader();
      notifyListeners();
    } on Exception catch (e) {
      print("Error fetching order stats: ${e.toString()}");
      // Handle error, e.g., show a user-friendly message
      stopLoader();
    }
    return null;
  }
}

class DisputeView extends StatefulWidget {
  final ProviderDetailViewViewModel model;
  const DisputeView({super.key, required this.model});

  @override
  State<DisputeView> createState() => _DisputeViewState();
}

class _DisputeViewState extends State<DisputeView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:
            height(navigationService.navigatorKey.currentState!.context) * 0.35,
        child: Stack(
          children: [
            Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      30.0.sbW,
                      AppText(
                        "Report User",
                        style: titleMedium.copyWith(color: textColor),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.model.disputeTextController.clear();
                            navigationService.goBack();
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: secondaryColor,
                          ),
                          child: const Icon(
                            Icons.clear,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.0.sbH,
                  TextArea(
                    controller: widget.model.disputeTextController,
                    hintText: "Enter dispute",
                    onChanged: (val) {
                      setState(() {
                        widget.model.onChange(
                            widget.model.disputeTextController.text.trim());
                      });
                    },
                  ),
                  10.0.sbH,
                  AppButton(
                    text: "Submit",
                    onTap:
                        widget.model.disputeTextController.text.trim().isEmpty
                            ? null
                            : () async {
                                await widget.model.dispute();
                                setState(() {});
                              },
                  )
                ],
              ),
            ),
            widget.model.isLoading ? const SmallLoader() : 0.0.sbW
          ],
        ));
  }
}

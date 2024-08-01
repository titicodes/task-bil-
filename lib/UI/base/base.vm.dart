import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:taskitly/core/models/tv_billers_response.dart';
import 'package:taskitly/utils/string-extensions.dart';

import '../../constants/reuseables.dart';
import '../../core/models/airtime_response_model.dart';
import '../../core/models/betting-response-model.dart';
import '../../core/models/block-list-response.dart';
import '../../core/models/education_billers_response.dart';
import '../../core/models/electricity_billers_response.dart';
import '../../core/models/internet_response_model.dart';
import '../../core/models/tv_bill_Response.dart';
import '../../core/repository/repository.dart';
import '../../core/services/local-service/app-cache.dart';
import '../../core/services/local-service/navigation_services.dart';
import '../../core/services/local-service/storage-service.dart';
import '../../core/services/local-service/user.service.dart';
import '../../core/services/web-services/auth.api.dart';
import '../../locator.dart';
import '../../utils/show-bottom-sheet.dart';
import '../../utils/snack_message.dart';
import '../auth/forget-password/verify-password/verify-password-ui.dart';
import '../widgets/action-pop-up.dart';
import '../widgets/action_dialog.dart';
import '../widgets/bottomSheet.dart';
import '../widgets/dispute-ui.dart';
import '../widgets/successful-pop-up.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;
  NavigationService navigationService = locator<NavigationService>();
  AuthenticationApiService auth = locator<AuthenticationApiService>();
  UserService userService = locator<UserService>();
  AppCache appCache = locator<AppCache>();
  StorageService storageService = locator<StorageService>();
  Repository repository = locator<Repository>();
  final FlutterContactPicker contactPicker = FlutterContactPicker();

  ViewState get viewState => _viewState;

  final formKey = GlobalKey<FormState>();

  bool isJson(String str) {
    try {
      json.decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  showDisputeIssues(String userID, String type) async {
    bool? data = await showAppBottomSheet(DisputeHOMEView(
      userID: userID,
      type: type,
    ));
  }

  List<BlockListResponse> blockedUsers = [];

  getLocalBlockedUser() async {
    var res = await repository.getLocalBlockedUser();
    if (res != null) {
      blockedUsers = res;
    }
    notifyListeners();
  }

  getBlockedUsers() async {
    startLoader();
    try {
      var response = await repository.getBlockedUser();
      if (response != null) {
        blockedUsers = response;
        print(blockedUsers.length);
        // print(jsonEncode(response));
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  Future<bool> disputeOrBlock(
      {String? texts, String? userIDs, String? type}) async {
    startLoader();
    try {
      var response = await repository.reportChatUser(
          id: userIDs ?? "", description: texts ?? "", type: type ?? "report");
      if (response?.status == true) {
        showCustomToast(response?.detail ?? "", success: true);
        navigationService.goBack();
        stopLoader();
        notifyListeners();
        return true;
      } else {
        stopLoader();
        notifyListeners();
        return false;
      }
    } catch (err) {
      print(err);
      stopLoader();
      notifyListeners();
      return false;
    }
  }

  int convertToDays(String? input) {
    // Check if the input is null or empty
    if (input == null || input.isEmpty) {
      return 0;
    }

    // Convert the input string to lowercase for case-insensitive comparison
    String lowerCaseInput = input.toLowerCase();

    // Check if the input string contains keywords and return corresponding days
    if (lowerCaseInput.contains('yearly')) {
      return 365; // Assuming a year has 365 days
    } else if (lowerCaseInput.contains('monthly')) {
      return 30; // Assuming a month has 30 days
    } else if (lowerCaseInput.contains('1 month')) {
      return 30; // Assuming a month has 30 days
    } else if (lowerCaseInput.contains('2 month')) {
      return 60; // Assuming a month has 30 days
    } else if (lowerCaseInput.contains('2 month')) {
      return 60; // Assuming a month has 30 days
    } else if (lowerCaseInput.contains('3 month')) {
      return 90; // Assuming a month has 30 days
    } else if (lowerCaseInput.contains('4 month')) {
      return 120; // Assuming a month has 30 days
    } else if (lowerCaseInput.contains('quarterly')) {
      return 90; // Assuming a quarter has 90 days
    } else if (lowerCaseInput.contains('daily')) {
      return 1; // Daily means 1 day
    } else {
      // Return -1 or any other value to indicate that the input is not recognized
      return 0;
    }
  }

  String calculateTimeAgo(String timestamp) {
    DateTime now = DateTime.now();
    DateTime parsedTime = DateTime.parse(timestamp);
    Duration difference = now.difference(parsedTime);

    // Calculate the number of days ago
    int days = difference.inDays;

    return '$days days ago';
  }

  String formatDate(String timestamp) {
    DateTime parsedTime = DateTime.parse(timestamp);
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(parsedTime);
    return formattedDate;
  }

  changePin() async {
    cache.comingFromChangePin = true;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: navigationService.navigatorKey.currentState!.context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => const BottomSheetScreen(child: VerifyPasswordScreen()),
    );
  }

  List<AirTimeServiceProvider> convertToServiceProviderList(
      AirtimeResponseModel airtimeResponse) {
    List<AirTimeServiceProvider> serviceProviderList = [];

    String removeVTUSuffix(String input) {
      const vtuSuffix = "_VTU";

      if (input.endsWith(vtuSuffix)) {
        return input.substring(0, input.length - vtuSuffix.length);
      } else {
        return input;
      }
    }

    if (airtimeResponse.data != null) {
      if (airtimeResponse.data!.mTNVTU != null) {
        serviceProviderList.add(AirTimeServiceProvider.fromJson({
          "id": airtimeResponse.data!.mTNVTU!.id,
          "slug": airtimeResponse.data!.mTNVTU!.slug,
          "name": removeVTUSuffix(airtimeResponse.data!.mTNVTU!.slug ?? ""),
          "image": AppImages.mtn,
          "amount": airtimeResponse.data!.mTNVTU!.amount,
          "billerId": airtimeResponse.data!.mTNVTU!.billerId,
          "sequenceNumber": airtimeResponse.data!.mTNVTU!.sequenceNumber,
        }));
      }

      if (airtimeResponse.data!.aIRTELVTU != null) {
        serviceProviderList.add(AirTimeServiceProvider.fromJson({
          "id": airtimeResponse.data!.aIRTELVTU!.id,
          "slug": airtimeResponse.data!.aIRTELVTU!.slug,
          "image": AppImages.airtel,
          "name": removeVTUSuffix(airtimeResponse.data!.aIRTELVTU!.slug ?? ""),
          "amount": airtimeResponse.data!.aIRTELVTU!.amount,
          "billerId": airtimeResponse.data!.aIRTELVTU!.billerId,
          "sequenceNumber": airtimeResponse.data!.aIRTELVTU!.sequenceNumber,
        }));
      }

      if (airtimeResponse.data!.gLOVTU != null) {
        serviceProviderList.add(AirTimeServiceProvider.fromJson({
          "id": airtimeResponse.data!.gLOVTU!.id,
          "slug": airtimeResponse.data!.gLOVTU!.slug,
          "image": AppImages.glo,
          "name": removeVTUSuffix(airtimeResponse.data!.gLOVTU!.slug ?? ""),
          "amount": airtimeResponse.data!.gLOVTU!.amount,
          "billerId": airtimeResponse.data!.gLOVTU!.billerId,
          "sequenceNumber": airtimeResponse.data!.gLOVTU!.sequenceNumber,
        }));
      }

      if (airtimeResponse.data!.m9MOBILEVTU != null) {
        serviceProviderList.add(AirTimeServiceProvider.fromJson({
          "id": airtimeResponse.data!.m9MOBILEVTU!.id,
          "slug": airtimeResponse.data!.m9MOBILEVTU!.slug,
          "image": AppImages.nineMobile,
          "name":
              removeVTUSuffix(airtimeResponse.data!.m9MOBILEVTU!.slug ?? ""),
          "amount": airtimeResponse.data!.m9MOBILEVTU!.amount,
          "billerId": airtimeResponse.data!.m9MOBILEVTU!.billerId,
          "sequenceNumber": airtimeResponse.data!.m9MOBILEVTU!.sequenceNumber,
        }));
      }
    }

    print(serviceProviderList.length);
    return serviceProviderList;
  }

  List<EducationData> convertToEducationProviderList(
      EducationBillersResponse billersResponse) {
    List<EducationData> providerList = [];

    if (billersResponse.data != null && billersResponse.data != null) {
      providerList.add(billersResponse.data!);
    }

    print(providerList.length);
    return providerList;
  }

  List<Bet9ja> convertToBettingProviderList(
      BettingResponseModel bettingResponse) {
    List<Bet9ja> providerList = [];

    if (bettingResponse.data != null) {
      if (bettingResponse.data!.bet9ja != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.bet9ja!.id,
          "slug": bettingResponse.data!.bet9ja!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.mLotto != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.mLotto!.id,
          "slug": bettingResponse.data!.mLotto!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.westernLotto != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.westernLotto!.id,
          "slug": bettingResponse.data!.westernLotto!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.bangBet != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.bangBet!.id,
          "slug": bettingResponse.data!.bangBet!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.nairaBet != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.nairaBet!.id,
          "slug": bettingResponse.data!.nairaBet!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.betKing != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.betKing!.id,
          "slug": bettingResponse.data!.betKing!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.greenLotto != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.greenLotto!.id,
          "slug": bettingResponse.data!.greenLotto!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.eliestLotto != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.eliestLotto!.id,
          "slug": bettingResponse.data!.eliestLotto!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.merryBet != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.merryBet!.id,
          "slug": bettingResponse.data!.merryBet!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.sureBet != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.sureBet!.id,
          "slug": bettingResponse.data!.sureBet!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.hALLABET != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.hALLABET!.id,
          "slug": bettingResponse.data!.hALLABET!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.betWay != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.betWay!.id,
          "slug": bettingResponse.data!.betWay!.slug,
          // Add other properties as needed
        }));
      }

      if (bettingResponse.data!.sportyBet != null) {
        providerList.add(Bet9ja.fromJson({
          "id": bettingResponse.data!.sportyBet!.id,
          "slug": bettingResponse.data!.sportyBet!.slug,
          // Add other properties as needed
        }));
      }
    }

    print(providerList.length);
    return providerList;
  }

  List<EnuguDisco> convertToPowerDistributionProviderList(
      PowerDistributionResponse powerDistributionResponse) {
    List<EnuguDisco> providerList = [];

    if (powerDistributionResponse.data != null) {
      if (powerDistributionResponse.data!.enuguDisco != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.enuguDisco!.id,
          "slug": powerDistributionResponse.data!.enuguDisco!.slug,
        }));
      }

      if (powerDistributionResponse.data!.ekoDisco != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.ekoDisco!.id,
          "slug": powerDistributionResponse.data!.ekoDisco!.slug,
        }));
      }

      if (powerDistributionResponse.data!.abujaDisco != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.abujaDisco!.id,
          "slug": powerDistributionResponse.data!.abujaDisco!.slug,
        }));
      }

      if (powerDistributionResponse.data!.portHarcourtDisco != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.portHarcourtDisco!.id,
          "slug": powerDistributionResponse.data!.portHarcourtDisco!.slug,
        }));
      }

      if (powerDistributionResponse.data!.iKEDC != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.iKEDC!.id,
          "slug": powerDistributionResponse.data!.iKEDC!.slug,
        }));
      }

      if (powerDistributionResponse.data!.iBEDC != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.iBEDC!.id,
          "slug": powerDistributionResponse.data!.iBEDC!.slug,
        }));
      }

      if (powerDistributionResponse.data!.kEDCO != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.kEDCO!.id,
          "slug": powerDistributionResponse.data!.kEDCO!.slug,
        }));
      }

      if (powerDistributionResponse.data!.kAEDCO != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.kAEDCO!.id,
          "slug": powerDistributionResponse.data!.kAEDCO!.slug,
        }));
      }
      if (powerDistributionResponse.data!.jEDC != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.jEDC!.id,
          "slug": powerDistributionResponse.data!.jEDC!.slug,
        }));
      }

      if (powerDistributionResponse.data!.pHED2 != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.pHED2!.id,
          "slug": powerDistributionResponse.data!.pHED2!.slug,
        }));
      }

      if (powerDistributionResponse.data!.aPLE != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.aPLE!.id,
          "slug": powerDistributionResponse.data!.aPLE!.slug,
        }));
      }

      if (powerDistributionResponse.data!.bEDC != null) {
        providerList.add(EnuguDisco.fromJson({
          "id": powerDistributionResponse.data!.bEDC!.id,
          "slug": powerDistributionResponse.data!.bEDC!.slug,
        }));
      }
    }

    print(providerList.length);
    return providerList;
  }

  List<ResponseData> convertToTvProviderList(TvBillerResponse billersResponse) {
    List<ResponseData> providerList = [];

    if (billersResponse.data != null &&
        billersResponse.data!.responseData != null) {
      providerList.addAll(billersResponse.data!.responseData!);
    }

    print(providerList.length);
    return providerList;
  }

  List<Smile> convertToInternetProviderList(
      InternetResponseModel internetResponse) {
    List<Smile> providerList = [];

    if (internetResponse.data != null) {
      // You can adapt the property names based on your InternetResponseModel structure.
      if (internetResponse.data!.smile != null) {
        providerList.add(Smile.fromJson({
          "id": internetResponse.data!.smile!.id,
          "slug": internetResponse.data!.smile!.slug,
        }));
      }

      if (internetResponse.data!.spectranet != null) {
        providerList.add(Smile.fromJson({
          "id": internetResponse.data!.spectranet!.id,
          "slug": internetResponse.data!.spectranet!.slug,
        }));
      }

      if (internetResponse.data!.smile2 != null) {
        providerList.add(Smile.fromJson({
          "id": internetResponse.data!.smile2!.id,
          "slug": internetResponse.data!.smile2!.slug,
        }));
      }

      if (internetResponse.data!.iPNX != null) {
        providerList.add(Smile.fromJson({
          "id": internetResponse.data!.iPNX!.id,
          "slug": internetResponse.data!.iPNX!.slug,
        }));
      }

      if (internetResponse.data!.sWIFTNETWORKS != null) {
        providerList.add(Smile.fromJson({
          "id": internetResponse.data!.sWIFTNETWORKS!.id,
          "slug": internetResponse.data!.sWIFTNETWORKS!.slug,
        }));
      }
    }

    print(providerList.length);
    return providerList;
  }

  set viewState(ViewState newState) {
    _viewState = newState;
    _viewState == ViewState.busy ? isLoading = true : isLoading = false;
    notifyListeners();
  }

  goBack() {
    navigationService.goBack();
  }

  logOuts(BuildContext context) {
    popDialog(context: context, onTap: userService.logout, title: "Log out");
  }

  bool isLoading = false;

  void startLoader() {
    if (!isLoading) {
      isLoading = true;
      viewState = ViewState.busy;
      notifyListeners();
    }
  }

  popUp(String title, Function onTap, {String? subtitle}) async {
    BuildContext context = navigationService.navigatorKey.currentState!.context;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
          child: PopUpDialog(
        title: title,
        onTap: onTap,
        subTitle: subtitle,
      )),
    );
  }

  showSuccess(String title, String subtitle) {
    BuildContext context = navigationService.navigatorKey.currentState!.context;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
          child: SuccessfulPopUpWidget(
        title: title.toTitleCase(),
        subTitle: subtitle,
        onTap: navigationService.goBack,
        buttonText: "OK",
        titleColor: Colors.black,
      )),
    );
  }

  Map<String, dynamic> filterNullValues(Map<String, dynamic> data) {
    Map<String, dynamic> filteredData = {};

    data.forEach((key, value) {
      if (value != null) {
        filteredData[key] = value;
      }
    });

    return filteredData;
  }

  Future<bool> checkAndRequestStoragePermission() async {
    PermissionStatus permissionStatus = await Permission.storage.status;
    if (permissionStatus.isGranted) {
      return true;
      // Permission is already granted
    } else if (permissionStatus.isDenied ||
        permissionStatus.isPermanentlyDenied) {
      // Permission is denied, request it
      PermissionStatus requestResult = await Permission.storage.request();
      if (requestResult.isGranted) {
        // Permission granted
        return true;
      } else {
        // Permission denied
        return false;
      }
    } else {
      return false;
    }
  }

  String getFileTypeFromUrl(String url) {
    List<String> parts = url.split('/');
    String fileName = parts.last;
    List<String> fileNameParts = fileName.split('.');

    if (fileNameParts.length > 1) {
      String extension = fileNameParts.last;
      switch (extension.toLowerCase()) {
        case 'jpg':
        case 'jpeg':
        case 'png':
        case 'svg':
        case 'heic':
        case 'webp':
          return 'image.${extension.toLowerCase()}';
        case 'mp4':
        case 'avi':
        case 'mov':
          return 'video.${extension.toLowerCase()}';
        case 'pdf':
          return 'PDF.${extension.toLowerCase()}';
        case 'docx':
        case 'doc':
          return 'Document.${extension.toLowerCase()}';
        default:
          return 'Unknown';
      }
    } else {
      return 'Unknown';
    }
  }

  popDialog({
    required BuildContext context,
    required VoidCallback onTap,
    VoidCallback? otherOnTap,
    required String title,
    String? subTitle,
    String? cancelButtonText,
    String? doItButtonText,
    Widget? prefixIcon1,
    Widget? prefixIcon2,
  }) async {
    showBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        enableDrag: false,
        builder: (BuildContext context) => ActionBottomSheet(
              onTap: onTap,
              title: title,
              subTitle: subTitle,
              cancelButtonText: cancelButtonText,
              doItButtonText: doItButtonText,
              prefixIcon1: prefixIcon1,
              prefixIcon2: prefixIcon2,
              otherOnTap: otherOnTap,
            ));
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      viewState = ViewState.idle;
      notifyListeners();
    }
  }
}

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Use a regular expression to remove non-numeric characters
    final filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    return TextEditingValue(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}

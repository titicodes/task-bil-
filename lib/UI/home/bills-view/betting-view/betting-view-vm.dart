import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/home/bills-view/payment-view/electricity-payment-details-screen.dart';
import 'package:taskitly/UI/widgets/bottomSheet.dart';
import '../../../../core/models/betting-response-model.dart';
import '../../../../core/models/electricity_biller_type_res.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/snack_message.dart';
import '../../../base/base.vm.dart';
import 'betting-provider-type-view/betting-provider-type-view-ui.dart';
import 'betting-providers-view/betting-providers-view-ui.dart';

class BettingBillViewViewModel extends BaseViewModel {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountNumberController = TextEditingController();
  BettingResponseModel bettingResponseModel = BettingResponseModel();

  String? selectedProvider;
  String? selectedProviderType;
  int? selectedProviderId;
  List<Bet9ja> providers = [];
  Bet9ja? provider;
  BillerTypeResponse bettingTypeResponseModel = BillerTypeResponse();
  List<ResponseTypeData> typeProviders = [];
  ResponseTypeData? typeProvider;
  bool isProviderSelected = false;

  late BuildContext context;

  init(BuildContext contexts) async {
    context = contexts;
    await getLocalBettingProvider();
    await getLocalElectricityTypeProvider();
    if (bettingResponseModel.data == null) {
      await fetchBettingProvider();
    }
    // await onChanged(providers[0]);
  }

  onChange(String? val) {
    notifyListeners();
  }

  onChanged(Bet9ja? provide) async {
    provider = provide;
    await onProviderSelected(provide);
    notifyListeners();
  }

  history() async {
    navigationService.navigateTo(transactionHistoryRoute);
  }

  onProviderSelected(Bet9ja? provide) async {
    provider = provide;
    print(provide?.slug);
    isProviderSelected = true;
    notifyListeners();
    //await getLocalElectricityTypeProvider();
    await fetchBettingTypeProvider(provider!.id!);
  }

  selectBettingType(ResponseTypeData responseTypeData) {
    typeProvider = responseTypeData;
    print(typeProvider?.name);
    print(typeProvider?.amount);
    notifyListeners();
  }

  getLocalBettingProvider() async {
    var response = await repository.getLocalBettingProvider();
    if (response?.data != null) {
      bettingResponseModel = response ?? BettingResponseModel();
      providers = convertToBettingProviderList(bettingResponseModel);
      // print(jsonEncode(providers));
      stopLoader();
      notifyListeners();
    }
  }

  fetchBettingProvider() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getBetting();
      if (response?.data != null) {
        bettingResponseModel = response ?? BettingResponseModel();
        providers = convertToBettingProviderList(bettingResponseModel);
        stopLoader();
        notifyListeners();
      }
      stopLoader();
      notifyListeners();
    } on DioException {
      stopLoader();
      notifyListeners();
    }
  }

  getLocalElectricityTypeProvider() async {
    var response = await repository.getLocalElectricityTypeProvider();
    if (response?.data != null) {
      bettingTypeResponseModel = response ?? BillerTypeResponse();
      typeProviders = bettingTypeResponseModel.data!.responseData!;
      // convertToPowerDistributionProviderList(electricityTypeResponseModel);
      print(jsonEncode(providers));
      stopLoader();
      notifyListeners();
    }
  }

  fetchBettingTypeProvider(int providerId) async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getElectricityType(providerId);
      if (response?.data != null) {
        bettingTypeResponseModel = response ?? BillerTypeResponse();
        // print(electricityTypeResponseModel.)
        typeProviders = bettingTypeResponseModel.data!.responseData!;
        //     convertToPowerDistributionProviderList(electricityTypeResponseModel);
        stopLoader();
        notifyListeners();
      }
      stopLoader();
      notifyListeners();
    } on DioException {
      stopLoader();
      notifyListeners();
    }
  }

  void showElectricityProvidersBottomSheet() async {
    await showModalBottomSheet<List<Object>>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
        child: BettingProviderScreen(
            providers: providers,
            selectBettingProvider: onProviderSelected,
            selectedProvider: provider),
      ),
    );

    notifyListeners();
  }

  void showElectricityTypeProvidersBottomSheet() async {
    await showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
        child: BettingProviderTypeScreen(
            typeProviders: typeProviders,
            selectBettingTypeProvider: selectBettingType,
            selectedTypeProvider: typeProvider),
      ),
    );
    notifyListeners();
  }

  List<String> value = [
    "100",
    "200",
    "300",
    "400",
    "1000",
    "2000",
    "3000",
    "5000",
  ];

  void onChipSelected(String amount) {
    amountNumberController = TextEditingController(text: amount);
    notifyListeners();
  }

  fetchCustomerEnquiry() async {
    if (phoneNumberController.text.trim().isEmpty) {
      showCustomToast("Invalid input please try again..", success: false);
    } else {
      startLoader();
      try {
        var response = await repository.customerEnquiry(
            meterNumber: phoneNumberController.text,
            electricitySlug: provider!.slug!,
            elecetricityTypeSlug: typeProvider!.slug!);
        if (response != null) {
          if (response.detail?.message ==
              "An error occurred while validating the customer's identity") {
            showCustomToast(
                "An error occurred while validating the customer's identity");
            stopLoader();
          } else {
            stopLoader();
            payElectricity();
          }
        }
        notifyListeners();
      } catch (err) {
        print(err);
        stopLoader();
        notifyListeners();
      }
    }
  }

  payElectricity() async {
    FocusManager.instance.primaryFocus?.unfocus();

    startLoader();
    try {
      stopLoader();
      if (phoneNumberController.text.isNotEmpty &&
          amountNumberController.text.isNotEmpty) {
        print(selectedProviderType);

        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (_) => BottomSheetScreen(
              child: ElectricityPaymentDetailsScreen(
            phoneNumber: phoneNumberController.text.trim(),
            amount: amountNumberController.text.trim(),
            selectedDataName: typeProvider!.slug,
          )),
        );
      } else {
        showCustomToast("Invalid input please try again!", success: false);
      }
    } catch (err) {}
  }
}

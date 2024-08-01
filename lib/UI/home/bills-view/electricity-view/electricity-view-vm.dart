import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/home/bills-view/payment-view/electricity-payment-details-screen.dart';
import 'package:taskitly/UI/widgets/bottomSheet.dart';

import '../../../../core/models/customer-enquiry-response.dart';
import '../../../../core/models/electricity_biller_type_res.dart';
import '../../../../core/models/electricity_billers_response.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/snack_message.dart';
import '../../../../utils/string-extensions.dart';
import '../../../base/base.vm.dart';
import 'electricity-provider-type-view/electricity-provider-type-view-ui.dart';
import 'electricity-providers-view/electricity-providers-view-ui.dart';

class ElectricityBillViewViewModel extends BaseViewModel {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountNumberController = TextEditingController();
  String? selectedProvider;
  String? selectedProviderType;
  int? selectedProviderId;
  String? postpaidElectricity;
  String? prepaidElectricity;
  String? selectPaidElectricity;
  PowerDistributionResponse electricityResponseModel =
      PowerDistributionResponse();
  List<EnuguDisco> providers = [];
  EnuguDisco? provider;
  CustomerEnquiryResponse? enquiryResponse;
  bool isPostpaidSelected = true;
  BillerTypeResponse electricityTypeResponseModel = BillerTypeResponse();
  List<ResponseTypeData> typeProviders = [];
  ResponseTypeData? typeProvider;

  late BuildContext context;

  init(BuildContext contexts) async {
    context = contexts;
    await getLocalElectricityProvider();
    //await getLocalElectricityTypeProvider();
    if (electricityResponseModel.data == null) {
      await fetchElectricityProvider();
    }
    await onChanged(providers[0]);
  }

  onChange(String? val) {
    notifyListeners();
  }

  onChanged(EnuguDisco? provide) {
    provider = provide;
    notifyListeners();
  }

  onProviderSelected(EnuguDisco? provide) async {
    provider = provide;
    print(provide?.slug);
    print(provider?.slug);
    //isProviderSelected = true;
    notifyListeners();
    await fetchElectricityTypeProvider(provider!.id!);
  }

  selectElectType(ResponseTypeData responseTypeData) {
    typeProvider = responseTypeData;
    print(typeProvider?.name);
    print(typeProvider?.amount);
    notifyListeners();
  }

  getLocalElectricityProvider() async {
    var response = await repository.getLocalElectricityProvider();
    if (response?.data != null) {
      electricityResponseModel = response ?? PowerDistributionResponse();
      providers =
          convertToPowerDistributionProviderList(electricityResponseModel);
      // print(jsonEncode(providers));
      stopLoader();
      notifyListeners();
    }
  }

  history() async {
    navigationService.navigateTo(transactionHistoryRoute);
  }

  getLocalElectricityTypeProvider() async {
    var response = await repository.getLocalElectricityTypeProvider();
    if (response?.data != null) {
      electricityTypeResponseModel = response ?? BillerTypeResponse();
      typeProviders = electricityTypeResponseModel.data!.responseData!;
      // convertToPowerDistributionProviderList(electricityTypeResponseModel);
      print(jsonEncode(providers));
      stopLoader();
      notifyListeners();
    }
  }

  fetchElectricityProvider() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getElectricity();
      if (response?.data != null) {
        electricityResponseModel = response ?? PowerDistributionResponse();
        providers =
            convertToPowerDistributionProviderList(electricityResponseModel);
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
        child: ElectricityProviderScreen(
          providers: providers,
          selectElectricityProvider: onProviderSelected,
          selectedProvider: provider,
        ),
      ),
    );

    notifyListeners();
  }

  fetchElectricityTypeProvider(int providerId) async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getElectricityType(providerId);
      if (response?.data != null) {
        electricityTypeResponseModel = response ?? BillerTypeResponse();
        // print(electricityTypeResponseModel.)
        typeProviders = electricityTypeResponseModel.data!.responseData!;

        prepaidElectricity = typeProviders[0].slug;
        postpaidElectricity = typeProviders[1].slug;
        print(prepaidElectricity);
        print(postpaidElectricity);
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

  void showElectricityTypeProvidersBottomSheet() async {
    selectedProviderType = await showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
        child: ElectricityProviderTypeScreen(
            electricityProviderId: selectedProviderId!),
      ),
    );

    if (selectedProvider != null) {
      notifyListeners();
    }
  }

  void getSelectedPaidElectricity(String selectedPaidElectricity) {
    print("Selected Paid Electricity: $selectedPaidElectricity");
    selectPaidElectricity = selectedPaidElectricity;
    notifyListeners();
  }

  List<String> value = [
    "1000",
    "2000",
    "3000",
    "4000",
    "5000",
    "6000",
    "10000",
    "20000",
  ];

  void onChipSelected(String amount) {
    amountNumberController = TextEditingController(text: amount);
    notifyListeners();
  }

  fetchCustomerEnquiry() async {
    if (phoneNumberController.text.isEmpty ||
        phoneNumberController.text.length < 11 ||
        provider!.slug == null ||
        selectPaidElectricity!.isEmpty) {
      showCustomToast("Invalid input please try again..", success: false);
    } else {
      startLoader();
      try {
        enquiryResponse = await repository.customerEnquiry(
            meterNumber: phoneNumberController.text,
            electricitySlug: provider!.slug!,
            elecetricityTypeSlug: selectPaidElectricity!);
        if (enquiryResponse != null) {
          stopLoader();

          // showCustomToast("Customer Enquiry successful", success: true);
          payElectricity();
        }
        notifyListeners();
      } catch (err) {
        print(err);
        stopLoader();
        notifyListeners();
      }
    }
    // await navigationService.goBack();
  }

  void printSelectedButtonValue(String? selectedValue) {
    print("Selected Button Value: $selectedValue");
  }

  payElectricity() async {
    FocusManager.instance.primaryFocus?.unfocus();
    phoneNumber:
    formatPhoneNumber(trimPhone(phoneNumberController.text));

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
            selectedDataName: provider?.slug,
          )),
        );
      } else {
        showCustomToast("Invalid input please try again!", success: false);
      }
    } catch (err) {}
  }
}

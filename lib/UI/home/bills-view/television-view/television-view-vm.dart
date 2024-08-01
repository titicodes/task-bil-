import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/home/bills-view/payment-view/electricity-payment-details-screen.dart';
import 'package:taskitly/UI/widgets/bottomSheet.dart';
import '../../../../core/models/customer-enquiry-response.dart';
import '../../../../core/models/electricity_biller_type_res.dart';
import '../../../../core/models/tv_bill_Response.dart';
//import '../../../../core/models/tv_billers_response.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/snack_message.dart';
import '../../../../utils/string-extensions.dart';
import '../../../base/base.vm.dart';
import 'television-providers-view/television-provider-type-view-ui.dart';
import 'television-providers-view/television-providers-view-ui.dart';

class TelevisionBillViewViewModel extends BaseViewModel {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountNumberController = TextEditingController();
  TvBillerResponse televisionResponseModel = TvBillerResponse();
  BillerTypeResponse electricityTypeResponseModel = BillerTypeResponse();
  List<ResponseData> providers = [];
  ResponseData? provider;
  CustomerEnquiryResponse? enquiryResponse;
  String? customerName;
  List<ResponseTypeData> typeProviders = [];
  ResponseTypeData? typeProvider;
  String? selectedProvider;
  String? selectedProviderType;
  int? selectedProviderId;
  bool isProviderSelected = false;
  late BuildContext context;
  bool isNameVisible = false;

//::// Initializing viewmodel to fetch all available providers (local or from server) //:://
  init(BuildContext contexts) async {
    context = contexts;
    await getLocalTvProvider();
    if (televisionResponseModel.data == null) {
      await fetchTelevisionProvider();
    }
    //:// display first data //://
    await onChanged(providers[0]);
  }

  onChange(String? val) {
    notifyListeners();
  }

  onChanged(ResponseData? provide) {
    provider = provide;
    onProviderSelected(provide);
    typeProvider == null;
    // isProviderSelected = true;
    notifyListeners();
  }

  history() async {
    navigationService.navigateTo(transactionHistoryRoute);
  }

  //::// Fetch all television providers from the server //:://
  fetchTelevisionProvider() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getTelevision();
      if (response?.data != null) {
        televisionResponseModel = response ?? TvBillerResponse();
        providers = convertToTvProviderList(televisionResponseModel);
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

  //::// Fetch all tv type providers from the server //:://
  fetchTvTypeProvider(int providerId) async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getElectricityType(providerId);
      if (response?.data != null) {
        electricityTypeResponseModel = response ?? BillerTypeResponse();
        typeProviders = electricityTypeResponseModel.data!.responseData!;
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

  onProviderSelected(ResponseData? provide) async {
    provider = provide;
    print(provide?.name);
    isProviderSelected = true;
    typeProvider = null;
    notifyListeners();
    await fetchTvTypeProvider(provider!.id!);
  }

  selectTelevisionType(ResponseTypeData responseTypeData) {
    typeProvider = responseTypeData;
    notifyListeners();
  }

  //::// Get all tv providers Locally //:://
  getLocalTvProvider() async {
    var response = await repository.getLocalTelevisionProvider();
    if (response?.data != null) {
      televisionResponseModel = response ?? TvBillerResponse();
      providers = convertToTvProviderList(televisionResponseModel);
      print(jsonEncode(providers));
      stopLoader();
      notifyListeners();
    }
  }

  void showTvProvidersBottomSheet() async {
    await showModalBottomSheet<List<Object>>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
        child: TelevisionProviderScreen(
          providers: providers,
          selectTvProvider: onProviderSelected,
          selectedProvider: provider,
        ),
      ),
    );

    notifyListeners();
  }

  void showTVTypeProvidersBottomSheet() async {
    await showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
        child: TelevisionProviderTypeScreen(
            setlectedTypeProvider: typeProvider,
            typeProviders: typeProviders,
            selectTvTypeProvider: selectTelevisionType),
      ),
    );

    if (selectedProvider != null) {
      notifyListeners();
    }
  }

  fetchCustomerEnquiry() async {
    if (phoneNumberController.text.isEmpty ||
        phoneNumberController.text.length < 13 ||
        provider!.slug == null ||
        typeProvider!.slug == null) {
      showCustomToast("Invalid input please try again..", success: false);
    } else {
      startLoader();
      try {
        enquiryResponse = await repository.customerEnquiry(
            meterNumber: phoneNumberController.text,
            electricitySlug: provider!.slug!,
            elecetricityTypeSlug: typeProvider!.slug!);
        if (enquiryResponse != null) {
          customerName =
              enquiryResponse?.detail?.responseData?.customer?.customerName;
          stopLoader();
          showCustomToast(
              "Customer Enquiry successful ${enquiryResponse?.detail?.responseData?.customer?.customerName}",
              success: true);
          //payTelevision();
        }
        notifyListeners();
      } catch (err) {
        print(err);
        stopLoader();
        notifyListeners();
      }
    }
  }

  payTelevision() async {
    FocusManager.instance.primaryFocus?.unfocus();

    formatPhoneNumber(trimPhone(phoneNumberController.text));
    startLoader();
    try {
      stopLoader();
      if (phoneNumberController.text.isNotEmpty) {
        print(selectedProviderType);

        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (_) => BottomSheetScreen(
              child: ElectricityPaymentDetailsScreen(
            phoneNumber: phoneNumberController.text.trim(),
            amount: "${typeProvider?.amount}",
            selectedDataName: typeProvider?.slug,
          )),
        );
      } else {
        showCustomToast("Invalid input please try again!", success: false);
      }
    } catch (err) {}
  }
}

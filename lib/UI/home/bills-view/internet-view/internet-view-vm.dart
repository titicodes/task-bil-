import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/home/bills-view/internet-view/internet-type-providers-screen.dart';
import 'package:taskitly/UI/widgets/bottomSheet.dart';
import '../../../../core/models/electricity_biller_type_res.dart';
import '../../../../core/models/internet_response_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/snack_message.dart';
import '../../../base/base.vm.dart';
import '../payment-view/internet-payment-details-screen.dart';

class InternetBillViewViewModel extends BaseViewModel {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountNumberController = TextEditingController();
  TextEditingController billerController = TextEditingController();
  InternetResponseModel internetResponseModel = InternetResponseModel();
  BillerTypeResponse internetTypeResponseModel = BillerTypeResponse();
  List<ResponseTypeData> typeProviders = [];
  ResponseTypeData? typeProvider;
  bool isProviderSelected = false;

  List<Smile> providers = [];

  late BuildContext context;

  Smile? provider;

  init(BuildContext contexts) async {
    context = contexts;
    getLocalInternetProvider();
    fetchInternet();
  }

  onChange(String? val) {
    notifyListeners();
  }

  void printPhoneNumber() {
    print("Phone Number: ${phoneNumberController.text}");
    print("Selected Amount: ${amountNumberController.text.trim()}");
  }

  onChanged(Smile? provide) async {
    provider = provide;
    notifyListeners();
    await fetchInternetTypeProvider(provider!.id!);
  }

  List<String> value = [
    "1000",
    "2000",
    "3000",
    "4000",
    "5000",
    "6000",
    "10000",
    "20000"
  ];

  void onChipSelected(String amount) {
    amountNumberController = TextEditingController(text: amount);
    notifyListeners();
  }

  selectInternetType(ResponseTypeData? responseTypeData) {
    typeProvider = responseTypeData;
    onChipSelected((typeProvider?.amount ?? 0).toString());
    notifyListeners();
  }

  void showInternetTypeProvidersBottomSheet() async {
    await showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
        child: InternetProviderTypeScreen(
            typeProviders: typeProviders,
            selectBettingTypeProvider: selectInternetType,
            selectedProvider: typeProvider),
      ),
    );
    notifyListeners();
  }

  fetchInternetTypeProvider(int providerId) async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getElectricityType(providerId);
      if (response?.data != null) {
        internetTypeResponseModel = response ?? BillerTypeResponse();
        // print(electricityTypeResponseModel.)
        typeProviders = internetTypeResponseModel.data!.responseData!;
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

  getLocalInternetProvider() async {
    var response = await repository.getLocalInternetProvider();
    if (response?.data != null) {
      internetResponseModel = response ?? InternetResponseModel();
      providers = convertToInternetProviderList(internetResponseModel);
      await onChanged(providers[0]);
      notifyListeners();
    }
  }

  fetchInternet() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getInternet();
      if (response?.data != null) {
        internetResponseModel = response ?? InternetResponseModel();
        providers = convertToInternetProviderList(internetResponseModel);
        await onChanged(providers[0]);
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

  fetchCustomerEnquiry() async {
    if (phoneNumberController.text.isEmpty ||
        provider!.slug == null ||
        typeProvider!.slug == null) {
      showCustomToast("Invalid input please try again..", success: false);
    } else {
      startLoader();
      try {
        var response = await repository.customerEnquiry(
            meterNumber: phoneNumberController.text,
            electricitySlug: provider!.slug!,
            elecetricityTypeSlug: typeProvider!.slug!);
        if (response != null) {
          stopLoader();
          showCustomToast("Customer Enquiry successful", success: true);
          payInternet();
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

  payInternet() async {
    FocusManager.instance.primaryFocus?.unfocus();

    startLoader();
    try {
      stopLoader();
      if (phoneNumberController.text.isNotEmpty && provider != null) {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (_) => BottomSheetScreen(
              child: InternetPaymentDetailsScreen(
            phoneNumber: phoneNumberController.text.trim(),
            amount: typeProvider?.amount.toString() ?? "",
            selectedProvider: provider,
          )),
        );
      } else {
        showCustomToast("Invalid input please try again!", success: false);
      }
    } catch (err) {}
  }

  history() async {
    navigationService.navigateTo(transactionHistoryRoute);
  }
}

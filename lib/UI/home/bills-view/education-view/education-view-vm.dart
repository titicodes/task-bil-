import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/home/bills-view/payment-view/payment-details-screen.dart';
import 'package:taskitly/UI/widgets/bottomSheet.dart';
import '../../../../core/models/education_billers_response.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/snack_message.dart';
import '../../../base/base.vm.dart';
import 'education_provider_screen.dart';

class EducationBillViewViewModel extends BaseViewModel {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountNumberController = TextEditingController();
  TextEditingController billerController = TextEditingController();
  EducationBillersResponse? educationResponseModel = EducationBillersResponse();
  bool isProviderSelected = false;
  late BuildContext context;
  List<EducationData> providers = [];
  EducationData? provider;

  init(BuildContext contexts) async {
    context = contexts;
    await getLocalEducationProvider();
    if (educationResponseModel?.data == null) {
      await fetchEducation();
    }
    // this function w
    await onChanged(providers[0]);
  }

  onChange(String? val) {
    notifyListeners();
  }

  history() async {
    navigationService.navigateTo(transactionHistoryRoute);
  }

  void printPhoneNumber() {
    print("Phone Number: ${phoneNumberController.text}");
    print("Selected Amount: ${amountNumberController.text.trim()}");
    // print("Selected slug: ${educationResponseModel.data?.slug}");
  }

  onChanged(EducationData? provide) {
    provider = provide;
    notifyListeners();
  }

  void onChipSelected(String amount) {
    amountNumberController = TextEditingController(text: amount);
    notifyListeners();
  }

  getLocalEducationProvider() async {
    var response = await repository.getLocalEducationProvider();
    if (response?.data != null) {
      educationResponseModel = response ?? EducationBillersResponse();
      // providers = convertToInternetProviderList(educationResponseModel);
      // print(jsonEncode(providers));
      stopLoader();
      notifyListeners();
    }
  }

  fetchEducation() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getEducation();
      if (response?.data != null) {
        educationResponseModel = response ?? EducationBillersResponse();
        providers = convertToEducationProviderList(educationResponseModel!);
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

  onProviderSelected(EducationData? provide) async {
    provider = provide;
    print(provide?.slug);
    isProviderSelected = true;
    notifyListeners();
    //await fetchTvTypeProvider(provider!.id!);
  }

  void showEducationProvidersBottomSheet() async {
    await showModalBottomSheet<List<Object>>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
        child: EducationProviderScreen(
          providers: providers,
          selectEducartionProvider: onProviderSelected,
          selectedProvider: provider,
          //educationResponseModel: educationResponseModel,
        ),
      ),
    );

    notifyListeners();
  }

  fetchCustomerEnquiry() async {
    if (phoneNumberController.text.isEmpty ||
        phoneNumberController.text.length < 11 ||
        educationResponseModel!.data!.slug == null) {
      showCustomToast("Invalid input please try again..", success: false);
    } else {
      startLoader();
      try {
        var response = await repository.customerEnquiry(
            meterNumber: phoneNumberController.text,
            electricitySlug: educationResponseModel!.data!.slug!,
            elecetricityTypeSlug: "JAMB_DE");
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
  }

  payInternet() async {
    FocusManager.instance.primaryFocus?.unfocus();

    startLoader();
    try {
      stopLoader();
      if (phoneNumberController.text.isNotEmpty &&
          amountNumberController.text.isNotEmpty) {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (_) => BottomSheetScreen(
              child: PaymentDetailsScreen(
            phoneNumber: phoneNumberController.text.trim(),
            amount: amountNumberController.text.trim(),
            selectedEducationName: "JAMB_DE",
          )),
        );
      } else {
        showCustomToast("Invalid input please try again!", success: false);
      }
    } catch (err) {}
  }

  //::// Fetch all tv type providers from the server //:://
  // fetchTvTypeProvider(int providerId) async {
  //   FocusManager.instance.primaryFocus?.unfocus();
  //   startLoader();
  //   try {
  //     var response = await repository.getElectricityType(providerId);
  //     if (response?.data != null) {
  //       electricityTypeResponseModel = response ?? BillerTypeResponse();
  //       typeProviders = electricityTypeResponseModel.data!.responseData!;
  //       stopLoader();
  //       notifyListeners();
  //     }
  //     stopLoader();
  //     notifyListeners();
  //   } on DioException catch (err) {
  //     stopLoader();
  //     notifyListeners();
  //   }
  // }
}

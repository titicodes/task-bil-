import 'package:flutter/material.dart';

import '../../../../core/models/internet_response_model.dart';
import '../../../../utils/snack_message.dart';
import '../../../base/base.vm.dart';
import '../../../widgets/bottomSheet.dart';
import '../airtime-view/airtime-view-vm.dart';
import '../pin-view/pin-view-ui.dart';

class InternetPaymentDetailsViewModel extends BaseViewModel {
  AirtiemBillViewViewModel airtiemBillViewViewModel =
      AirtiemBillViewViewModel();
  String phoneNumber = "";
  String amount = "";
  Smile? selectedProvider;
  String? selectedDataName;

  late BuildContext context;

  init({
    required BuildContext contexts,
    required String phoneNumber,
    required String amount,
    required Smile? selectedProvider,
    required String? selectedDataName,
  }) {
    context = contexts;
    this.phoneNumber = phoneNumber;
    this.amount = amount;
    this.selectedProvider = selectedProvider;
    this.selectedDataName = selectedDataName;
    // if (selectedProvider != null) {
    //   print("Selected Provider Name: ${selectedProvider.name}");
    // }

    // airtiemBillViewViewModel.phoneNumberController.text;
  }

  enterAirtimePin() async {
    FocusManager.instance.primaryFocus?.unfocus();
    // var userData = UserData(
    // phoneNumber:
    // formatPhoneNumber(trimPhone(phoneNumberController.text));
    // );
    startLoader();
    try {
      //var response = await repository.forgetPassword(data: userData);
      stopLoader();
      if (phoneNumber.isNotEmpty) {
        //response?.status==true
        // appCache.forgetPasswordResponse = response?? GetOtpResponse();
        // appCache.phoneNumber = trimPhone(phoneNumber);
        // appCache.userData = userData;

        // showCustomToast(
        //     "purchasing airtime for ${trimPhone("${trimPhone(phoneNumber)}")}",
        //     success: true); //phoneNumber
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (_) => BottomSheetScreen(
              child: TransactionPinScreen(
            phoneNumber: phoneNumber,
            amount: amount,
            //selectedInternetProvider: selectedProvider,
            selectedDataName: "IPNX_DATA",
          )),
        );
      } else {
        showCustomToast("Invalid input please try again!", success: false);
      }
    } catch (err) {}
  }
}

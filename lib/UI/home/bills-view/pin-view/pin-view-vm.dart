import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/base/base.vm.dart';

import '../../../../core/models/airtime_response_model.dart';
import '../../../../core/models/get-otp-response.dart';
import '../../../../core/models/internet_response_model.dart';
import '../../../../routes/routes.dart';

class TransactionPinViewModel extends BaseViewModel {
  var pinCodeController = TextEditingController();
  late BuildContext context;
  GetOtpResponse? previousResponse;
  String phoneNumber = "";
  String amount = "";
  AirTimeServiceProvider? selectedProvider;
  Smile? selectedInternetProvider;
  String? selectedDataName;

  int secondsRemaining = 60;
  Timer? timer;

  init({
    required BuildContext contexts,
    required String phoneNumber,
    required String amount,
    required AirTimeServiceProvider? selectedProvider,
    required Smile? selectedInternetProvider,
    required String? selectedDataName,
  }) {
    context = contexts;
    this.phoneNumber = phoneNumber;
    this.amount = amount;
    this.selectedProvider = selectedProvider;
    this.selectedDataName = selectedDataName;
    this.selectedInternetProvider = selectedInternetProvider;
    // if (selectedProvider != null) {
    //   print("Selected Provider Name: ${selectedProvider.name}");
    // }
    previousResponse = appCache.forgetPasswordResponse;
  }

  onChange(String? val) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  printPin() {
    print(pinCodeController.text);
    notifyListeners();
  }

  verifyPin(BuildContext context) async {
    startLoader();
    try {
      var response = await repository.verifyTransactionPin(
        productName: selectedProvider?.slug ??
            selectedDataName ??
            selectedInternetProvider!.slug!,
        phoneNumber: phoneNumber,
        amount: amount,
        pin: pinCodeController.text,
      );
      if (response != null) {
        stopLoader();
        // showCustomToast("Airtime purchase Successful", success: true);
        await repository.getUser();
        navigationService.navigateTo(successWidgetRoute);
        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>BillsSuccessfulWidget(subTitle: "",title: "Purchase Successful",
        //  onTap: ,)));
      }
      stopLoader();
      notifyListeners();
    } catch (err) {
      print(err);
      stopLoader();
      notifyListeners();
    }

    // await navigationService.goBack();
  }

  void appendDigit(String digit) {
    if (pinCodeController.text.length < 4) {
      pinCodeController.text += digit;
      notifyListeners();
    }
  }

  void deleteDigit() {
    if (pinCodeController.text.isNotEmpty) {
      pinCodeController.text = pinCodeController.text
          .substring(0, pinCodeController.text.length - 1);
      notifyListeners();
    }
  }
}

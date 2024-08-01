import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/base/base.vm.dart';

import '../../../../utils/snack_message.dart';

class TransactionGiftPinViewModel extends BaseViewModel {
  var pinCodeController = TextEditingController();
  late BuildContext context;
  //GetOtpResponse? previousResponse;
  String phoneNumber = "";
  String amount = "";

  int secondsRemaining = 60;
  Timer? timer;

  init({
    required BuildContext contexts,
    required String phoneNumber,
    required String amount,
  }) {
    context = contexts;
    this.phoneNumber = phoneNumber;
    this.amount = amount;
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
      var response = await repository.verifyGiftingTransactionPin(
        phoneNumber: phoneNumber,
        amount: amount,
        pin: pinCodeController.text,
      );

      if (response?.data != null) {
        await repository.getUser();
        showCustomToast("${response?.data} to $phoneNumber", success: true);
        stopLoader();
        navigationService.goBack(value: true);
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskitly/core/models/user_data.dart';

import '../../../../../utils/show-bottom-sheet.dart';
import '../../../../base/base.vm.dart';
import '../../../../widgets/email-verification-success.dart';

class EmailVerificationViewModel extends BaseViewModel {
  var pinCodeController = TextEditingController();

  onChange(String? val) {
    formKey.currentState!.validate();
    notifyListeners();
  }

  verifyEmail() async {
    startLoader();
    try {
      await repository.emailVerify();
      startTimer();
      //
      stopLoader();
    } catch (err) {
      print(err);
      stopLoader();
    }
    notifyListeners();
  }

  int secondsRemaining = 60;
  Timer? timer;

  String formatTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String formattedTime =
        DateFormat('mm:ss').format(DateTime(0, 1, 1, 0, 0, 0).add(duration));
    return formattedTime;
  }

  startTimer() {
    const oneSecond = Duration(seconds: 1);
    secondsRemaining = 60;
    timer = Timer.periodic(oneSecond, (Timer timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        notifyListeners();
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
        notifyListeners();
      }
    });
    print(secondsRemaining);
  }

  verifyOTP() async {
    startLoader();
    try {
      var response = await repository.verifyEmail(
          data: UserData(otp: pinCodeController.text.trim()));
      if (response?.status == true) {
        await repository.getUser();
        navigationService.goBack();
        showAppBottomSheet(VerificationSuccessFul(
          message: response?.message,
        ));
      }
      stopLoader();
    } catch (err) {
      print(err);
      stopLoader();
    }
    notifyListeners();
  }
}

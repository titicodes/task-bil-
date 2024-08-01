
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskitly/UI/base/base.vm.dart';
import 'package:taskitly/routes/routes.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../../../utils/string-extensions.dart';

class VerifyPhoneNumberViewModel extends BaseViewModel {
  var pinCodeController = TextEditingController();
  String pinID = "";

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

  onChange(String? val) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  goToUserLogin() {
    navigationService.navigateTo(loginScreenRoute);
  }

  getOTP() async {
    startLoader();
    try {
      var response = await repository.verifyPhone(data: appCache.userData);
      stopLoader();
      if (response?.pinId != null) {
        pinID = response?.pinId ?? "";
        await startTimer();
        showCustomToast("OTP code sent to ${appCache.phoneNumber}",
            success: true);
      }
      notifyListeners();
    } catch (err) {
      stopLoader();
      notifyListeners();
    }
  }

  verifyOTP() async {
    startLoader();
    try {
      var response = await repository.verifyPhoneOtp(
          otp: pinCodeController.text.trim(),
          pinID: pinID,
          phoneNumber:
              formatPhoneNumber(trimPhone(appCache.phoneNumber ?? "")));
      stopLoader();
      if (response?.status == true) {
        showCustomToast("Account Verified Successfully", success: true);
        if (appCache.userType == "client") {
          navigationService.navigateToAndRemoveUntil(loginScreenRoute);
        } else {
          navigationService.navigateTo(updateProviderRoute);
        }
      }
      notifyListeners();
    } catch (err) {
      stopLoader();
      notifyListeners();
    }
  }
}
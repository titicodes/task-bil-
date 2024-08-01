import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskitly/UI/base/base.vm.dart';

import '../../../../core/models/get-otp-response.dart';
import '../../../../core/models/user_data.dart';
import '../../../../utils/snack_message.dart';
import '../../../../utils/string-extensions.dart';
import '../../../home/settings-view/security/change-pin/change.pin.ui.dart';
import '../../../widgets/bottomSheet.dart';
import '../new-password/new-password-ui.dart';

class VerifyPasswordViewModel extends BaseViewModel {
  var pinCodeController = TextEditingController();
  GetOtpResponse? previousResponse;

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

  init() async {
    if (appCache.comingFromChangePin) {
      await start();
    } else {
      previousResponse = appCache.forgetPasswordResponse;
      startTimer();
    }
  }

  start() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var userData = UserData(
      phoneNumber: userService.user.phoneNumber,
    );
    startLoader();
    try {
      var response = await repository.forgetPassword(data: userData);
      stopLoader();
      if (response?.status == true) {
        appCache.forgetPasswordResponse = response ?? GetOtpResponse();
        appCache.phoneNumber = userService.user.phoneNumber;
        appCache.userData = userData;
        showCustomToast("OTP sent to ${userService.user.phoneNumber}",
            success: true);
        startTimer();
      }
    } catch (err) {
      print(err);
      stopLoader();
    }
    stopLoader();
  }

  onChange(String? val) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  verifyOTP(BuildContext context) async {
    startLoader();
    try {
      var response = appCache.comingFromChangePin
          ? await repository.verifyPhoneOtp(
              otp: pinCodeController.text.trim(),
              pinID: appCache.forgetPasswordResponse.pinId ?? "",
              phoneNumber: userService.user.phoneNumber)
          : await repository.verifyPhoneOtp(
              otp: pinCodeController.text.trim(),
              pinID: previousResponse?.pinId ?? "",
              phoneNumber: formatPhoneNumber(appCache.phoneNumber ?? ""));
      if (response?.status == true) {
        var userData = UserData(
            otp: pinCodeController.text.trim(),
            phoneNumber: appCache.comingFromChangePin
                ? userService.user.phoneNumber
                : formatPhoneNumber(trimPhone(appCache.phoneNumber ?? "")));
        appCache.userData = userData;
        stopLoader();
        showCustomToast("Otp Verified Successfully", success: true);
        appCache.comingFromChangePin
            ? navigationService
                .navigateAndReplaceWidget(const ChangePinScreen())
            : await popUps(context);
      }
      notifyListeners();
    } catch (err) {
      print(err);
      stopLoader();
      notifyListeners();
    }
  }

  popUps(BuildContext context) async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => const BottomSheetScreen(child: NewPasswordScreen()),
    );
  }

  resend() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var userData = appCache.userData;
    startLoader();
    try {
      var response = await repository.forgetPassword(data: userData);
      stopLoader();
      if (response?.status == true) {
        appCache.forgetPasswordResponse = response ?? GetOtpResponse();
        previousResponse = response;
        showCustomToast("OTP sent to ${trimPhone(userData.phoneNumber)}",
            success: true);
      }
    } catch (err) {}
  }
}

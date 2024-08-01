import 'package:flutter/material.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/core/models/get-otp-response.dart';
import 'package:taskitly/core/models/user-response.dart';
import 'package:taskitly/utils/snack_message.dart';
import 'package:taskitly/utils/string-extensions.dart';

import '../../../../../core/models/user_data.dart';
import '../../../../base/base.vm.dart';
import '../../../../widgets/bottomSheet.dart';
import '../../../../widgets/successful-pop-up.dart';

class ChangePasswordViewModel extends BaseViewModel {
  GetOtpResponse? previousResponse;
  User user = User();

  late BuildContext context;
  String? otpGotten;

  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  init() async {
    user = userService.user;
  }

  onChange(String? val) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  submit() async {
    startLoader();
    UserData data = UserData(
        oldPassword: oldPasswordController.text.trim(),
        password: newPasswordController.text.trim());
    try {
      var response = await repository.changePassword(data: data);
      if (response?.message != null) {
        await showSuccesses();
      } else {
        showCustomToast("Incorrect old password");
      }
      stopLoader();
      notifyListeners();
    } catch (err) {
      print(err);
      stopLoader();
      notifyListeners();
    }
  }

  showSuccesses() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
          child: SuccessfulPopUpWidget(
        title: "password changed successful!".toTitleCase(),
        subTitle: "your pin has been changed successfully.",
        onTap: navigationService.goBack,
      )),
    ).whenComplete(navigationService.goBack);
  }

  sendOtp() async {
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

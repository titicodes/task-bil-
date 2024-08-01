import 'package:flutter/material.dart';
import 'package:taskitly/core/models/user_data.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../../utils/string-extensions.dart';
import '../../../base/base.vm.dart';

class NewPasswordViewModel extends BaseViewModel {
  var passwordNameController = TextEditingController();
  var confirmPasswordNameController = TextEditingController();

  onChange(String? val) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  submit() async {
    var userData = UserData(
        otp: appCache.userData.otp,
        phoneNumber: formatPhoneNumber(appCache.phoneNumber ?? ""),
        password: passwordNameController.text.trim());
    startLoader();
    try {
      var response = await repository.resetPassword(data: userData);
      if (response?.status == true) {
        showCustomToast(response?.detail ?? "", success: true);
        appCache.userData = userData;
        stopLoader();
        notifyListeners();
        navigationService.goBack();
        navigationService.goBack();
        navigationService.goBack();
      } else {
        stopLoader();
        notifyListeners();
      }
    } catch (err) {
      stopLoader();
      notifyListeners();
    }
  }
}

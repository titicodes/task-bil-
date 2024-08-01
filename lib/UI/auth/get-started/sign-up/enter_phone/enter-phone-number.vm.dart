import 'package:flutter/material.dart';
import 'package:taskitly/UI/base/base.vm.dart';

import '../../../../../core/models/user_data.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/string-extensions.dart';

class EnterPhoneNumberViewModel extends BaseViewModel {
  var phoneController = TextEditingController();
  String? countryCode;
  String? country;
  String? phoneNumber;

  onChange(String? val) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    var userData = UserData(
      phoneNumber: formatPhoneNumber(trimPhone(phoneNumber)),
    );
    appCache.phoneNumber = trimPhone(phoneNumber);
    appCache.userData = userData;
    navigationService.navigateTo(verifyPhoneNumber);
  }
}

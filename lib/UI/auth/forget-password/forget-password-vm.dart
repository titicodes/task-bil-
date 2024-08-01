import 'package:flutter/material.dart';
import 'package:taskitly/UI/widgets/bottomSheet.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../core/models/get-otp-response.dart';
import '../../../core/models/user_data.dart';
import '../../../utils/string-extensions.dart';
import '../../base/base.vm.dart';
import 'verify-password/verify-password-ui.dart';

class ForgetPasswordViewModel extends BaseViewModel {
  late BuildContext context;

  init(BuildContext contexts) {
    context = contexts;
  }

  onChange(String? val) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  var phoneController = TextEditingController();
  String? countryCode;
  String? country;
  String? phoneNumber;

  submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var userData = UserData(
      phoneNumber: formatPhoneNumber(trimPhone(phoneNumber)),
    );
    startLoader();
    try {
      var response = await repository.forgetPassword(data: userData);
      stopLoader();
      if (response?.status == true) {
        appCache.forgetPasswordResponse = response ?? GetOtpResponse();
        appCache.phoneNumber = trimPhone(phoneNumber);
        appCache.userData = userData;
        appCache.comingFromChangePin = false;
        showCustomToast("OTP sent to ${trimPhone(phoneNumber)}", success: true);
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (_) =>
              const BottomSheetScreen(child: VerifyPasswordScreen()),
        );
      }
    } catch (err) {
      stopLoader();
    }
    stopLoader();
  }
}

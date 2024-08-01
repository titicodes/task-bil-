import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskitly/UI/auth/login/login-ui.dart';
import 'package:taskitly/UI/base/base.vm.dart';
import 'package:taskitly/core/models/registration-response.dart';
import 'package:taskitly/core/models/user_data.dart';
import 'package:taskitly/utils/snack_message.dart';
import 'package:taskitly/utils/string-extensions.dart';

import '../../../../routes/routes.dart';

class SignUpViewModel extends BaseViewModel {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var userNameController = TextEditingController();
  var emailNameController = TextEditingController();
  var referralNameController = TextEditingController();
  var passwordNameController = TextEditingController();
  var phoneController = TextEditingController();
  var confirmPasswordNameController = TextEditingController();
  DateTime? dateOfBirth;
  DateTime dob = DateTime.now();
  String? countryCode;
  String? country;
  String? phoneNumber;
  final formatter = DateFormat('yyyy-MM-dd');

  onChange(String? val) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  goToUserLogin() {
    navigationService.navigateTo(loginScreenRoute);
  }

  goToProviderStage2() {
    appCache.firstName = firstNameController.text.trim();
    appCache.lastName = lastNameController.text.trim();
    appCache.email = emailNameController.text.trim();
    appCache.username = userNameController.text.trim();
    appCache.referralCode = referralNameController.text.trim();
    appCache.password = passwordNameController.text.trim();
    appCache.phoneNumber = formatPhoneNumber(trimPhone(phoneNumber));
    appCache.dob = dob;
    appCache.dateOfBirth = formatter.format(dob);
    notifyListeners();
    // navigationService.navigateTo("");
  }

  submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    if (formKey.currentState!.validate()) {
      try {
        var userData = UserData(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: emailNameController.text.trim(),
            username: userNameController.text.trim(),
            referralCode: referralNameController.text.trim(),
            phoneNumber: formatPhoneNumber(trimPhone(phoneNumber)),
            password: passwordNameController.text.trim(),
            confirmPassword: confirmPasswordNameController.text.trim(),
            // dateOfBirth: formatter.format(dob),
            userType: appCache.userType);
        var response = await repository.register(data: userData);
        if (response?.failed == false) {
          appCache.phoneNumber = trimPhone(phoneNumber);
          appCache.userData = userData;
          appCache.registerResponse = response ?? RegisterResponse();
          // print(jsonEncode(appCache.registerResponse));
          showCustomToast("Registration successful, kindly verify account",
              success: true);
          stopLoader();
          notifyListeners();
          navigationService.navigateTo(verifyPhoneNumber);
        } else {
          stopLoader();
          notifyListeners();
          showCustomToast("\n${response?.token}\n");
          navigationService.navigateToWidget(const LoginScreen());
        }
      } on DioError {
        stopLoader();
        notifyListeners();
      }
    } else {
      showCustomToast("Input All fields");
    }
  }

  // submit(){
  //   FocusManager.instance.primaryFocus?.unfocus();
  //   if(appCache.userType != "client"){
  //     goToProviderStage2();
  //   }else{
  //     clientSubmit();
  //   }
  // }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    required BuildContext context,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future pickToDateTime(
      {required bool picDate, required BuildContext context}) async {
    final date = await pickDateTime(
      dob,
      pickDate: picDate,
      context: context,
    );
    if (date == null) return null;
    dob = date;
    dateOfBirth = date;
    onChange("");
    notifyListeners();
  }
}

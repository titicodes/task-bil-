import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/core/models/new_login_response.dart';
import 'package:taskitly/locator.dart';
import 'package:taskitly/routes/routes.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../core/models/user_data.dart';
import '../../../core/services/web-services/location.service.dart';
import '../../base/base.vm.dart';

class LoginViewModel extends BaseViewModel {
  var emailNameController = TextEditingController();
  var passwordController = TextEditingController();
  NewLoginResponse? loginResponse;
  bool? hasService;

  onChange(String? val) {
    formKey.currentState!.validate();
    notifyListeners();
  }

  goToUserType() {
    navigationService.navigateTo(selectUserTypeRoute);
  }

  goToForgetPassword() {
    navigationService.navigateTo(forgetPasswordRoute);
  }

  submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var userData = UserData(
          email: emailNameController.text.trim(),
          password: passwordController.text.trim());

      var response = await repository.login(data: userData);
      if (response!.verifyStatus == null) {
        showCustomToast(
            "Email or password is incorrect, please check and try again!");
      }
      await locator<LocationViewModel>().getCurrentPosition();
      if (response.verifyStatus == false) {
        stopLoader();
        notifyListeners();
        navigationService.navigateTo(enterPhoneNumberRoute);
      } else if (response.verifyStatus == true) {
        if (response.servicepro == true && response.hasService == false) {
          //await getAuthUser(true);
          navigationService.navigateTo(updateProviderRoute);
        } else if (response.servicepro == true && response.hasService == true) {
          await getServiceProviderDetails();
        } else {
          await getUser();
          //navigationService.navigateToAndRemoveUntil(homeRoute);
        }

        notifyListeners();
        stopLoader();
      }
      stopLoader();
      notifyListeners();
    } catch (err) {
      stopLoader();
      notifyListeners();
    }
  }

  getAuthUser(bool isServiceProvider) async {
    startLoader();
    try {
      var res = await repository.getUser();
      if (res?.email != null) {
        isServiceProvider
            ? navigationService.navigateTo(updateProviderRoute)
            : navigationService.navigateToAndRemoveUntil(homeRoute);
      }
    } catch (er) {
      debugPrint(er.toString());
      stopLoader();
    }
  }

  // get service details data from API
  Future<void> getServiceProviderDetails() async {
    startLoader();
    try {
      var res = await repository.getUserServiceDetail();
      if (res?.amount != null) {
        startLoader();
        navigationService.navigateToAndRemoveUntil(homeRoute);
      }
      startLoader();
    } catch (err) {
      print(err);
      startLoader();
    }
    notifyListeners();
  }

  getUser() async {
    startLoader();
    try {
      var response = await repository.getUser();
      notifyListeners();
      if (response?.uid != null) {
        await userService.initializer();
        navigationService.navigateToAndRemoveUntil(homeRoute);
      }
      stopLoader();
    } catch (err) {
      print(err);
      stopLoader();
      notifyListeners();
    }
  }
}

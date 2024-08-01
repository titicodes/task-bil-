// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:taskitly/UI/widgets/bottomSheet.dart';
// import 'package:taskitly/UI/widgets/successful-pop-up.dart';
// import 'package:taskitly/constants/reuseables.dart';
// import 'package:taskitly/core/models/get-otp-response.dart';
// import 'package:taskitly/core/models/user-response.dart';
// import 'package:taskitly/core/models/user_data.dart';
// import 'package:taskitly/routes/routes.dart';
// import 'package:taskitly/utils/snack_message.dart';
// import 'package:taskitly/utils/string-extensions.dart';

// import '../../../../base/base.vm.dart';

// class ChangePinViewModel extends BaseViewModel {
//   User user = User();
//   GetOtpResponse? previousResponse;

//   var otpTextController = TextEditingController();
//   var pinCodeController = TextEditingController();
//   var newPinController = TextEditingController();
//   var confirmNewPinController = TextEditingController();

//   String otpGotten = "";

//   init() async {
//     user = userService.user;
//     previousResponse = appCache.forgetPasswordResponse;
//     sendOtp();
//     startTimer();
//   }

//   onChange(String? val) {
//     formKey.currentState!.validate();
//     notifyListeners();
//   }

//   int secondsRemaining = 60;
//   Timer? timer;

//   String formatTime(int seconds) {
//     Duration duration = Duration(seconds: seconds);
//     String formattedTime =
//         DateFormat('mm:ss').format(DateTime(0, 1, 1, 0, 0, 0).add(duration));
//     return formattedTime;
//   }

//   startTimer() {
//     const oneSecond = Duration(seconds: 1);
//     secondsRemaining = 60;
//     timer = Timer.periodic(oneSecond, (Timer timer) {
//       if (secondsRemaining > 0) {
//         secondsRemaining--;
//         notifyListeners();
//       } else {
//         timer.cancel(); // Stop the timer when it reaches 0
//         notifyListeners();
//       }
//     });
//     print(secondsRemaining);
//   }

//   submit() async {
//     FocusManager.instance.primaryFocus?.unfocus();
//     startLoader();
//     try {
//       var response = await repository.changeTransactionPin(
//           otp: appCache.userData.otp ?? "",
//           newPin: newPinController.text.trim());
//       if (response?.status == true) {
//         showCustomToast("Pin Changed Successfully", success: true);
//         stopLoader();
//         notifyListeners();
//         await showSuccesses();
//       }
//       stopLoader();
//       notifyListeners();
//     } catch (err) {
//       print(err);
//       stopLoader();
//       notifyListeners();
//     }
//   }

//   showSuccesses() {
//     showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       context: navigationService.navigatorKey.currentState!.context,
//       isScrollControlled: true,
//       isDismissible: false,
//       builder: (_) => BottomSheetScreen(
//           child: SuccessfulPopUpWidget(
//         title: "pin changed successful!".toTitleCase(),
//         subTitle: "your pin has been changed successfully.",
//         onTap: navigationService.goBack,
//       )),
//     ).whenComplete(navigationService.goBack);
//   }

//   verifyOTP() async {
//     startLoader();
//     try {
//       var response = await repository.verifyPhoneOtp(
//           otp: pinCodeController.text.trim(), pinID: pinID);
//       if (response?.status == true) {
//         var userData =
//             UserData(otp: pinCodeController.text.trim(), password: pinID);
//         appCache.userData = userData;
//         stopLoader();
//         showCustomToast("Otp Verified Successfully", success: true);
//         navigationService.navigateTo(changePinRoute);
//       }
//       stopLoader();
//       notifyListeners();
//     } catch (err) {
//       print(err);
//       stopLoader();
//       notifyListeners();
//     }
//   }

//   String pinID = "";

//   sendOtp() async {
//     var userData = UserData(phoneNumber: userService.user.phoneNumber);
//     startLoader();
//     try {
//       var response = await repository.forgetPassword(data: userData);
//       stopLoader();
//       if (response?.status == true) {
//         pinID = response?.pinId ?? "";
//         print(pinID);
//         appCache.forgetPasswordResponse = response ?? GetOtpResponse();
//         previousResponse = response;
//         showCustomToast(
//           "OTP sent to ${userService.user.phoneNumber}",
//           success: true,
//         );
//       }
//     } catch (err) {}
//   }
// }
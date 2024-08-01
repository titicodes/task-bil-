import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../constants/reuseables.dart';
import '../../../../../utils/text_styles.dart';
import '../../../../base/base.ui.dart';
import '../../../../widgets/app_button.dart';
import 'verify-phone-vm.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  const VerifyPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyPhoneNumberViewModel>(
      onModelReady: (model) async => await model.getOTP(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBars(
          text: "verify phone number".toTitleCase(),
        ),
        body: Padding(
          padding: 16.0.padH,
          child: Form(
            key: model.formKey,
            child: ListView(
              children: [
                20.0.sbH,
                PinCodeTextField(
                  length: 5,
                  textStyle: bodyTextStyle2.copyWith(fontSize: 25),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  obscureText: false,
                  autoFocus: true,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 80,
                    fieldWidth: (width(context) - 60) / 5,
                    inactiveFillColor: Colors.transparent,
                    inactiveColor:
                        Theme.of(context).disabledColor.withOpacity(0.3),
                    selectedFillColor: Colors.transparent,
                    selectedColor: Theme.of(context).primaryColor,
                    activeColor: Colors.transparent,
                    activeFillColor:
                        Theme.of(context).iconTheme.color?.withOpacity(0.1),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  controller: model.pinCodeController,
                  enableActiveFill: true,
                  validator: (val) {
                    if (model.pinCodeController.text.trim().length != 5) {
                      return "Pin Code must be at least 5 characters";
                    } else {
                      return null;
                    }
                  },
                  onChanged: model.onChange,
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
                12.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppStrings.enterOTP,
                            style: subStyle.copyWith(fontSize: 15),
                          ),
                          TextSpan(
                            text: "${model.appCache.phoneNumber}",
                            style: subStyle.copyWith(
                                fontSize: 15, color: primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle tap here
                                print('Details tapped!');
                                // Add your navigation or other logic here
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                32.0.sbH,
                AppButton(
                  text: "Verify & Proceed",
                  onTap: model.formKey.currentState?.validate() != true
                      ? null
                      : model.verifyOTP,
                ),
                16.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppStrings.didntReceive,
                            style: subStyle.copyWith(fontSize: 15),
                          ),
                          model.timer?.isActive == true
                              ? TextSpan(
                                  text:
                                      "Wait ${model.formatTime(model.secondsRemaining)} mins",
                                  style: normalTextStyle.copyWith(fontSize: 15),
                                )
                              : TextSpan(
                                  text: "Resend OTP",
                                  style: subUnderlineGreenStyle.copyWith(
                                      fontSize: 15, color: primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = model.getOTP,
                                ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                30.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: navigationService.goBack,
                      child: AppText(
                        "Wrong phone number?",
                        style: subUnderlineGreenStyle.copyWith(fontSize: 15),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

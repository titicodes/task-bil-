import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskitly/UI/base/base.ui.dart';
import 'package:taskitly/UI/home/settings-view/security/change-pin/change.pin.vm.dart';
import 'package:taskitly/UI/home/settings-view/security/change-pin/new_change_pin_vm.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/text_styles.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../widgets/appbar.dart';

class VerifyChangePinOtpScreen extends StatelessWidget {
  const VerifyChangePinOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OtherView<ChangePinViewModel>(
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          text: "enter verification code".toTitleCase(),
        ),
        body: Container(
          color: Colors.white,
          child: Form(
            key: model.formKey,
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: 16.0.padA,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            AppStrings.enterDigits,
                            style: subStyle.copyWith(color: secondaryDarkColor),
                            align: TextAlign.center,
                          ),
                          34.0.sbH,
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
                              fieldHeight: 60,
                              fieldWidth: (width(context) - 80) / 5,
                              inactiveFillColor: Colors.transparent,
                              inactiveColor: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.3),
                              selectedFillColor: Colors.transparent,
                              selectedColor: Theme.of(context).primaryColor,
                              activeColor: Colors.transparent,
                              activeFillColor: Theme.of(context)
                                  .iconTheme
                                  .color
                                  ?.withOpacity(0.1),
                            ),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            backgroundColor: Colors.transparent,
                            controller: model.pinCodeController,
                            enableActiveFill: true,
                            validator: (val) {
                              if (model.pinCodeController.text.trim().length !=
                                  5) {
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
                                      text: AppStrings.didntReceive,
                                      style: subStyle.copyWith(fontSize: 15),
                                    ),
                                    model.resendOtpTimer?.isActive == true
                                        ? TextSpan(
                                            text:
                                                "Wait ${model.formatTime(model.resendOtpSeconds)} mins",
                                            style: normalTextStyle.copyWith(
                                                fontSize: 15),
                                          )
                                        : TextSpan(
                                            text: "Resend OTP",
                                            style:
                                                subUnderlineGreenStyle.copyWith(
                                                    fontSize: 15,
                                                    color: primaryColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = model.sendOtp,
                                          ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          32.0.sbH,
                          AppButton(
                            text: "Continue",
                            onTap:
                                model.formKey.currentState?.validate() != true
                                    ? null
                                    : model.verifyOTP,
                          ),
                          16.0.sbH,
                        ],
                      ),
                    )
                  ],
                ),
                model.isLoading ? const SmallLoader() : 0.0.sbH
              ],
            ),
          ),
        ),
      ),
    );
  }
}

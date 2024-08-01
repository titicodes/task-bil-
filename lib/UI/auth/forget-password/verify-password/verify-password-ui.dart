import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/text_styles.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import 'verify-password-vm.dart';

class VerifyPasswordScreen extends StatelessWidget {
  const VerifyPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OtherView<VerifyPasswordViewModel>(
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => Form(
        key: model.formKey,
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: navigationService.goBack,
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: secondaryColor),
                        child: const Icon(
                          Icons.clear,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: 16.0.padH,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        "enter verification code".toTitleCase(),
                        size: 20.sp,
                        weight: FontWeight.w600,
                      ),
                      5.0.sbH,
                      AppText(
                        model.appCache.comingFromChangePin
                            ? AppStrings.enterPinDigits
                            : AppStrings.enterDigits,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 60,
                          fieldWidth: (width(context) - 80) / 5,
                          inactiveFillColor: Colors.transparent,
                          inactiveColor:
                              Theme.of(context).disabledColor.withOpacity(0.3),
                          selectedFillColor: Colors.transparent,
                          selectedColor: Theme.of(context).primaryColor,
                          activeColor: Colors.transparent,
                          activeFillColor: Theme.of(context)
                              .iconTheme
                              .color
                              ?.withOpacity(0.1),
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
                                  text: AppStrings.didntReceive,
                                  style: subStyle.copyWith(fontSize: 15),
                                ),
                                model.timer?.isActive == true
                                    ? TextSpan(
                                        text:
                                            "Wait ${model.formatTime(model.secondsRemaining)} mins",
                                        style: normalTextStyle.copyWith(
                                            fontSize: 15),
                                      )
                                    : TextSpan(
                                        text: "Resend OTP",
                                        style: subUnderlineGreenStyle.copyWith(
                                            fontSize: 15, color: primaryColor),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap =
                                              model.appCache.comingFromChangePin
                                                  ? model.start
                                                  : model.resend,
                                      ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      32.0.sbH,
                      AppButton(
                        text: "Verify Code",
                        onTap: model.formKey.currentState?.validate() != true
                            ? null
                            : () => model.verifyOTP(context),
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
    );
  }
}

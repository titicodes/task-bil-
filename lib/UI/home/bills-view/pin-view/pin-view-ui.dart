import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/core/models/internet_response_model.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/text_styles.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../core/models/airtime_response_model.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/number_pad.dart';
import 'pin-view-vm.dart';

class TransactionPinScreen extends StatelessWidget {
  final String phoneNumber;
  final String amount;
  final AirTimeServiceProvider? selectedProvider;
  final Smile? selectedInternetProvider;
  final String? selectedDataName;

  const TransactionPinScreen(
      {super.key,
      required this.phoneNumber,
      required this.amount,
      this.selectedProvider,
      this.selectedDataName,
      this.selectedInternetProvider});

  @override
  Widget build(BuildContext context) {
    return PopView<TransactionPinViewModel>(
      onModelReady: (m) => m.init(
          phoneNumber: phoneNumber,
          amount: amount,
          selectedProvider: selectedProvider,
          selectedDataName: selectedDataName,
          selectedInternetProvider: selectedInternetProvider,
          contexts: context),
      builder: (_, model, child) => Form(
        key: model.formKey,
        child: SafeArea(
          child: Column(
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
                      "enter payment pin".toTitleCase(),
                      size: 20.sp,
                      weight: FontWeight.w600,
                    ),
                    5.0.sbH,
                    PinCodeTextField(
                      length: 4,
                      textStyle: bodyTextStyle2.copyWith(fontSize: 25),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      obscureText: false,
                      autoFocus: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: (width(context) - 80) / 6,
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
                        if (model.pinCodeController.text.trim().length != 4) {
                          return "";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (pin) {
                        if (pin.length == 4) {
                          // Trigger verification process

                          model.isLoading
                              ? const SmallLoader()
                              : model.verifyPin(context);
                        }
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");

                        return true;
                      },
                      appContext: context,
                    ),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: AppStrings.forgotPin,
                              style: normalTextStyle.copyWith(
                                  fontSize: 15, color: primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = model.changePin)
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    12.0.sbH,
                    // Add the NumberPad widget
                    SizedBox(
                      height: 206,
                      width: 300,
                      child: NumberPad(
                        onDigitPressed: (digit) {
                          if (digit == 'delete') {
                            model.deleteDigit();
                          } else {
                            model.appendDigit(digit);
                          }
                        },
                        onDonePressed: () {
                          // if (model.formKey.currentState?.validate() ==
                          //     true) {
                          //   model.verifyPin(context);
                          // }
                        },
                      ),
                    ),

                    // 32.0.sbH,

                    // AppButton(
                    //   text: "Pay",
                    //   onTap: model.formKey.currentState?.validate() != true
                    //       ? null
                    //       : () => model.verifyPin(context),
                    // ),
                    16.0.sbH,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

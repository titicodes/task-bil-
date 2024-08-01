import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskitly/locator.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/palette.dart';
import '../../../../constants/reuseables.dart';
import '../../../../utils/text_styles.dart';
import '../../../base/base.vm.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/number_pad.dart';

class PinInputScreen extends StatefulWidget {
  const PinInputScreen({super.key});

  @override
  State<PinInputScreen> createState() => _PinInputScreenState();
}

class _PinInputScreenState extends State<PinInputScreen> {
  var pinCodeController = TextEditingController();

  void appendDigit(String digit) {
    setState(() {
      if (pinCodeController.text.length < 4) {
        pinCodeController.text += digit;
      }
    });
  }

  void deleteDigit() {
    setState(() {
      if (pinCodeController.text.isNotEmpty) {
        pinCodeController.text = pinCodeController.text
            .substring(0, pinCodeController.text.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
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
                      color: secondaryColor
                  ),
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
                  readOnly: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: (width(context) - 80) / 6,
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
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  controller: pinCodeController,
                  enableActiveFill: true,
                  validator: (val) {
                    if (pinCodeController.text.trim().length != 4) {
                      return "";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (pin) {
                    setState(() {
                      if (pin.length == 4) {
                        setState(() {

                        });
                        navigationService.goBack(value: pin);
                      }
                    });
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
                          recognizer: TapGestureRecognizer()..onTap = locator<BaseViewModel>().changePin
                      )
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
                        deleteDigit();
                      } else {
                        appendDigit(digit);
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
    );
  }
}
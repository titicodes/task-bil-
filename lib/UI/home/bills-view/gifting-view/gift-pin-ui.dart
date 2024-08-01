import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskitly/UI/home/bills-view/gifting-view/gifting-pin-vm.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/text_styles.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../base/base.ui.dart';
import '../../../widgets/number_pad.dart';

class TransactionGiftPinScreen extends StatelessWidget {
  final String phoneNumber;
  final String amount;

  const TransactionGiftPinScreen({
    super.key,
    required this.phoneNumber,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return PopView<TransactionGiftPinViewModel>(
      onModelReady: (m) =>
          m.init(phoneNumber: phoneNumber, amount: amount, contexts: context),
      builder: (_, model, child) => Form(
        key: model.formKey,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(
                    "enter payment pin".toTitleCase(),
                    size: 20.sp,
                    weight: FontWeight.w600,
                  ),
                  15.0.sbH,
                  PinCodeTextField(
                    length: 4,
                    textStyle: bodyTextStyle2.copyWith(fontSize: 25),
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    obscureText: false,
                    autoFocus: false,
                    readOnly: true,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: (width(context) - 80) / 5,
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
                    appContext: context,
                  ),
                  InkWell(
                    onTap: model.changePin,
                    child: AppText(
                      AppStrings.forgotPin,
                      color: primaryColor,
                      size: 15.sp,
                      weight: FontWeight.w600,
                      align: TextAlign.center,
                    ),
                  ),
                  16.sp.sbH,
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
                      onDonePressed: () {},
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
            ),
            20.sp.sbH
          ],
        ),
      ),
    );
  }
}

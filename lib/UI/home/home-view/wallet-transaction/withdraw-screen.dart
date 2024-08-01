import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/palette.dart';
import '../../../../constants/reuseables.dart';
import '../../../../utils/snack_message.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/text_field.dart';
import '../trasaction-view-vm/transactions-view-model.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionViewModel>(
        onModelReady: (m) => m.init(),
        notDefaultLoading: true,
        builder: (_, model, child) {
          return SafeArea(
            child: Stack(
              children: [
                Form(
                    key: model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: 16.0.padH,
                            child: Row(
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
                          ),
                          Padding(
                            padding: 16.0.padH,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  "Withdrawal",
                                  size: 20.sp,
                                  weight: FontWeight.w600,
                                  align: TextAlign.center,
                                ),
                                16.0.sbH,
                                SvgPicture.asset(
                                  AppImages.walletImage,
                                  height: 80,
                                  width: 80,
                                ),
                                16.0.sbH,
                                Padding(
                                  padding: 16.0.padH,
                                  child: AppText(
                                    "Please enter your bank details",
                                    color: const Color(0xFF6B6B6B),
                                    size: 12.sp,
                                    align: TextAlign.center,
                                  ),
                                ),
                                20.0.sbH,
                                Row(
                                  children: [
                                    AppText(
                                      // model.provider?.name ??
                                      "Select Bank",
                                      size: 14.sp,
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                10.0.sbH,
                                IntrinsicWidth(
                                  child: AppTextField(
                                    prefix: const Icon(Icons.home),
                                    suffixIcon:
                                        const Icon(Icons.arrow_drop_down),
                                    onTap: model.showBankListBottomSheet,
                                    readonly: true,
                                    controller: model.bankNameController,
                                    hint:
                                        model.selectedBankName ?? "Select bank",
                                    validator: (val) {
                                      if (model.selectedBankName == null) {
                                        return "Select a bank to proceed!";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),

                                15.0.sbH,
                                AppTextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  hintText: "Enter Account Number",
                                  prefix:
                                      const Icon(CupertinoIcons.person_fill),
                                  hint: "Enter Account Number",
                                  onChanged: (value) async {
                                    model.onNumberChange(value);
                                    if (value.length == 10) {
                                      showCustomToast("Please wait ..",
                                          success: true);
                                      model.verifyAccountDetails();
                                    }
                                  },
                                  controller: model.accountNumberController,
                                  // onChanged: model.onChanges,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Account number is required';
                                    } else if (value.length != 10) {
                                      return 'Account number must be 10 digits';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                8.0.sbH,
                                Column(
                                  children: [
                                    AppTextField(
                                      readonly: true,
                                      hintText: "Enter Account Name",
                                      prefix: const Icon(
                                          CupertinoIcons.person_fill),
                                      hint: "Enter Account Name",
                                      controller: model.nameController,
                                      onChanged: model.onChange,
                                      validator: (value) {
                                        if (model.nameController.text
                                            .trim()
                                            .isEmpty) {
                                          return 'Account name is required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    8.0.sbH,
                                    AppTextField(
                                      hintText: "Enter Amount",
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.phone,
                                      //prefix: const Icon(CupertinoIcons.person_fill),
                                      hint: "Enter Amount",
                                      controller: model.amountController,
                                      onChanged: (value) {
                                        model.onChange(
                                            value); // Notify the ViewModel about the change
                                      },
                                      validator: (value) {
                                        if (model.amountController.text
                                            .trim()
                                            .isEmpty) {
                                          return 'Amount is required';
                                        }

                                        return null;
                                      },
                                    ),
                                    8.0.sbH,
                                    AppTextField(
                                      hintText: "Narration",
                                      prefix: const Icon(Icons.notes),
                                      hint: "Enter narration",
                                      controller: model.narrationController,
                                      onChanged: model.onChange,
                                      validator: (value) {
                                        if (model.narrationController.text
                                            .trim()
                                            .isEmpty) {
                                          return 'Narration is required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                // : 0.0.sbH,
                                8.0.sbH,
                                20.0.sbH,
                                Row(
                                  children: [
                                    Expanded(
                                        child: AppButton(
                                      text: "Continue",
                                      onTap: model.formKey.currentState
                                                  ?.validate() !=
                                              true
                                          ? null
                                          : model.confirmWithdrawalDetails,
                                      isLoading: model.isLoading,
                                      textColor: Colors.white,
                                      borderWidth: 2,
                                      backGroundColor: primaryColor,
                                    )),
                                  ],
                                ),
                                40.0.sbH,
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                model.isLoading && model.banks.isEmpty
                    ? const SmallLoader()
                    : 0.0.sbH
              ],
            ),
          );
        });
  }
}
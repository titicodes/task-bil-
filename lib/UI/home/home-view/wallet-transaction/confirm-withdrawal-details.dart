// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../home-view-vm.dart';

class ConfirmWithdrawalDetailScreen extends StatelessWidget {
  String? bankName;
  String? bankCode;
  String? accountName;
  String? accountNumber;
  String? amount;
  String? narration;
  ConfirmWithdrawalDetailScreen({
    Key? key,
    this.bankName,
    this.bankCode,
    this.accountName,
    this.accountNumber,
    this.narration,
    this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(bankCode);
    print(accountName);
    return OtherView<HomeViewViewModel>(
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
                        "Confirm Details",
                        size: 20.sp,
                        weight: FontWeight.w600,
                        align: TextAlign.center,
                      ),
                      5.0.sbH,
                      Padding(
                        padding: 16.0.padH,
                        child: AppText(
                          "please confirm your bank details",
                          color: const Color(0xFF6B6B6B),
                          size: 12.sp,
                          align: TextAlign.center,
                        ),
                      ),
                      20.0.sbH,
                      Row(
                        children: [
                          AppText(
                            "Bank Name",
                            color: const Color(0xFF6B6B6B),
                            size: 12.sp,
                            weight: FontWeight.w400,
                          ),
                          const Spacer(),
                          AppText(
                            bankName ?? "",
                            align: TextAlign.end,
                            color: const Color(0xFF6B6B6B),
                            size: 12.sp,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      10.0.sbH,
                      20.0.sbH,
                      Row(
                        children: [
                          AppText(
                            "Account Name",
                            color: const Color(0xFF6B6B6B),
                            size: 12.sp,
                            weight: FontWeight.w400,
                          ),
                          const Spacer(),
                          AppText(
                            accountName ?? "",
                            align: TextAlign.end,
                            color: const Color(0xFF6B6B6B),
                            size: 12.sp,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      10.0.sbH,
                      20.0.sbH,
                      Row(
                        children: [
                          AppText(
                            "Account Number",
                            color: const Color(0xFF6B6B6B),
                            size: 12.sp,
                            weight: FontWeight.w400,
                          ),
                          const Spacer(),
                          AppText(
                            accountNumber ?? "",
                            align: TextAlign.end,
                            color: const Color(0xFF6B6B6B),
                            size: 12.sp,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      10.0.sbH,
                      20.0.sbH,
                      Row(
                        children: [
                          AppText(
                            "Amount",
                            color: const Color(0xFF6B6B6B),
                            size: 12.sp,
                            weight: FontWeight.w400,
                          ),
                          const Spacer(),
                          AppText(
                            amount ?? "0",
                            align: TextAlign.end,
                            color: const Color(0xFF6B6B6B),
                            size: 12.sp,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      10.0.sbH,
                      32.0.sbH,
                      AppButton(
                        backGroundColor: const Color(0xFF1CBF73),
                        text: "Confirm",
                        onTap: () {
                          model.confirmTransaction(context, amount,
                              accountNumber, accountName, bankCode, narration);
                        },
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

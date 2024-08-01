import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart'; // Import BaseView
import 'package:taskitly/UI/base/base.ui.dart';
import 'package:taskitly/UI/home/home-view/trasaction-view-vm/transactions-view-model.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/routes/router.dart';
import 'package:taskitly/routes/routes.dart';
import 'package:taskitly/utils/snack_message.dart';
import 'package:taskitly/utils/validator.dart';
import 'package:taskitly/utils/widget_extensions.dart';

class NewTopUpScreen extends StatelessWidget {
  const NewTopUpScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return OtherView<TransactionViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return RefreshIndicator(
          onRefresh: () async => model.init(),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          "Top Up Wallet",
                          size: 20.sp,
                          weight: FontWeight.w600,
                          align: TextAlign.center,
                        ),
                      ],
                    ),
                    16.0.sbH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.walletImage,
                          height: 80,
                          width: 80,
                        ),
                      ],
                    ),
                    16.0.sbH,
                    Padding(
                      padding: 16.0.padH,
                      child: AppText(
                        "Money transferred to this account will be credited to your wallet",
                        color: const Color(0xFF6B6B6B),
                        size: 12.sp,
                        align: TextAlign.center,
                      ),
                    ),
                    20.0.sbH,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "Amount".toUpperCase(),
                          color: const Color(0xFF6B6B6B),
                          size: 12.sp,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            AppText(
                              currency().format(int.parse(
                                  model.fundWalletResponse?.detail?.amount ??
                                      '0')),
                              align: TextAlign.end,
                              color: const Color(0xFF6B6B6B),
                              size: 15.sp,
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                              weight: FontWeight.w700,
                            ),
                            15.0.sbW,
                            AppCard(
                              onTap: () async {
                                await Clipboard.setData(ClipboardData(
                                        text: model.fundWalletResponse?.detail
                                                ?.amount
                                                .toString() ??
                                            ""))
                                    .then((value) => showCustomToast(
                                        success: true, "Amount  Copied"));
                              },
                              expandable: true,
                              backgroundColor:
                                  const Color(0xFF43CA8B).withOpacity(0.1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              radius: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  2.0.sbW,
                                  Icon(
                                    Iconsax.copy,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  10.0.sbW,
                                  const AppText(
                                    "Copy",
                                    color: Color(0xFF43CA8B),
                                    weight: FontWeight.w500,
                                    size: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    20.0.sbH,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "Bank Name".toUpperCase(),
                          color: const Color(0xFF6B6B6B),
                          size: 12.sp,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        AppText(
                          model.fundWalletResponse?.detail?.bankName ?? "",
                          align: TextAlign.end,
                          color: const Color(0xFF6B6B6B),
                          size: 15.sp,
                          maxLine: 1,
                          overflow: TextOverflow.ellipsis,
                          weight: FontWeight.w700,
                        ),
                      ],
                    ),
                    20.0.sbH,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "Account Number".toUpperCase(),
                          color: const Color(0xFF6B6B6B),
                          size: 12.sp,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppText(
                              model.fundWalletResponse?.detail?.accountNumber ??
                                  "",
                              align: TextAlign.end,
                              color: const Color(0xFF6B6B6B),
                              size: 15.sp,
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                              weight: FontWeight.w700,
                            ),
                            15.0.sbW,
                            AppCard(
                              onTap: () async {
                                await Clipboard.setData(
                                  ClipboardData(
                                      text: model.fundWalletResponse?.detail
                                              ?.accountNumber ??
                                          ""),
                                ).then((value) => showCustomToast(
                                    success: true, "Account Number Copied"));
                              },
                              expandable: true,
                              backgroundColor:
                                  const Color(0xFF43CA8B).withOpacity(0.1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              radius: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  2.0.sbW,
                                  Icon(
                                    Iconsax.copy,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  10.0.sbW,
                                  const AppText(
                                    "Copy",
                                    color: Color(0xFF43CA8B),
                                    weight: FontWeight.w500,
                                    size: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    20.0.sbH,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "Account Name".toUpperCase(),
                          color: const Color(0xFF6B6B6B),
                          size: 12.sp,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppText(
                              model.fundWalletResponse?.detail?.beneficiary ??
                                  "",
                              align: TextAlign.end,
                              color: const Color(0xFF6B6B6B),
                              size: 15.sp,
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                              weight: FontWeight.w700,
                            ),
                            // 15.0.sbW,
                          ],
                        ),
                      ],
                    ),
                    20.0.sbH,
                    // SizedBox(
                    //   height: 100,
                    //   width: 250,
                    //   child:

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          "Transfer only from your personal account",
                          align: TextAlign.justify,
                          color: const Color(0xFF6B6B6B),
                          size: 12.sp,
                          maxLine: 1,
                          // overflow: TextOverflow.ellipsis,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          "Third Party Payment not allowed.",
                          align: TextAlign.justify,
                          color: const Color(0xFF6B6B6B),
                          size: 12.sp,
                          maxLine: 1,
                          // overflow: TextOverflow.ellipsis,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),

                    // ),
                    20.0.sbH,
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: "I have made the bank transfer",
                            onTap: () async {
                              model.topUpWallet(
                                  amount: model
                                          .fundWalletResponse?.detail?.amount ??
                                      '0',
                                  onComplete: () {
                                    navigationService
                                        .navigateTo(confrimationPageRoute);
                                    // model.accountInfo('');
                                  });
                              // navigationService.goBack();
                              //onTap();
                            },
                            textColor: Colors.white,
                            borderWidth: 2,
                            backGroundColor: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    40.0.sbH,
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

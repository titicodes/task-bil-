import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskitly/utils/snack_message.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/palette.dart';
import '../../../../constants/reuseables.dart';
import '../../../widgets/appCard.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/apptexts.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                "Top Up Wallet",
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
                  "Money sent to this account will automatically be credited to your wallet",
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
                    "Wema Bank",
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
              Row(
                children: [
                  AppText(
                    "Account Number",
                    color: const Color(0xFF6B6B6B),
                    size: 12.sp,
                    weight: FontWeight.w400,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppCard(
                        onTap: () async {
                          await Clipboard.setData(
                                  const ClipboardData(text: "8525661345"))
                              .then((value) => showCustomToast(
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
                      5.0.sbW,
                      AppText(
                        "8525661345",
                        align: TextAlign.end,
                        color: const Color(0xFF6B6B6B),
                        size: 12.sp,
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              10.0.sbH,
              Row(
                children: [
                  AppText(
                    "Account Name",
                    color: const Color(0xFF6B6B6B),
                    size: 12.sp,
                    weight: FontWeight.w400,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppCard(
                        onTap: () async {
                          await Clipboard.setData(
                                  const ClipboardData(text: "8525661345"))
                              .then((value) => showCustomToast(
                                  success: true, "Account Name Copied"));
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
                      5.0.sbW,
                      AppText(
                        "Esther Joshua Paul",
                        align: TextAlign.end,
                        color: const Color(0xFF6B6B6B),
                        size: 12.sp,
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              20.0.sbH,
              Row(
                children: [
                  Expanded(
                      child: AppButton(
                    text: "Continue",
                    onTap: () async {
                      navigationService.goBack();

                      //onTap();
                    },
                    textColor: Colors.white,
                    borderWidth: 2,
                    backGroundColor: primaryColor,
                  )),
                ],
              ),
              40.0.sbH,
            ],
          ),
        )
      ],
    );
  }
}

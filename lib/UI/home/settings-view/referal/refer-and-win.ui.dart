import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/price-widget.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/text_styles.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../base/base.ui.dart';
import 'refer-and-win.vm.dart';

class ReferAndWinHomeScreen extends StatelessWidget {
  const ReferAndWinHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ReferAndWinHomeViewModel>(
      onModelReady: (m) {
        m.context = context;
      },
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              40.0.sbW,
              AppText(
                AppStrings.refer,
                size: 20.sp,
                weight: FontWeight.w600,
              ),
              6.0.sbW,
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                    color: primaryColor, shape: const OvalBorder()),
                child: SvgPicture.asset(
                  AppImages.refer,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        body: ListView(
          padding: 16.0.padH,
          children: [
            10.0.sbH,
            AppText(
              AppStrings.useReferral,
              style: hintStyle,
              align: TextAlign.center,
            ),
            37.0.sbH,
            AppText(
              "Your referral code",
              style: hintStyle.copyWith(color: const Color(0xFF6B6B6B)),
              weight: FontWeight.w500,
            ),
            12.0.sbH,
            AppCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    model.userService.user.referalCode ?? "",
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                  GestureDetector(
                    onTap: model.copyCode,
                    child: Container(
                      width: 100,
                      height: 26,
                      padding: const EdgeInsets.all(5),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFE8F9F1),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFFE6E6E6),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Iconsax.copy5,
                            size: 16,
                            color: primaryDarkColor,
                          ),
                          AppText(
                            "Copy code",
                            weight: FontWeight.w500,
                            color: primaryColor,
                            size: 11.sp,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            27.0.sbH,
            AppCard(
              backgroundColor: Colors.white,
              borderColor: secondaryDarkColor,
              padding: 16.0.padA,
              useShadow: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PriceWidget(
                            value: 0,
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                          AppText(
                            "Referral bonus earned",
                            size: 12.sp,
                            color: hintTextColor,
                          )
                        ],
                      ),
                      ForwardButtons(
                        onTap: model.navigateToReferralHistory,
                      )
                    ],
                  ),
                  const Divider(),
                  10.0.sbH,
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Get ",
                          style: hintStyle.copyWith(fontSize: 12.sp),
                        ),
                        TextSpan(
                          text: "₦1000",
                          style: hintStyle.copyWith(
                              fontSize: 12.sp, color: primaryColor),
                        ),
                        TextSpan(
                          text:
                              " when your invited friends performs a transaction worth ",
                          style: hintStyle.copyWith(fontSize: 12.sp),
                        ),
                        TextSpan(
                          text: "₦5000",
                          style: hintStyle.copyWith(
                              fontSize: 12.sp, color: primaryColor),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                  15.0.sbH,
                  AppText(
                    "Invite to earn more",
                    color: primaryDarkColor,
                    size: 11.sp,
                    weight: FontWeight.w600,
                    align: TextAlign.start,
                  )
                ],
              ),
            ),
            25.0.sbH,
            const Divider(),
            32.0.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "Successful referrals",
                      size: 12.sp,
                      color: hintTextColor,
                    ),
                    10.0.sbH,
                    AppText(
                      "0 signed up",
                      size: 12.sp,
                      color: textColor,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                ForwardButtons(
                  onTap: model.navigateToSuccess,
                )
              ],
            ),
            60.0.sbH,
            AppButton(
              backGroundColor: primaryColor,
              onTap: () {},
              text: "Share referral link",
            )
          ],
        ),
      ),
    );
  }
}

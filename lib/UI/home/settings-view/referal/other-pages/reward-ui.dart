import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../constants/reuseables.dart';
import '../../../../../utils/text_styles.dart';
import '../../../../base/base.ui.dart';
import 'referal-detail-vm.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ReferralDetailViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Reward",
        ),
        body: ListView(
          padding: 16.0.padH,
          children: [
            AppText(
              "Earn reward points from streak and performing transactions.",
              color: hintTextColor,
              align: TextAlign.center,
            ),
            57.0.sbH,
            AppCard(
              backgroundColor: Colors.white,
              borderColor: secondaryDarkColor,
              padding: 16.0.padA,
              useShadow: true,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            "0pts",
                            size: 25.sp,
                            color: primaryColor,
                            weight: FontWeight.w600,
                          ),
                          10.0.sbH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppImages.coinPng,
                                height: 24,
                                width: 24,
                              ),
                              5.0.sbW,
                              AppText(
                                "Taskpoints earned",
                                size: 12.sp,
                                color: hintTextColor,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ],
                      ),
                      ForwardButtons(
                        onTap: model.navigateToRewardHistory,
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
                          text: "points",
                          style: hintStyle.copyWith(
                              fontSize: 12.sp, color: primaryColor),
                        ),
                        TextSpan(
                          text: " when you perform any transaction on the app.",
                          style: hintStyle.copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

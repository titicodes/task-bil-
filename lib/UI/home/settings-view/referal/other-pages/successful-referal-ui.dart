import 'package:flutter/material.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../constants/reuseables.dart';
import '../../../../base/base.ui.dart';
import 'referal-detail-vm.dart';

class SuccessfulRewardScreen extends StatelessWidget {
  const SuccessfulRewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ReferralDetailViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Successful Referrals",
        ),
        body: ListView(
          padding: 16.0.padH,
          children: [
            AppText(
              "Bonus earned from your successful referrals",
              color: hintTextColor,
              align: TextAlign.center,
            ),
            35.0.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.referFriends,
                  height: 204,
                  fit: BoxFit.fitHeight,
                ),
              ],
            ),
            50.0.sbH,
            const AppText("You have not referred anyone, yet.",
                size: 15, weight: FontWeight.w600, align: TextAlign.center),
            5.0.sbH,
            AppText(
              "Share your referral code and receive rewards.",
              size: 14,
              color: hintTextColor,
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../constants/reuseables.dart';
import '../../../../base/base.ui.dart';
import 'referal-detail-vm.dart';

class ReferralsHistoryScreen extends StatelessWidget {
  const ReferralsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ReferralDetailViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Referrals History",
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
            35.0.sbH,
            const AppText("You have not referred anyone, yet.",
                size: 15, weight: FontWeight.w600, align: TextAlign.center),
            5.0.sbH,
            AppText(
              "Share your referral code and receive rewards.",
              size: 14,
              color: hintTextColor,
              align: TextAlign.center,
            ),
            35.0.sbH,
            const AppText(
              "Your referral code",
              size: 15,
              weight: FontWeight.w600,
              align: TextAlign.center,
              color: Color(0xFF6B6B6B),
            ),
            12.0.sbH,
            AppCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    model.userService.user.referalCode ?? "",
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                  GestureDetector(
                    onTap: () => model.copyCode(context),
                    child: Container(
                      width: 88,
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
          ],
        ),
      ),
    );
  }
}

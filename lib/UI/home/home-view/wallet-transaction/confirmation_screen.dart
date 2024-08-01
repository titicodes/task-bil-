import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/routes/routes.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.transationProcessing,
                  height: 80,
                  width: 80,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                AppText(
                  "Transaction is being processed",
                  color: const Color(0xFF2B2B2B),
                  size: 20.sp,
                  weight: FontWeight.w700,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  "We’ll notify you if your transaction is \nsuccessful or fails.",
                  color: const Color(0xFF6B6B6B),
                  size: 13.sp,
                  weight: FontWeight.w400,
                  align: TextAlign.center,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Back Home",
                    onTap: () async {
                      navigationService.navigateTo(homeRoute);
                    },
                    textColor: Colors.white,
                    borderWidth: 2,
                    backGroundColor: primaryColor,
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

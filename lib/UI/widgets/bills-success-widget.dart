import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/routes/routes.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../constants/palette.dart';
import '../../constants/reuseables.dart';
import 'apptexts.dart';

class BillsSuccessfulWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? buttonText;
  final Color? titleColor;
  final bool? removeButton;
  final VoidCallback? onTap;
  const BillsSuccessfulWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.onTap,
      this.buttonText,
      this.removeButton,
      this.titleColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: InkWell(
                  onTap: () {
                    cache.initialIndex = 3;
                    navigationService.navigateToAndRemoveUntil(homeRoute);
                  },
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
                ),
              )
            ],
          ),
          Padding(
            padding: 16.0.padH,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                200.0.sbH,
                SizedBox(
                  width: 109,
                  height: 109,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 109,
                        height: 109,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFE8F9F1),
                          shape: OvalBorder(),
                        ),
                      ),
                      Container(
                        width: 91.35,
                        height: 91.35,
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF1CBF73),
                          shape: OvalBorder(),
                        ),
                        child: Icon(
                          Icons.check,
                          size: 48,
                          color: white,
                        ),
                      )
                    ],
                  ),
                ),
                24.0.sbH,
                AppText(
                  title.toTitleCase(),
                  size: 16.sp,
                  weight: FontWeight.w700,
                  color: titleColor ?? primaryColor,
                ),
                5.0.sbH,
                // Padding(
                //   padding: 22.0.padH,
                //   child: AppText(
                //     subTitle,
                //     style: subStyle.copyWith(color: secondaryDarkColor),
                //     align: TextAlign.center,
                //   ),
                // ),
                // 60.0.sbH,
                // removeButton == true
                //     ? 0.0.sbH
                //     : AppButton(
                //         text: buttonText ?? "back home".toTitleCase(),
                //         backGroundColor: primaryColor,
                //         onTap: onTap,
                //       ),
                30.0.sbH,
              ],
            ),
          )
        ],
      ),
    );
  }
}

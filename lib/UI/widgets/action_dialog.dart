import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../constants/reuseables.dart';
import 'appCard.dart';
import 'app_button.dart';
import 'apptexts.dart';

class ActionBottomSheet extends StatelessWidget {
  final String title;
  final Widget? body;
  final String? subTitle;
  final String? cancelButtonText;
  final String? doItButtonText;
  final VoidCallback? otherOnTap;
  final Widget? prefixIcon1;
  final Widget? prefixIcon2;
  final VoidCallback onTap;
  const ActionBottomSheet(
      {Key? key,
      required this.title,
      required this.onTap,
      this.subTitle,
      this.cancelButtonText,
      this.doItButtonText,
      this.prefixIcon1,
      this.prefixIcon2,
      this.otherOnTap,
      this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppCard(
                  backgroundColor: Colors.white,
                  margin: 16.0.padA,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title,
                        size: 20.sp,
                        weight: FontWeight.w600,
                      ),
                      16.0.sbH,
                      AppText(
                        subTitle ??
                            "Are you sure you want to ${title.toLowerCase()}?",
                        color: const Color(0xFF6B6B6B),
                        size: 14.sp,
                      ),
                      40.0.sbH,
                      body ??
                          Row(
                            children: [
                              Expanded(
                                  child: AppButton(
                                isTransparent: true,
                                borderColor: Colors.red,
                                text: cancelButtonText ?? "No",
                                textColor: Colors.red,
                                onTap: otherOnTap ?? navigationService.goBack,
                              )),
                              29.0.sbW,
                              Expanded(
                                  child: AppButton(
                                text: doItButtonText ?? "Yes",
                                onTap: () async {
                                  navigationService.goBack();
                                  onTap();
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

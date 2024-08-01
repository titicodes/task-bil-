import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../constants/palette.dart';
import '../../constants/reuseables.dart';

class VerificationSuccessFul extends StatelessWidget {
  final String? message;
  const VerificationSuccessFul({super.key, this.message});

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
        20.0.sbH,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80.sp,
              width: 80.sp,
              decoration: ShapeDecoration(
                  color: const Color(0xFFFEE6DA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(81.63),
                  ),
                  image: const DecorationImage(
                      image: AssetImage(
                        AppImages.envelops,
                      ),
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.fitWidth)),
            )
          ],
        ),
        20.0.sbH,
        message != null
            ? AppText(message ?? "",
                style: const TextStyle(
                  color: Color(0xFF212936),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ))
            : const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'We’ve sent a link to your email, kindly check and click on it to verify your ',
                      style: TextStyle(
                        color: Color(0xFF212936),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'Email',
                      style: TextStyle(
                        color: Color(0xFF212936),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: ', if you don’t receive the link within ',
                      style: TextStyle(
                        color: Color(0xFF212936),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: '10mins',
                      style: TextStyle(
                        color: Color(0xFF212936),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: ' come back to make another request',
                      style: TextStyle(
                        color: Color(0xFF212936),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
        20.0.sbH,
      ],
    );
  }
}

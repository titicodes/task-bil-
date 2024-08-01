import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/constants/reuseables.dart';

import '../constants/palette.dart';

TextStyle normalTextStyle = TextStyle(
  fontSize: AppFontSizes.bodyNormalSize14,
  fontFamily: 'Inter',
  color: textColor,
  fontWeight: FontWeight.normal,
);

TextStyle hintStyle = TextStyle(
  color: hintTextColor,
  fontSize: AppFontSizes.bodyNormalSize14,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);

TextStyle subStyle = TextStyle(
  color: textColor,
  fontSize: AppFontSizes.bodySmallSize12,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);

TextStyle subUnderlineGreenStyle = TextStyle(
  color: primaryColor,
  fontSize: AppFontSizes.bodySmallSize12,
  fontFamily: 'Inter',
  decoration: TextDecoration.underline,
  fontWeight: FontWeight.w400,
);

TextStyle bodyTextStyle = TextStyle(
  fontSize: AppFontSizes.bodyNormalSize14,
  fontFamily: 'Inter',
  color: textColor,
  fontWeight: FontWeight.normal,
);

TextStyle subBodyTextStyle = TextStyle(
  fontSize: AppFontSizes.titleNormalSize15,
  fontFamily: 'Inter',
  color: textColor,
  fontWeight: FontWeight.normal,
);

TextStyle bodyTextStyle2 = TextStyle(
  color: textColor,
  fontSize: AppFontSizes.titleNormalSize15,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w500,
);

TextStyle headerTextStyle = TextStyle(
  fontFamily: 'Inter',
  fontSize: 20.sp,
  color: textColor,
  fontWeight: FontWeight.bold,
);

TextStyle subHeaderTextStyle = TextStyle(
  fontFamily: 'Inter',
  fontSize: AppFontSizes.appBarFontSize20,
  color: textColor,
  fontWeight: FontWeight.w600,
);

TextStyle bodyLarge = TextStyle(
  color: const Color(0X87616161),
  fontSize: 16.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);

TextStyle bodyMedium = TextStyle(
  color: const Color(0XFF6B6B6B),
  fontSize: 14.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);
TextStyle bodySmall = TextStyle(
  color: const Color(0XFF6B6B6B),
  fontSize: 11.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);
TextStyle headlineSmall = TextStyle(
  color: const Color(0X992B2B2B).withOpacity(1),
  fontSize: 24.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);
TextStyle labelLarge = TextStyle(
  color: const Color(0XFF000000),
  fontSize: 13.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w500,
);
TextStyle labelMedium = TextStyle(
  color: const Color(0XA21CBF73).withOpacity(1),
  fontSize: 11.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w500,
);
TextStyle labelSmall = TextStyle(
  color: const Color(0XFFFFFFFF),
  fontSize: 8.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w500,
);
TextStyle titleLarge = TextStyle(
  color: const Color(0XFF000000),
  fontSize: 20.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);
TextStyle titleMedium = TextStyle(
  color: const Color(0XFFFFFFFF),
  fontSize: 16.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);
TextStyle titleSmall = TextStyle(
  color: const Color(0XFF6B6B6B),
  fontSize: 14.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

import 'package:flutter/material.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import 'apptexts.dart';

class PriceWidget extends StatelessWidget {
  final dynamic value;
  final double? fontSize;
  final Color? color;
  final String? family;
  final bool? roundUp;
  final bool? isBold;
  final FontWeight? fontWeight;
  const PriceWidget(
      {super.key,
      this.value,
      this.fontSize,
      this.color,
      this.roundUp,
      this.family,
      this.isBold,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // SvgPicture.asset(
        //   AppImages.naira,
        //   height: fontSize!=null? (fontSize!<17? fontSize: (fontSize!-6)):(16-4),
        //   width: fontSize!=null?(fontSize!-6):(16-4),
        //   color: color?? Colors.white,
        // ),
        AppText(
          "₦",
          size: fontSize,
          color: color,
          family: family,
          isBold: isBold,
          weight: fontWeight,
        ),
        3.0.sbW,
        AppText(
          value == null
              ? "0.00"
              : roundUp == true
                  ? (double.tryParse(value.toStringAsFixed(2)) ?? 0.00)
                      .floor()
                      .toString()
                  : (double.tryParse(value.toStringAsFixed(2)) ?? 0.00)
                      .toStringAsFixed(2),
          size: fontSize,
          color: color,
          family: family,
          isBold: isBold,
          weight: fontWeight,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/palette.dart';
import '../../utils/widget_extensions.dart';
import 'apptexts.dart';

class SettingCard extends StatelessWidget {
  final VoidCallback onTap;
  final bool? isLogout;
  final Widget? trailing;
  final Widget? leading;
  final String? icon;
  final String text;
  const SettingCard({
    super.key,
    required this.onTap,
    this.isLogout,
    this.icon,
    required this.text,
    this.trailing,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width(context),
          height: 50,
          padding: 12.0.padH,
          margin: 6.0.padV,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  leading ??
                      Container(
                        height: 30,
                        width: 30,
                        padding: 7.0.padA,
                        decoration: ShapeDecoration(
                          color: isLogout == true
                              ? const Color(0xFFEF4444).withOpacity(0.1)
                              : primaryColor.withOpacity(0.1),
                          shape: const OvalBorder(),
                        ),
                        child: SvgPicture.asset(
                          icon ?? "",
                          color: isLogout == true
                              ? const Color(0xFFEF4444)
                              : primaryColor,
                        ),
                      ),
                  16.0.sbW,
                  AppText(
                    text,
                    weight: FontWeight.w500,
                    color: isLogout == true ? const Color(0xFFEF4444) : null,
                  )
                ],
              ),
              trailing ??
                  (isLogout == true
                      ? 0.0.sbW
                      : const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          weight: 0.5,
                        ))
            ],
          ),
        ),
      ),
    );
  }
}

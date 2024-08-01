import 'package:flutter/material.dart';

import '../../constants/palette.dart';
import '../../utils/widget_extensions.dart';
import 'apptexts.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool? isTransparent;
  final bool? isGradient;
  final bool? noHeight;
  final double? borderWidth;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? textSize;
  final Color? borderColor;
  final Color? backGroundColor;
  final Color? textColor;
  final String? text;
  final List<Color>? gradientColors;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final bool? isLoading;
  final bool isExpanded;

  const AppButton(
      {Key? key,
      this.onTap,
      this.isTransparent,
      this.isGradient,
      this.isLoading,
      this.gradientColors,
      this.child,
      this.width,
      this.borderWidth,
      this.borderColor,
      this.textColor,
      this.backGroundColor,
      this.text,
      this.borderRadius,
      this.padding,
      this.height,
      this.textSize,
      this.isExpanded = true,
      this.noHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isExpanded ? Expanded(child: buttonBuild()) : buttonBuild(),
      ],
    );
  }

  Material buttonBuild() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading == true ? null : onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
        child: Container(
          height: noHeight == true ? null : height ?? 52,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 5),
            gradient: isGradient == true
                ? LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: gradientColors ??
                        (onTap == null || isLoading == true
                            ? [
                                primaryColor.withOpacity(0.5),
                                primaryDarkColor.withOpacity(0.5)
                              ]
                            : [primaryColor, primaryDarkColor]))
                : null,
            border: Border.all(
                width: borderWidth ?? (isTransparent == true ? 1 : 0),
                color: borderColor ??
                    (isTransparent == true
                        ? textColor ??
                            (onTap == null || isLoading == true
                                ? primaryColor.withOpacity(0.5)
                                : primaryColor)
                        : Colors.transparent)),
            color: isGradient == true
                ? null
                : isTransparent == true
                    ? Colors.transparent
                    : backGroundColor != null
                        ? (onTap == null || isLoading == true
                            ? backGroundColor!.withOpacity(0.5)
                            : backGroundColor)
                        : (onTap == null || isLoading == true
                            ? primaryDarkColor.withOpacity(0.5)
                            : primaryDarkColor),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Padding(
                  padding: padding ??
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      child ??
                          AppText(
                            text ?? "",
                            family: 'Inter',
                            isBold: true,
                            color: textColor ??
                                (isTransparent == true
                                    ? (onTap == null || isLoading == true
                                        ? textColor?.withOpacity(0.5)
                                        : textColor)
                                    : white),
                            align: TextAlign.center,
                            size: textSize,
                          ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryBtn extends StatelessWidget {
  PrimaryBtn({
    Key? key,
    this.color,
    this.textColor,
    this.widths,
    this.borderWidth,
    this.height,
    this.textSize,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.borderColor,
    required this.title,
    this.onPress,
  }) : super(key: key);

  Color? color;
  Color? borderColor;
  double? height;
  double? widths;
  Widget? prefixIcon;
  double? borderWidth;
  double? textSize;
  Widget? suffixIcon;
  Widget? label;
  Color? textColor;
  final String title;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPress,
        child: Container(
          height: height ?? 60,
          width: widths ?? width(context),
          decoration: BoxDecoration(
            color: color ??
                (onPress == null
                    ? primaryColor.withOpacity(0.3)
                    : primaryColor),
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(width: borderWidth ?? 1, color: borderColor ?? grey),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                prefixIcon == null ? 0.0.sbW : 16.0.sbW,
                prefixIcon == null
                    ? (suffixIcon == null ? 0.0.sbW : 30.0.sbW)
                    : SizedBox(
                        height: 30,
                        width: 30,
                        child: prefixIcon,
                      ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    label ??
                        AppText(
                          title,
                          size: textSize ?? 15,
                          weight: FontWeight.w700,
                          color: textColor ?? whiteColor,
                        )
                  ],
                )),
                suffixIcon == null
                    ? (prefixIcon == null ? 0.0.sbW : 30.0.sbW)
                    : SizedBox(
                        height: 30,
                        width: 30,
                        child: suffixIcon,
                      ),
                suffixIcon == null ? 0.0.sbW : 16.0.sbW,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const MyCustomAppBar({super.key, required this.onTap});
//
//   //Todo: I used chatGPT in generating this part of the code please verify it's best practice
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leadingWidth: 65.w,
//       leading: Padding(
//         padding: EdgeInsets.only(left: 16.w),
//         child: MyBackButton(
//           color: white,
//           iconColor: black,
//           borderColor: primaryColor,
//           borderWidth: 2,
//           onTap: onTap,
//         ),
//       ),
//     );
//   }
// }

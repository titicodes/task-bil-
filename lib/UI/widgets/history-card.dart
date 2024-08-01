import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants/palette.dart';
import '../../utils/widget_extensions.dart';
import 'appCard.dart';
import 'apptexts.dart';

class TransactionHistoryCard extends StatelessWidget {
  final VoidCallback onTap;
  final bool? isLogout;
  final Widget? trailing;
  final Widget? leading;
  final Widget? icon;
  final String text;
  final String status;
  final String dateText;
  final String? amountText;
  const TransactionHistoryCard({
    super.key,
    required this.onTap,
    this.isLogout,
    this.icon,
    required this.text,
    required this.status,
    this.trailing,
    this.leading,
    required this.dateText,
    this.amountText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width(context),
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
                          height: 40,
                          width: 40,
                          padding: 7.0.padA,
                          decoration: ShapeDecoration(
                            color: isLogout == true
                                ? const Color(0xFFEF4444).withOpacity(0.1)
                                : primaryColor.withOpacity(0.1),
                            shape: const OvalBorder(),
                          ),
                          child: icon,
                        ),
                    16.0.sbW,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text,
                          size: 14,
                          isBold: true,
                          color: hintTextColor,
                          weight: FontWeight.w500,
                          // color:
                          //     isLogout == true ? const Color(0xFFEF4444) : null,
                        ),
                        AppText(
                          dateText,
                          size: 11,
                          isBold: true,
                          color: hintTextColor,
                          weight: FontWeight.w500,
                          // color:
                          //     isLogout == true ? const Color(0xFFEF4444) : null,
                        ),
                      ],
                    )
                  ],
                ),
                trailing ??
                    (isLogout == true
                        ? 0.0.sbW
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                AppText(
                                  amountText ?? "",
                                  size: 14,
                                  isBold: true,
                                  color: hintTextColor,
                                  weight: FontWeight.w500,
                                  // color: isLogout == true
                                  //     ? const Color(0xFFEF4444)
                                  //     : null,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppCard(
                                      onTap: () async {
                                        // await Clipboard.setData(
                                        //         ClipboardData(text: "8525661345"))
                                        //     .then((value) => showCustomToast(
                                        //         success: true, "Account Name Copied"));
                                      },
                                      expandable: true,
                                      backgroundColor: const Color(0xFF43CA8B)
                                          .withOpacity(0.1),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      radius: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          2.0.sbW,
                                          Icon(
                                            Iconsax.copy,
                                            color: primaryColor,
                                            size: 16,
                                          ),
                                          5.0.sbW,
                                          AppText(
                                            status,
                                            color: const Color(0xFF43CA8B),
                                            weight: FontWeight.w500,
                                            size: 10,
                                          ),
                                          5.0.sbW,
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ]))
              ]),
        ),
      ),
    );
  }
}

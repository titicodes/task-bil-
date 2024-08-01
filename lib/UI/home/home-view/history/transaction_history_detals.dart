import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';
import '../../../../constants/reuseables.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/apptexts.dart';

class TransactionHistoryDetailsScreen extends StatelessWidget {
  const TransactionHistoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBars(
        text: "Transactions Details",
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: 16.0.padA,
        children: [
          10.0.sbH,
          AppCard(
            backgroundColor: Colors.white,
            borderColor: secondaryDarkColor,
            padding: 10.0.padH,
            useShadow: true,
            child: Column(
              children: [
                20.0.sbH,
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: 7.0.padA,
                          decoration: ShapeDecoration(
                            color: primaryColor.withOpacity(0.1),
                            shape: const OvalBorder(),
                          ),
                          child: SvgPicture.asset(
                            "",
                            color: primaryColor,
                          ),
                        ),
                        16.0.sbW,
                        AppText(
                          "Service",
                          size: 14,
                          isBold: true,
                          color: hintTextColor,
                          weight: FontWeight.w500,
                        )
                      ],
                    ),
                    const Spacer(),
                    AppText(
                      "-₦2,000.00",
                      size: 14,
                      isBold: true,
                      color: primaryColor,
                      weight: FontWeight.w500,
                    ),
                    6.0.sbW,
                  ],
                ),
                20.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      "Voucher",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w500,
                    ),
                    const Spacer(),
                    AppText(
                      "₦0.00",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w100,
                    )
                  ],
                ),
                20.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      "Bonus Amount",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w500,
                    ),
                    const Spacer(),
                    AppText(
                      "₦0.00",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w500,
                    )
                  ],
                ),
                30.0.sbH,
                const Divider(),
                30.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      "Status",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w100,
                    ),
                    const Spacer(),
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
                          backgroundColor:
                              const Color(0xFF43CA8B).withOpacity(0.1),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          radius: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              2.0.sbW,
                              Icon(
                                Iconsax.copy,
                                color: primaryColor,
                                size: 16,
                              ),
                              5.0.sbW,
                              const AppText(
                                "Successful",
                                color: Color(0xFF43CA8B),
                                weight: FontWeight.w500,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                20.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      "Operator",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w100,
                    ),
                    const Spacer(),
                    AppText(
                      "Sporty",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w500,
                    )
                  ],
                ),
                20.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      "Phone Number",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w100,
                    ),
                    const Spacer(),
                    AppText(
                      "081 553 4456",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w500,
                    )
                  ],
                ),
                20.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      "Provider",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w100,
                    ),
                    const Spacer(),
                    AppText(
                      "Taskify",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w500,
                    )
                  ],
                ),
                20.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      "Paid with",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w100,
                    ),
                    const Spacer(),
                    AppText(
                      "Wallet",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w500,
                    )
                  ],
                ),
                50.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      "Transaction number",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w100,
                    ),
                    const Spacer(),
                    AppText(
                      "2310051332216683118",
                      size: 14,
                      isBold: true,
                      color: hintTextColor,
                      weight: FontWeight.w500,
                    )
                  ],
                ),
              ],
            ),
          ),
          16.0.sbH,
          20.0.sbH,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.chat_bubble_text,
                  size: 24,
                  color: primaryColor,
                ),
                10.0.sbW,
                AppText(
                  "Need help? Chat with support",
                  color: primaryColor,
                  size: 14.sp,
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: AppButton(
                text: "Share Receipt",
                onTap: () async {
                  navigationService.goBack();
                },
                textColor: Colors.white,
                borderWidth: 2,
                backGroundColor: primaryColor,
              )),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../constants/palette.dart';
import 'appCard.dart';
import 'app_button.dart';
import 'apptexts.dart';
import 'price-widget.dart';

class RequestCard extends StatelessWidget {
  final String status;
  final String serviceType;
  final String serviceImage;
  final String date;
  final String time;
  final bool haveButtons;
  final bool valid;
  final bool isServiceProvider;
  final String amount;
  final String customerProviderName;
  final String customerProviderPic;
  final String? orderNumber;
  final String? orderID;
  final String? location;
  final String? useButton;
  final VoidCallback? cancel;
  final VoidCallback? start;
  final VoidCallback? done;
  final VoidCallback? report;
  final VoidCallback? confirm;
  final VoidCallback? review;
  final VoidCallback? accept;
  const RequestCard(
      {super.key,
      required this.status,
      required this.serviceType,
      required this.serviceImage,
      required this.date,
      this.haveButtons = false,
      required this.amount,
      required this.customerProviderName,
      required this.customerProviderPic,
      this.orderNumber,
      this.location,
      required this.isServiceProvider,
      this.orderID,
      required this.time,
      this.cancel,
      this.start,
      this.done,
      this.report,
      this.confirm,
      this.useButton,
      this.accept,
      required this.valid,
      this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
      margin: 8.0.padV,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.50,
          color: const Color(0xFF1CBF73),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: status.toLowerCase() == "ongoing"
                      ? primaryColor.withOpacity(0.1)
                      : status.toLowerCase() == "cancelled"
                          ? errorColor.withOpacity(0.1)
                          : secondaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: AppText(
                  status,
                  size: 11.sp,
                  color: status.toLowerCase() == "ongoing"
                      ? primaryColor
                      : status.toLowerCase() == "cancelled"
                          ? errorColor
                          : Colors.black,
                  weight: FontWeight.w600,
                ),
              ),
              orderNumber == null
                  ? 0.0.sbH
                  : AppText(
                      "#$orderNumber",
                      weight: FontWeight.w500,
                    ),
            ],
          ),
          12.0.sbH,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText("Service type: $serviceType"),
              10.0.sbW,
              // Container(
              //   height: 24, width: 24,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: CachedNetworkImageProvider(serviceImage)
              //       )
              //   ),
              // )
            ],
          ),
          5.0.sbH,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                  "${isServiceProvider ? "Customer Name: " : "Service Provider: "}$customerProviderName"),
              10.0.sbW,
              Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(customerProviderPic),
                        fit: BoxFit.fill)),
              )
            ],
          ),
          9.0.sbH,
          AppCard(
            margin: 0.0.padA,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      status.toLowerCase() == "completed"
                          ? "Date & Time"
                          : "Date",
                      size: 12.sp,
                      color: const Color(0xFF6B6B6B),
                      weight: FontWeight.w500,
                    ),
                    AppText(
                      status.toLowerCase() == "completed"
                          ? "$date at $time"
                          : date,
                      size: 12.sp,
                      color: const Color(0xFF6B6B6B),
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
                8.0.sbH,
                Container(
                  height: 1,
                  color: Colors.black.withOpacity(0.07999999821186066),
                ),
                8.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      isServiceProvider
                          ? "Service Amount"
                          : status.toLowerCase() == "completed"
                              ? "Amount paid"
                              : "Amount to pay",
                      size: 12.sp,
                      color: const Color(0xFF6B6B6B),
                      weight: FontWeight.w500,
                    ),
                    // AppText(date, size: 12.sp, color: const Color(0xFF6B6B6B), weight: FontWeight.w600,),
                    PriceWidget(
                      value: double.tryParse(amount) ?? 0.0,
                      fontSize: 12.sp,
                      color: const Color(0xFF6B6B6B),
                      fontWeight: FontWeight.w600,
                      roundUp: true,
                    )
                  ],
                ),
                location == null
                    ? 0.0.sbH
                    : Column(
                        children: [
                          16.0.sbH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText(
                                "Location",
                                size: 12.sp,
                                color: const Color(0xFF6B6B6B),
                                weight: FontWeight.w500,
                              ),
                              Expanded(
                                  child: AppText(
                                location ?? "",
                                size: 12.sp,
                                color: const Color(0xFF6B6B6B),
                                weight: FontWeight.w600,
                                align: TextAlign.end,
                              )),
                            ],
                          ),
                        ],
                      ),
                orderID == null
                    ? 0.0.sbH
                    : Column(
                        children: [
                          16.0.sbH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText(
                                "Order ID",
                                size: 12.sp,
                                color: const Color(0xFF6B6B6B),
                                weight: FontWeight.w500,
                              ),
                              Expanded(
                                  child: AppText(
                                orderID ?? "",
                                size: 12.sp,
                                color: const Color(0xFF6B6B6B),
                                weight: FontWeight.w600,
                                align: TextAlign.end,
                              )),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          ),
          status.toLowerCase() == "cancelled"
              ? Column(
                  children: [
                    17.0.sbH,
                    Row(
                      children: [
                        AppButton(
                          isExpanded: false,
                          backGroundColor: errorColor,
                          text: "Report",
                          padding: 10.0.padH,
                          onTap: report,
                          height: 34,
                        ),
                      ],
                    ),
                  ],
                )
              : status == "completed" && !isServiceProvider
                  ? Column(
                      children: [
                        17.0.sbH,
                        Row(
                          children: [
                            AppButton(
                              isExpanded: false,
                              backGroundColor: primaryColor,
                              text: "Review",
                              padding: 10.0.padH,
                              onTap: review,
                              height: 34,
                            ),
                          ],
                        ),
                      ],
                    )
                  : haveButtons
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            17.0.sbH,
                            isServiceProvider
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppButton(
                                            isExpanded: false,
                                            backGroundColor: primaryColor,
                                            // text: useButton?.toLowerCase()=="start"? "Start": useButton?.toLowerCase()=="report"? "Report": "Done",
                                            text: status == 'ongoing'
                                                ? "Done"
                                                : status == 'active' && !valid
                                                    ? "Pending"
                                                    : "Report",
                                            padding: 10.0.padH,
                                            onTap: status == 'ongoing'
                                                ? done
                                                : status == 'active' && !valid
                                                    ? null
                                                    : report,
                                            // onTap: useButton?.toLowerCase()=="start"? start: useButton?.toLowerCase()=="report"? report: done,
                                            height: 34,
                                          ),
                                          17.0.sbW,
                                          AppButton(
                                            isExpanded: false,
                                            padding: 10.0.padH,
                                            backGroundColor:
                                                const Color(0xFFEF4444),
                                            text: "Cancel",
                                            onTap: cancel,
                                            height: 34,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      AppButton(
                                        isExpanded: false,
                                        backGroundColor: primaryColor,
                                        text: status.toLowerCase() ==
                                                    "active" &&
                                                !valid
                                            ? "Accept"
                                            : status.toLowerCase() == "ongoing"
                                                ? "Pending"
                                                : "Confirm",
                                        padding: 10.0.padH,
                                        onTap: status.toLowerCase() ==
                                                    "active" &&
                                                !valid
                                            ? accept
                                            : status.toLowerCase() == "ongoing"
                                                ? null
                                                : confirm,
                                        height: 34,
                                      ),
                                      17.0.sbW,
                                      AppButton(
                                        isExpanded: false,
                                        padding: 10.0.padH,
                                        backGroundColor:
                                            const Color(0xFFEF4444),
                                        text:
                                            status.toLowerCase() == "active" &&
                                                    !valid
                                                ? "Cancel"
                                                : "Report",
                                        onTap:
                                            status.toLowerCase() == "active" &&
                                                    !valid
                                                ? cancel
                                                : report,
                                        height: 34,
                                      ),
                                    ],
                                  )
                          ],
                        )
                      : 0.0.sbH
        ],
      ),
    );
  }
}

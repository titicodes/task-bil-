import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';
import '../../../../constants/reuseables.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_field.dart';
import 'television-view-vm.dart';

class TelevisionViewScreen extends StatelessWidget {
  const TelevisionViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TelevisionBillViewViewModel>(
      onModelReady: (model) async => model.init(context),
      builder: (_, model, child) => RefreshIndicator(
        onRefresh: () async => model.init(context),
        child: Scaffold(
            appBar: AppBars(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Tv"),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            model.history();
                          },
                          child: AppText(
                            "History",
                            size: 15.sp,
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              elevation: 1,
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(children: [
                AppCard(
                  bordered: true,
                  borderWidth: 0.5.sp,
                  borderColor: textColor.withOpacity(0.2),
                  margin: 15.0.padA,
                  padding: 15.0.padA,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Service Provider",
                        size: 12.sp,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                        maxLine: 1,
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: TextButton(
                                onPressed: model.showTvProvidersBottomSheet,
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    // Add border color if needed
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 0.73.sw,
                                      child: AppText(
                                        model.provider?.name ??
                                            "Select Service Provider",
                                        size: 14.sp,
                                        overflow: TextOverflow.ellipsis,
                                        maxLine: 1,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AppCard(
                  margin: 15.0.padA,
                  padding: 15.0.padA,
                  backgroundColor: secondaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppText(
                            "Smart Card Number",
                            size: 14.sp,
                            overflow: TextOverflow.ellipsis,
                            maxLine: 1,
                          ),
                          const Spacer(),
                          AppText(
                            "",
                            size: 12.sp,
                            overflow: TextOverflow.ellipsis,
                            maxLine: 1,
                          ),
                        ],
                      ),
                      7.0.sbH,
                      AppTextField(
                          boxWidth: 320.w,
                          hint: "Enter Smart Card number",
                          fillColor: Colors.white,
                          suffixIcon: model.isNameVisible
                              ? AppCard(
                                  widths: 170.w,
                                  // heights: 10.h,
                                  expandable: false,
                                  backgroundColor:
                                      const Color(0xFF43CA8B).withOpacity(0.1),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  radius: 20,
                                  borderColor: primaryColor,
                                  bordered: true,
                                  borderWidth: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: AppText(
                                          align: TextAlign.center,
                                          model.customerName ?? "",
                                          color: const Color(0xFF43CA8B),
                                          weight: FontWeight.w700,
                                          size: 10,
                                          overflow: TextOverflow.clip,
                                          maxLine: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : 0.0.sbW,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(13)
                          ],
                          textSize: 13.sp,
                          keyboardType: TextInputType.phone,
                          controller: model.phoneNumberController,
                          onChanged: (val) async {
                            if (val.length == 13) {
                              await model.fetchCustomerEnquiry();
                              model.isNameVisible = true;
                            }
                            model.onChange;
                          }),
                      30.sp.sbH,
                      AppText(
                        "Payment period",
                        size: 12.sp,
                      ),
                      10.sp.sbH,
                      Row(
                        children: [
                          AppCard(
                            heights: 41.h,
                            expandable: true,
                            backgroundColor:
                                const Color(0xFF43CA8B).withOpacity(0.1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            radius: 5,
                            borderColor: primaryColor,
                            bordered: true,
                            borderWidth: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AppText(
                                  "${model.convertToDays(model.typeProvider?.name)} Days",
                                  color: const Color(0xFF43CA8B),
                                  weight: FontWeight.w700,
                                  size: 10,
                                ),
                                3.0.sbW,
                                Icon(
                                  Icons.verified_rounded,
                                  size: 16.sp,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      30.sp.sbH,
                      AppText(
                        "Package",
                        size: 12.sp,
                      ),
                      10.sp.sbH,
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.sp)),
                        child: Visibility(
                          visible: model.isProviderSelected,
                          child: TextButton(
                            onPressed: model.showTVTypeProvidersBottomSheet,
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                // Add border color if needed
                              ),
                            ),
                            child: Row(
                              children: [
                                AppText(
                                  model.typeProvider?.name ??
                                      "Choose a Package",
                                  size: 14.sp,
                                  color: model.typeProvider?.name == null
                                      ? hintTextColor
                                      : textColor,
                                  weight: model.typeProvider?.name == null
                                      ? null
                                      : FontWeight.w700,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: 16.0.padH,
                  child: Row(
                    children: [
                      10.0.sbW,
                      AppText(
                        "Save Beneficiary",
                        isBold: true,
                        size: 13.sp,
                        weight: FontWeight.w500,
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: true,
                          onChanged: (newValue) {},
                        ),
                      ),
                    ],
                  ),
                ),
                40.sp.sbH,
                Padding(
                  padding: 30.0.padH,
                  child: AppButton(
                    onTap: model.provider == null ||
                            model.typeProvider == null ||
                            model.phoneNumberController.text.isEmpty
                        ? null
                        : model.payTelevision,
                    isExpanded: true,
                    backGroundColor: const Color(0xFF1CBF73),
                    height: 45,
                    child: Padding(
                      padding: 5.0.padH,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppImages.coins,
                            height: 16,
                            width: 16,
                          ),
                          5.0.sbW,
                          AppText(
                            "Pay ${model.typeProvider?.amount ?? ""}",
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                40.sp.sbH,
              ]),
            ))),
      ),
    );
  }
}

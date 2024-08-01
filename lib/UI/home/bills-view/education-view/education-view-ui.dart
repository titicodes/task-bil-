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
import 'education-view-vm.dart';

class EducationViewScreen extends StatelessWidget {
  const EducationViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<EducationBillViewViewModel>(
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
                        const Text("Education"),
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
                //  30.0.sbH,
                AppCard(
                  onTap: () {},
                  margin: 15.0.padA,
                  padding: 15.0.padA,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "  Service Provider",
                        size: 12.sp,
                        overflow: TextOverflow.ellipsis,
                        maxLine: 1,
                      ),
                      IntrinsicWidth(
                        stepWidth: 350.0.w,
                        child: TextButton(
                          onPressed: null,
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
                                width: 100,
                                child: AppText(
                                  model.educationResponseModel?.data?.name ??
                                      "Select Service ",
                                  size: 14.sp,
                                  weight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                  maxLine: 1,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.0.sbH,
                        AppTextField(
                          hintText: "Package",
                          textSize: 12.sp,
                          onChanged: model.onChange,
                          hintColor: textColor,
                          fillColor: white,
                          // textColor: model.typeProvider?.name != null? textColor: null,
                          enabledBorder: InputBorder.none,
                          hint:
                              // model.typeProvider?.name ??
                              "Choose a package",
                          onTap: () {},
                          //model.showInternetTypeProvidersBottomSheet,
                          // enabled: false,
                          readonly: true,
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppText(
                            "Phone Number",
                            size: 12.sp,
                            overflow: TextOverflow.ellipsis,
                            maxLine: 1,
                          ),
                        ),
                        AppTextField(
                          controller: model.phoneNumberController,
                          hint: "Enter Phone number",
                          fillColor: Colors.white,
                          onChanged: model.onChange,
                          enabledBorder: InputBorder.none,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          keyboardType: TextInputType.phone,
                        ),
                        10.0.sbH,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppText(
                            "Profile Code",
                            size: 12.sp,
                            overflow: TextOverflow.ellipsis,
                            maxLine: 1,
                          ),
                        ),
                        AppTextField(
                          controller: model.phoneNumberController,
                          hint: "Enter Profile Code",
                          fillColor: Colors.white,
                          onChanged: model.onChange,
                          enabledBorder: InputBorder.none,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            // LengthLimitingTextInputFormatter(10)
                          ],
                          keyboardType: TextInputType.phone,
                        ),
                        10.0.sbH,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, bottom: 8.0),
                                                child: AppText(
                                                  "₦",
                                                  color: textColor,
                                                  size: 16.sp,
                                                ),
                                              ),
                                              Expanded(
                                                child: AppTextField(
                                                  borderless: true,
                                                  controller: model
                                                      .amountNumberController,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 0),
                                                  isPassword: false,
                                                  hint:
                                                      // model
                                                      //         .typeProvider?.amount
                                                      //         .toString() ??
                                                      "0.00",
                                                  onChanged: model.onChange,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                    ),
                                  ),
                                  10.0.sbW,
                                  AppButton(
                                    onTap: model.phoneNumberController.text
                                                .isEmpty ||
                                            model.amountNumberController.text
                                                .isEmpty
                                        ? null
                                        : model.fetchCustomerEnquiry,
                                    isExpanded: false,
                                    backGroundColor: const Color(0xFF1CBF73),
                                    height: 34,
                                    child: Padding(
                                      padding: 5.0.padH,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            AppImages.coins,
                                            height: 16,
                                            width: 16,
                                          ),
                                          5.0.sbW,
                                          AppText(
                                            "Pay ${model.amountNumberController.text.trim()}",
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // SizedBox(
                //   height: 40,
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       16.0.sbW,
                //       Container(
                //         width: 80,
                //         child: IntrinsicWidth(
                //             child: AppText(
                //                 model.educationResponseModel?.data?.name ??
                //                     "")),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.only(left: 5, right: 8),
                //         height: 40,
                //         width: 1,
                //         color: Colors.grey,
                //       ),
                //       Expanded(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             AppTextField(
                //               borderless: true,
                //               controller: model.phoneNumberController,
                //               contentPadding: const EdgeInsets.symmetric(
                //                   horizontal: 10, vertical: 0),
                //               isPassword: false,
                //               hint: "Enter phone number",
                //               enabledBorder: InputBorder.none,
                //               inputFormatters: [
                //                 FilteringTextInputFormatter.digitsOnly,
                //                 LengthLimitingTextInputFormatter(11)
                //               ],
                //               keyboardType: TextInputType.phone,
                //             ),
                //           ],
                //         ),
                //       ),
                //       10.0.sbW,
                //       SvgPicture.asset(
                //         AppImages.personCircle,
                //         height: 30,
                //         width: 30,
                //       ),
                //       16.0.sbW
                //     ],
                //   ),
                // ),
              ]),
            ))),
      ),
    );
  }
}

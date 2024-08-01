import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/UI/home/bills-view/gifting-view/gifting-view-vm.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';
import '../../../../constants/reuseables.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_field.dart';

class GiftingViewScreen extends StatelessWidget {
  const GiftingViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<GiftingViewViewModel>(
      builder: (_, model, child) => Scaffold(
          appBar: const AppBars(
            text: "Send Gift",
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              16.0.sbH,
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: AppText(
                  "Send a gift to anyone in ${AppStrings.appName}",
                  size: 14.sp,
                  weight: FontWeight.w500,
                ),
              ),
              20.0.sbH,
              AppCard(
                margin: 16.0.padH,
                useShadow: true,
                // backgroundColor: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: AppTextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                            keyboardType: TextInputType.phone,
                            controller: model.phoneNumberController,
                            fillColor: Colors.white,
                            isPassword: false,
                            onChanged: model.onPhoneChange,
                            hintText: "Phone Number",
                            hintColor: textColor,
                            hint: "e.g. 09044441111",
                          ),
                        ),
                        10.0.sbW,
                        InkWell(
                          onTap: model.requestContactsPermission,
                          child: Padding(
                            padding: 20.0.padV,
                            child: SvgPicture.asset(
                              AppImages.personCircle,
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    model.nameLookUpResponse != null
                        ? Padding(
                            padding: 5.0.padV,
                            child: AppText(
                              model.nameLookUpResponse?.name ?? "",
                              weight: FontWeight.w600,
                              size: 15.sp,
                            ),
                          )
                        : 0.0.sbH
                  ],
                ),
              ),
              30.0.sbH,
              AppCard(
                margin: 16.0.padH,
                useShadow: true,
                padding: 10.0.padA,
                backgroundColor: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.0.sbH,
                    const AppText(
                      "Gift Amount",
                      isBold: true,
                      size: 16,
                    ),
                    10.0.sbH,
                    GridView.builder(
                        itemCount: model.value.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 7.0,
                          mainAxisSpacing: 10.0, // padding bottom
                          childAspectRatio: 1.5,
                          mainAxisExtent: 47.0,
                        ),
                        itemBuilder: (_, i) {
                          return AppCard(
                            onTap: () => model.onChipSelected(model.value[i]),
                            margin: 0.0.padA,
                            padding: 5.0.padA,
                            child: Row(
                              children: [
                                Expanded(
                                    child: AppText(
                                  "₦ ${model.value[i]}",
                                  size: 13.sp,
                                  overflow: TextOverflow.ellipsis,
                                  maxLine: 1,
                                  align: TextAlign.center,
                                ))
                              ],
                            ),
                          );
                        }),
                    35.0.sbH,
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                          controller:
                                              model.amountNumberController,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 0),
                                          isPassword: false,
                                          hint: "500-500,000",
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
                            onTap: model.phoneNumberController.text.isEmpty ||
                                    model.amountNumberController.text.isEmpty ||
                                    model.nameLookUpResponse == null
                                ? null
                                : model.payGift,
                            isExpanded: false,
                            backGroundColor: const Color(0xFF1CBF73),
                            height: 34,
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
              ),
            ]),
          ))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/UI/home/bills-view/betting-view/betting-view-vm.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';
import '../../../../constants/reuseables.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_field.dart';

class BettingViewScreen extends StatelessWidget {
  const BettingViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ForceBaseView<BettingBillViewViewModel>(
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
                        const Text("Betting"),
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
            body: SingleChildScrollView(
              child: SafeArea(
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
                        size: 14.sp,
                        overflow: TextOverflow.ellipsis,
                        maxLine: 1,
                      ),
                      TextButton(
                        onPressed: model.showElectricityProvidersBottomSheet,
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
                                model.provider?.slug ??
                                    "Select Service Provider",
                                size: 14.sp,
                                overflow: TextOverflow.ellipsis,
                                maxLine: 1,
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
                      Visibility(
                        visible: model.isProviderSelected,
                        child: Container(
                          margin: 10.sp.padT,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: textColor.withOpacity(0.2),
                                  width: 0.5.sp),
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: TextButton(
                            onPressed:
                                model.showElectricityTypeProvidersBottomSheet,
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                // Add border color if needed
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppText(
                                  model.typeProvider?.name?.toLowerCase() ??
                                      "Provider Types",
                                  size: 14.sp,
                                  overflow: TextOverflow.ellipsis,
                                  maxLine: 1,
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
                      ),
                      5.0.sbH,
                    ],
                  ),
                ),
                AppCard(
                  margin: 15.0.padH,
                  padding: 15.0.padA,
                  useShadow: true,
                  backgroundColor: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppText(
                            "User ID",
                            size: 14.sp,
                            overflow: TextOverflow.ellipsis,
                            maxLine: 1,
                          ),
                          const Spacer(),
                          // AppText(
                          //   "Favourites >",
                          //   size: 12.sp,
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLine: 1,
                          // ),
                        ],
                      ),
                      7.0.sbH,
                      AppTextField(
                        hint: "Enter UserId number",
                        fillColor: secondaryColor,
                        borderless: true,
                        controller: model.phoneNumberController,
                        onChanged: model.onChange,
                        onEditingComplete: () {},
                        inputFormatters: [
                          // FilteringTextInputFormatter.digitsOnly,
                          // LengthLimitingTextInputFormatter(11)
                        ],
                        keyboardType: TextInputType.phone,
                        // validator: emailValidator,
                      ),
                    ],
                  ),
                ),
                16.0.sbH,
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
                        "Select Amount",
                        isBold: false,
                        size: 14,
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
                            childAspectRatio:
                                1.5, // Adjust the aspect ratio as needed

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
                                                    horizontal: 10,
                                                    vertical: 0),
                                            isPassword: false,
                                            hint: "500",
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
                              onTap: model.provider == null ||
                                      model.typeProvider == null ||
                                      model
                                          .phoneNumberController.text.isEmpty ||
                                      model.amountNumberController.text.isEmpty
                                  ? null
                                  : model.fetchCustomerEnquiry,
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
              ])),
            )),
      ),
    );
  }
}

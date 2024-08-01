import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/UI/home/bills-view/electricity-view/electricity-view-vm.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/reuseables.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_field.dart';

class ElectricityViewScreen extends StatelessWidget {
  const ElectricityViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ElectricityBillViewViewModel>(
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
                        const Text("Electricity"),
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
                  heights: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Service Provider",
                        size: 12.sp,
                        maxLine: 1,
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  model.showElectricityProvidersBottomSheet();
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    // Add border color if needed
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: AppText(
                                        model.provider?.slug ?? "Provider",
                                        size: 14.sp,
                                        weight: model.provider?.slug == null
                                            ? null
                                            : FontWeight.w600,
                                        align: TextAlign.start,
                                      ),
                                    ),
                                    10.sp.sbW,
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
                      const Divider(),
                      5.0.sbH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            onTap: () {
                              String selectedPaidElectricity =
                                  model.postpaidElectricity ?? "Postpaid";
                              model.getSelectedPaidElectricity(
                                  selectedPaidElectricity);
                              model.isPostpaidSelected = true;
                            },
                            isExpanded: false,
                            backGroundColor: model.isPostpaidSelected
                                ? primaryColor
                                : Colors.white,
                            height: 40,
                            width: 150,
                            child: AppText(
                              model.postpaidElectricity ?? "Postpaid",
                              color: Colors.black,
                              size: 12.sp,
                              overflow: TextOverflow.ellipsis,
                              maxLine: 1,
                            ),
                          ),
                          AppButton(
                            onTap: () {
                              model.isPostpaidSelected = false;

                              String selectedPaidElectricity =
                                  model.prepaidElectricity ?? "Prepaid";
                              model.getSelectedPaidElectricity(
                                  selectedPaidElectricity);
                            },
                            isExpanded: false,
                            backGroundColor: model.isPostpaidSelected
                                ? Colors.white
                                : primaryColor,
                            height: 40,
                            width: 150,
                            child: AppText(
                              model.prepaidElectricity ?? "Prepaid",
                              color: Colors.black,
                              size: 12.sp,
                              overflow: TextOverflow.ellipsis,
                              maxLine: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppCard(
                  onTap: () {},
                  margin: 15.0.padH,
                  padding: 15.0.padA,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Meter Number",
                        size: 12.sp,
                      ),
                      15.0.sbH,
                      AppTextField(
                        hint: "Enter Meter number",
                        fillColor: Colors.white,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11)
                        ],
                        keyboardType: TextInputType.phone,
                        borderless: true,
                        controller: model.phoneNumberController,
                        onChanged: model.onChange,
                        // validator: emailValidator,
                      ),
                    ],
                  ),
                ),
                AppCard(
                  margin: 16.0.padH,
                  useShadow: true,
                  padding: 10.0.padA,
                  backgroundColor: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.0.sbH,
                      AppText(
                        "Select Amount",
                        size: 12.sp,
                      ),
                      16.0.sbH,
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
                            // Set the itemExtent to fix the height of each item
                            // You may need to adjust the value based on your design
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
                                            hint: "Enter Amount",
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
                                      model.selectPaidElectricity == "" ||
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
              ]),
            ))),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/UI/home/bills-view/internet-view/internet-view-vm.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/core/models/internet_response_model.dart';
import 'package:taskitly/utils/widget_extensions.dart';
import '../../../../constants/reuseables.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_field.dart';

class InternetViewScreen extends StatelessWidget {
  const InternetViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<InternetBillViewViewModel>(
      notDefaultLoading: true,
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
                        const Text("Internet"),
                        const Spacer(),
                        InkWell(
                          onTap: model.history,
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppCard(
                    bordered: true,
                    borderWidth: 0.5.sp,
                    borderColor: textColor.withOpacity(0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "Service Provider",
                          weight: FontWeight.w400,
                          size: 12.sp,
                        ),
                        SizedBox(
                          // height: 40,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: model.isLoading &&
                                        model.providers.isEmpty
                                    ? const AppText("Loading...")
                                    : IntrinsicWidth(
                                        child: DropdownButtonFormField<Smile>(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          value: model.provider,
                                          items: model.providers
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        AppText(
                                                          e.slug ?? "Select",
                                                          size: 14.0,
                                                          weight:
                                                              FontWeight.w500,
                                                          isBold: true,
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: model.onChanged,
                                          hint: const AppText(
                                            "Select",
                                            size: 14,
                                          ),
                                          isExpanded: true,
                                          // validator: validator,
                                          decoration: InputDecoration(
                                            errorMaxLines: 3,
                                            border: InputBorder.none,
                                            isDense: true,
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .disabledColor),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppCard(
                  margin: 16.0.padH,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppText(
                          "Recipient",
                          size: 12.sp,
                          overflow: TextOverflow.ellipsis,
                          maxLine: 1,
                        ),
                      ),
                      AppTextField(
                        controller: model.phoneNumberController,
                        hint: "Phone number",
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
                      AppTextField(
                        hintText: "Select Package",
                        textSize: 12.sp,
                        onChanged: model.onChange,
                        hintColor: textColor,
                        fillColor: white,
                        textColor:
                            model.typeProvider?.name != null ? textColor : null,
                        enabledBorder: InputBorder.none,
                        hint: model.typeProvider?.name ?? "Select an option",
                        onTap: model.showInternetTypeProvidersBottomSheet,
                        // enabled: false,
                        readonly: true,
                      ),
                      20.0.sbH,
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
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 0),
                                                isPassword: false,
                                                hint: model.typeProvider?.amount
                                                        .toString() ??
                                                    "500",
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
                                          model.phoneNumberController.text
                                              .isEmpty
                                      ? null
                                      : model.fetchCustomerEnquiry,
                                  isExpanded: false,
                                  isLoading: model.isLoading,
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
              ]),
            ))),
      ),
    );
  }
}

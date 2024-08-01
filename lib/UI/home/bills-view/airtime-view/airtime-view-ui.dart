import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/UI/home/bills-view/airtime-view/airtime-view-vm.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';
import '../../../../constants/reuseables.dart';
import '../../../../core/models/airtime_response_model.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_field.dart';

class AirtimeViewScreen extends StatelessWidget {
  const AirtimeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AirtiemBillViewViewModel>(
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
                        const Text("Airtime"),
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
                child: Form(
              key: model.formKey,
              child: Column(children: [
                30.0.sbH,
                SizedBox(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      16.0.sbW,
                      IntrinsicWidth(
                        child: DropdownButtonFormField<AirTimeServiceProvider>(
                          borderRadius: BorderRadius.circular(12),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: model.provider,
                          items: model.providers
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          e.image ?? "",
                                          height: 40,
                                          width: 40,
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                          onChanged: model.onChanged,
                          hint: const AppText("Select"),
                          isExpanded: true,
                          // validator: validator,
                          decoration: InputDecoration(
                            errorMaxLines: 3,
                            border: InputBorder.none,
                            isDense: true,
                            hintStyle: TextStyle(
                                color: Theme.of(context).disabledColor),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 8),
                        height: 40,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppTextField(
                              borderless: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                              onChanged: model.onChange,
                              keyboardType: TextInputType.phone,
                              controller: model.phoneNumberController,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              isPassword: false,
                              hint: "Enter phone number",
                              enabledBorder: InputBorder.none,
                            ),
                          ],
                        ),
                      ),
                      10.0.sbW,
                      InkWell(
                        onTap: model.requestContactsPermission,
                        child: SvgPicture.asset(
                          AppImages.personCircle,
                          height: 30,
                          width: 30,
                        ),
                      ),
                      16.0.sbW
                    ],
                  ),
                ),
                const Divider(),
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
                        "Top Up",
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
                                                    horizontal: 10,
                                                    vertical: 0),
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
                              onTap: model.phoneNumberController.text
                                              .trim()
                                              .length !=
                                          11 ||
                                      model.amountNumberController.text
                                          .isEmpty ||
                                      model.provider == null
                                  ? null
                                  : model.payAirtime,
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

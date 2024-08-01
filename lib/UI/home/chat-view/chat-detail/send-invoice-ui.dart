import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/snack_message.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/palette.dart';
import '../../../../utils/text_styles.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/text_field.dart';
import 'chat-detail-vm.dart';
import 'send-invoice.vm.dart';

class SendInvoiceScreen extends StatelessWidget {
  final ChatDetailViewModel mod;
  const SendInvoiceScreen({super.key, required this.mod});

  @override
  Widget build(BuildContext context) {
    return BaseView<SendInvoiceViewModel>(
      builder: (_, model, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: 16.0.padA,
          child: SafeArea(
            top: true,
            bottom: false,
            child: Form(
              key: model.formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: navigationService.goBack,
                        child: Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: secondaryColor),
                          child: const Icon(
                            Icons.clear,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          "create invoice".toTitleCase(),
                          size: 20.sp,
                          weight: FontWeight.w600,
                        ),
                        5.0.sbH,
                        AppText(
                          "please provide your service details to create invoice"
                              .toTitleCase(),
                          style: subStyle,
                          align: TextAlign.center,
                        ),
                        34.0.sbH,
                        Expanded(
                          child: ListView(
                            children: [
                              AppTextField(
                                hintText: "Service To Render",
                                prefix: const Icon(CupertinoIcons.person_fill),
                                hint: "Enter Service",
                                controller: model.serviceToRenderController,
                                onChanged: model.onChanges,
                                validator: emptyValidator,
                              ),
                              8.0.sbH,
                              AppTextField(
                                hintText: "Service Amount",
                                prefix: const Icon(
                                    CupertinoIcons.money_dollar_circle_fill),
                                hint: "Amount Charged",
                                controller: model.serviceAmountController,
                                onChanged: model.onChanges,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d*')),
                                ],
                                validator: emptyValidator,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                              ),
                              8.0.sbH,
                              Row(
                                children: [
                                  Expanded(
                                    child: AppTextField(
                                      hintText: "Start Date",
                                      suffixIcon:
                                          const Icon(CupertinoIcons.calendar),
                                      hint: "From",
                                      readonly: true,
                                      onTap: () =>
                                          model.pickFromDateTime(picDate: true),
                                      controller: model.startDateController,
                                      validator: (val) {
                                        if (model.startDateController.text
                                            .trim()
                                            .isEmpty) {
                                          return "Start date cannot be empty";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  16.0.sbW,
                                  Expanded(
                                    child: AppTextField(
                                      hintText: "Start Time",
                                      suffixIcon:
                                          const Icon(CupertinoIcons.time_solid),
                                      hint: "From",
                                      readonly: true,
                                      onTap: () => model.pickFromDateTime(
                                          picDate: false),
                                      controller: model.startTimeController,
                                      validator: (val) {
                                        if (model.startTimeController.text
                                            .trim()
                                            .isEmpty) {
                                          return "Start time cannot be empty";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              8.0.sbH,
                              Row(
                                children: [
                                  Expanded(
                                    child: AppTextField(
                                      hintText: "End Date",
                                      suffixIcon:
                                          const Icon(CupertinoIcons.calendar),
                                      hint: "To",
                                      readonly: true,
                                      onTap: () =>
                                          model.pickToDateTime(picDate: true),
                                      controller: model.endDateController,
                                      validator: (val) {
                                        if (model.endDateController.text
                                            .trim()
                                            .isEmpty) {
                                          return "End date cannot be empty";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  16.0.sbW,
                                  Expanded(
                                    child: AppTextField(
                                      hintText: "End Time",
                                      suffixIcon:
                                          const Icon(CupertinoIcons.time_solid),
                                      hint: "To",
                                      readonly: true,
                                      onTap: () =>
                                          model.pickToDateTime(picDate: false),
                                      controller: model.endTimeController,
                                      validator: (val) {
                                        if (model.endTimeController.text
                                            .trim()
                                            .isEmpty) {
                                          return "End time cannot be empty";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              8.0.sbH,
                              TextArea(
                                label: "Any Additional Note",
                                hintText: "Type Here",
                                controller: model.additionalInfoController,
                                onChanged: model.onChanges,
                                keyBoardType: TextInputType.text,
                                show: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  8.0.sbH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppButton(
                          text: "Cancel",
                          backGroundColor: errorColor,
                          onTap: navigationService.goBack,
                        ),
                      ),
                      16.0.sbW,
                      Expanded(
                        child: AppButton(
                            text: "Send",
                            onTap: () {
                              if (model.formKey.currentState?.validate() ==
                                  true) {
                                model.sendInvoice(mod.skills);
                              } else {
                                showCustomToast("Fill all fields");
                              }
                            }),
                      ),
                    ],
                  ),
                  5.0.sbH,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

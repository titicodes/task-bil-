import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/palette.dart';
import '../../../../constants/reuseables.dart';
import '../../../../utils/text_styles.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/text_field.dart';
import 'report-vm.dart';

class ReportOrderView extends StatelessWidget {
  final String orderID;
  final String order;
  final String reportedName;
  const ReportOrderView(
      {super.key,
      required this.orderID,
      required this.reportedName,
      required this.order});

  @override
  Widget build(BuildContext context) {
    return BaseView<ReportOrderViewModel>(
      onModelReady: (m) => m.init(order),
      builder: (_, model, child) => Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: Padding(
            padding: 16.sp.padH,
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
                30.0.sbH,
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      "Report",
                      size: 20.sp,
                      weight: FontWeight.w600,
                    ),
                    15.0.sbH,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "you are about to report order ",
                              style: hintStyle.copyWith(fontSize: 13.sp),
                            ),
                            TextSpan(
                              text: 'ID: $orderID',
                              style: hintStyle.copyWith(
                                  fontSize: 13.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: " with $reportedName",
                              style: hintStyle.copyWith(fontSize: 13.sp),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    30.0.sbH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppText(
                            "could you please write your complain here?",
                            size: 16.sp,
                            weight: FontWeight.w600,
                            align: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    10.sp.sbH,
                    TextArea(
                      hintText: "Add a comment (optional)",
                      controller: model.textAreaController,
                      onChanged: model.onChange,
                      show: true,
                    ),
                    30.sp.sbH,
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            onTap: navigationService.goBack,
                            isLoading: false,
                            text: "Cancel",
                            backGroundColor: errorColor,
                          ),
                        ),
                        30.sp.sbW,
                        Expanded(
                          child: AppButton(
                            onTap:
                                model.textAreaController.text.trim().isNotEmpty
                                    ? model.submit
                                    : null,
                            isLoading: model.isLoading,
                            text: "Report",
                          ),
                        ),
                      ],
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

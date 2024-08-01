import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/palette.dart';
import '../../../../constants/reuseables.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/appCard.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/text_field.dart';
import 'delete-account.vm.dart';

class DeleteMyAccountScreen extends StatelessWidget {
  const DeleteMyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DeleteMyAccountViewModel>(
      onModelReady: (m) {
        m.context = context;
      },
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          title: Column(
            children: [
              AppText(
                AppStrings.deleteMyAccount,
                size: 20.sp,
                weight: FontWeight.w600,
                maxLine: 1,
                overflow: TextOverflow.ellipsis,
              ),
              5.0.sbH,
              AppText(AppStrings.deleteMyAccountDetails,
                  color: hintTextColor,
                  size: 12,
                  weight: FontWeight.w400,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis)
            ],
          ),
        ),
        body: ListView(
          padding: 16.0.padH,
          children: [
            16.0.sbH,
            ListView.builder(
                itemCount: model.issues.length,
                shrinkWrap: true,
                padding: 0.0.padA,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, i) {
                  String issue = model.issues[i];
                  return AppCard(
                      onTap: () => model.select(issue),
                      margin: 10.0.padB,
                      borderWidth: 1,
                      bordered: model.selectedIssue == issue ? true : false,
                      padding: 16.0.padA,
                      child: AppText(
                        issue,
                        size: 13,
                        color: const Color(
                          0xFF6B6B6B,
                        ),
                        isBold: true,
                      ));
                }),
            37.0.sbH,
            const AppText("Would you like to tell us how to improve?",
                weight: FontWeight.w500),
            12.0.sbH,
            TextArea(
              show: true,
              hintText: 'Type your review here (optional)',
              controller: model.helpImproveController,
            ),
            30.0.sbH,
            AppButton(
              onTap: navigationService.goBack,
              text: "Continue using Taskitly",
              backGroundColor: primaryColor,
            ),
            16.0.sbH,
            AppButton(
              isTransparent: true,
              borderColor: Colors.red,
              text: AppStrings.deleteAccount,
              textColor: Colors.red,
              onTap: model.deleteAccount,
            )
          ],
        ),
      ),
    );
  }
}

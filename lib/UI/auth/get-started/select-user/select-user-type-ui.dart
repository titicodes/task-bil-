import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/text_styles.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import 'select-user-type-vm.dart';

class SelectUserTypeScreen extends StatelessWidget {
  const SelectUserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SelectUserTypeViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(),
        body: Padding(
          padding: 16.0.padA,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                AppStrings.howTwoUse,
                weight: FontWeight.w600,
                size: 20.sp,
              ),
              24.0.sbH,
              GridView.builder(
                shrinkWrap: true,
                itemCount: model.clientData.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust the number of columns as needed
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemBuilder: (_, i) {
                  return AppCard(
                    margin: 0.0.padA,
                    onTap: () => model.onChange(model.clientData[i]),
                    bordered: model.selectedData == model.clientData[i]
                        ? true
                        : false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                          model.clientData[i].image,
                          style: subBodyTextStyle,
                        ),
                        5.0.sbH,
                        AppText(
                          model.clientData[i].details,
                          align: TextAlign.center,
                          style: hintStyle,
                        )
                      ],
                    ),
                  );
                },
              ),
              const Spacer(),
              AppButton(
                text: "Continue",
                onTap: model.selectedData == null ? null : model.onSubmit,
              ),
              20.0.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.alreadyHaveAnAccount,
                          style: subStyle.copyWith(fontSize: 15),
                        ),
                        TextSpan(
                          text: AppStrings.signIn,
                          style: subUnderlineGreenStyle.copyWith(fontSize: 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = model.goToUserLogin,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              30.0.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

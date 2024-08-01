import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/text_field.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../base/base.ui.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/apptexts.dart';
import 'change.password.vm.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ChangePasswordViewModel>(
      onModelReady: (m) {
        m.context = context;
      },
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          title: AppText(
            "Change Password",
            color: primaryColor,
            size: 20.sp,
            weight: FontWeight.w600,
          ),
        ),
        body: Padding(
          padding: 16.0.padA,
          child: Form(
            key: model.formKey,
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    AppTextField(
                      controller: model.oldPasswordController,
                      onChanged: model.onChange,
                      validator: emptyValidator,
                      hintText: "Old Password",
                      hint: "Enter Old Password",
                      isPassword: true,
                      prefix: const Icon(Icons.lock_person_rounded),
                    ),
                    8.0.sbH,
                    AppTextField(
                      hintText: "New Password",
                      isPassword: true,
                      prefix: const Icon(Icons.lock_person_rounded),
                      hint: "Enter New password",
                      controller: model.newPasswordController,
                      onChanged: model.onChange,
                      validator: passwordValidator,
                    ),
                    8.0.sbH,
                    AppTextField(
                      hintText: "Confirm New Password",
                      isPassword: true,
                      prefix: const Icon(Icons.lock_person_rounded),
                      hint: "Confirm New password",
                      controller: model.confirmNewPasswordController,
                      onChanged: model.onChange,
                      validator: (val) {
                        if (model.confirmNewPasswordController.text
                            .trim()
                            .isEmpty) {
                          return "Confirm Password cannot be empty";
                        } else if (model.confirmNewPasswordController.text
                                .trim() !=
                            model.newPasswordController.text.trim()) {
                          return "Confirm Password must be the same as password";
                        }
                        return null;
                      },
                    )
                  ],
                ),
                const Spacer(),
                AppButton(
                  text: "Continue",
                  backGroundColor: primaryColor,
                  onTap: model.formKey.currentState?.validate() != true
                      ? null
                      : model.submit,
                  isLoading: model.isLoading,
                ),
                30.0.sbH
              ],
            ),
          ),
        ),
      ),
    );
  }
}

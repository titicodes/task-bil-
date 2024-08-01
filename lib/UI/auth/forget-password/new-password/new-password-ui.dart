import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/palette.dart';
import '../../../../constants/reuseables.dart';
import '../../../../utils/text_styles.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/text_field.dart';
import 'new-password-vm.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OtherView<NewPasswordViewModel>(
      builder: (_, model, child) => Form(
        key: model.formKey,
        child: Stack(
          children: [
            Column(
              children: [
                const DrawerAppBar(),
                Padding(
                  padding: 16.0.padH,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        "create new password".toTitleCase(),
                        size: 20.sp,
                        weight: FontWeight.w600,
                      ),
                      5.0.sbH,
                      AppText(
                        AppStrings.createNewPassword,
                        style: subStyle.copyWith(color: secondaryDarkColor),
                        align: TextAlign.center,
                      ),
                      34.0.sbH,
                      AppTextField(
                        hintText: "create new password".toTitleCase(),
                        isPassword: true,
                        prefix: const Icon(Icons.lock_person_rounded),
                        hint: "Enter password",
                        controller: model.passwordNameController,
                        onChanged: model.onChange,
                        validator: passwordValidator,
                      ),
                      8.0.sbH,
                      AppTextField(
                        hintText: "confirm new password".toTitleCase(),
                        isPassword: true,
                        prefix: const Icon(Icons.lock_person_rounded),
                        hint: "Confirm password",
                        controller: model.confirmPasswordNameController,
                        onChanged: model.onChange,
                        validator: (val) {
                          if (model.confirmPasswordNameController.text
                              .trim()
                              .isEmpty) {
                            return "Confirm Password cannot be empty";
                          } else if (model.confirmPasswordNameController.text
                                  .trim() !=
                              model.passwordNameController.text.trim()) {
                            return "Confirm Password must be the same as password";
                          }
                          return null;
                        },
                      ),
                      30.0.sbH,
                      AppButton(
                        text: "Confirm",
                        onTap: model.formKey.currentState?.validate() != true
                            ? null
                            : model.submit,
                      ),
                      30.0.sbH,
                    ],
                  ),
                )
              ],
            ),
            model.isLoading ? const SmallLoader() : 0.0.sbH
          ],
        ),
      ),
    );
  }
}

class DrawerAppBar extends StatelessWidget {
  const DrawerAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: navigationService.goBack,
          child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: secondaryColor),
            child: const Icon(
              Icons.clear,
              size: 18,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}

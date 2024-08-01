import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/base/base.ui.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../constants/palette.dart';
import '../../../constants/reuseables.dart';
import '../../../utils/string-extensions.dart';
import '../../../utils/text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/apptexts.dart';
import '../../widgets/text_field.dart';
import 'login-vm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Login to continue",
        ),
        body: Form(
          key: model.formKey,
          child: ListView(
            padding: 16.0.padA,
            children: [
              AppTextField(
                hintText: "Email address",
                prefix: const Icon(CupertinoIcons.mail_solid),
                hint: "Enter Email address",
                controller: model.emailNameController,
                onChanged: model.onChange,
                validator: emailValidator,
              ),
              10.0.sbH,
              AppTextField(
                hintText: "Password",
                isPassword: true,
                prefix: const Icon(Icons.lock_person_rounded),
                hint: "Enter password",
                controller: model.passwordController,
                onChanged: model.onChange,
                // validator: passwordValidator,
              ),
              15.0.sbH,
              AppButton(
                text: "Sign in",
                onTap: model.formKey.currentState?.validate() != true
                    ? null
                    : model.submit,
                isLoading: model.isLoading,
              ),
              16.0.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: model.goToForgetPassword,
                    child: AppText(
                      "Forgot Password?",
                      style: subUnderlineGreenStyle.copyWith(fontSize: 15),
                    ),
                  )
                ],
              ),
              16.0.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.dontHaveAccount,
                          style: subStyle.copyWith(fontSize: 15.sp),
                        ),
                        TextSpan(
                          text: AppStrings.signUp,
                          style: subUnderlineGreenStyle.copyWith(
                              fontSize: 15.sp, color: primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = model.goToUserType,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

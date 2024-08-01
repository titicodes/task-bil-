import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/reuseables.dart';
import '../../../../utils/string-extensions.dart';
import '../../../../utils/text_styles.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/custom_phone_number_input.dart';
import '../../../widgets/text_field.dart';
import 'sign-up-vm.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      notDefaultLoading: true,
      builder: (context, model, child) => Scaffold(
        appBar: const AppBars(
          title: Text("Sign up"),
        ),
        body: Form(
          key: model.formKey,
          child: ListView(
            padding: 16.0.padH,
            children: [
              AppText(
                model.appCache.userType == "client"
                    ? AppStrings.findService
                    : AppStrings.offerService,
                size: 15,
              ),
              15.0.sbH,
              AppText(
                "Please make sure your details are correct",
                size: 13.sp,
                color: hintTextColor,
              ),
              20.0.sbH,
              AppTextField(
                hintText: "First Name",
                prefix: const Icon(CupertinoIcons.person_fill),
                hint: "Enter First Name",
                controller: model.firstNameController,
                onChanged: model.onChange,
                validator: emptyValidator,
              ),
              8.0.sbH,
              AppTextField(
                hintText: "Last Name",
                prefix: const Icon(CupertinoIcons.person_fill),
                hint: "Enter Last Name",
                controller: model.lastNameController,
                onChanged: model.onChange,
                validator: emptyValidator,
              ),
              8.0.sbH,
              AppTextField(
                hintText: "Username",
                prefix: const Icon(CupertinoIcons.person_fill),
                hint: "Enter User Name",
                controller: model.userNameController,
                onChanged: model.onChange,
                validator: emptyValidator,
              ),
              8.0.sbH,
              AppTextField(
                hintText: "Email address",
                prefix: const Icon(CupertinoIcons.mail_solid),
                hint: "Enter Email address",
                controller: model.emailNameController,
                onChanged: model.onChange,
                validator: emailValidator,
              ),
              8.0.sbH,
              CustomPhoneNumberInput(
                controller: model.phoneController,
                isoCode: model.countryCode,
                hintText: "Phone Number",
                onInputChanged: (v) {
                  model.countryCode = v.dialCode;
                  model.phoneNumber = v.phoneNumber;
                  model.onChange("");
                },
                validator: (val) {
                  String value = model.phoneNumber ?? "";
                  if (value.length < 4) {
                    return "Phone Number cannot be empty";
                  } else if (formatPhoneNumber(
                              trimPhone(model.phoneNumber ?? ""))
                          .length !=
                      11) {
                    return "Invalid Phone Number";
                  }
                  return null;
                },
              ),
              8.0.sbH,

              // 8.0.sbH,
              AppTextField(
                hintText: "Referral code",
                prefix: const Icon(CupertinoIcons.personalhotspot),
                hint: "Enter referral code (Optional)",
                controller: model.referralNameController,
                onChanged: model.onChange,
              ),
              8.0.sbH,
              AppTextField(
                hintText: "Password",
                isPassword: true,
                prefix: const Icon(Icons.lock_person_rounded),
                hint: "Enter password",
                controller: model.passwordNameController,
                onChanged: model.onChange,
                validator: passwordValidator,
              ),
              8.0.sbH,
              AppTextField(
                hintText: "Confirm Password",
                isPassword: true,
                prefix: const Icon(Icons.lock_person_rounded),
                hint: "Confirm password",
                controller: model.confirmPasswordNameController,
                onChanged: model.onChange,
                validator: (val) {
                  if (model.confirmPasswordNameController.text.trim().isEmpty) {
                    return "Confirm Password cannot be empty";
                  } else if (model.confirmPasswordNameController.text.trim() !=
                      model.passwordNameController.text.trim()) {
                    return "Confirm Password must be the same as password";
                  }
                  return null;
                },
              ),
              15.0.sbH,
              AppButton(
                text: "Sign up ",
                onTap: model.formKey.currentState?.validate() != true
                    ? null
                    : model.submit,
                isLoading: model.isLoading,
              ),
              15.0.sbH,
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
              40.0.sbH,
             // model.isLoading ? const SmallLoader() : 0.0.sbH
            ],
          ),
        ),
      ),
    );
  }
}

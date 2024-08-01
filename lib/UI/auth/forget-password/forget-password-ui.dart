import 'package:flutter/material.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../utils/string-extensions.dart';
import '../../base/base.ui.dart';
import '../../widgets/app_button.dart';
import '../../widgets/apptexts.dart';
import '../../widgets/custom_phone_number_input.dart';
import 'forget-password-vm.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgetPasswordViewModel>(
      onModelReady: (m) => m.init(context),
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Forget Password",
        ),
        body: Form(
          key: model.formKey,
          child: ListView(
            padding: 16.0.padA,
            children: [
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
              16.0.sbH,
              const AppText(
                AppStrings.enterEmail,
                size: 13,
              ),
              16.0.sbH,
              AppButton(
                text: "Continue",
                onTap: model.formKey.currentState?.validate() != true
                    ? null
                    : model.submit,
                isLoading: model.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:taskitly/UI/auth/get-started/sign-up/enter_phone/enter-phone-number.vm.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../utils/string-extensions.dart';
import '../../../../base/base.ui.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/appbar.dart';
import '../../../../widgets/custom_phone_number_input.dart';

class EnterPhoneNumberScreen extends StatelessWidget {
  const EnterPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<EnterPhoneNumberViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Enter Phone Number",
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
                "we’ll send a code to verify this phone number.",
                size: 13,
              ),
              16.0.sbH,
              AppButton(
                text: "Continue",
                onTap: model.formKey.currentState?.validate() == false
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

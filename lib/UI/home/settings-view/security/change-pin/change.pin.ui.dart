import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../constants/palette.dart';
import '../../../../base/base.ui.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/appbar.dart';
import '../../../../widgets/text_field.dart';
import 'change.pin.vm.dart';
import 'new_change_pin_vm.dart';

class ChangePinScreen extends StatelessWidget {
  const ChangePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ChangePinViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Change Pin",
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
                    8.0.sbH,
                    AppTextField(
                      hintText: "New Pin",
                      isPassword: true,
                      maxLength: 4,
                      prefix: const Icon(Icons.lock_person_rounded),
                      hint: "Enter New Pin",
                      controller: model.newPinController,
                      onChanged: model.onChange,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "New Pin cannot be empty";
                        }
                        return null;
                      },
                    ),
                    8.0.sbH,
                    AppTextField(
                      hintText: "Confirm New Pin",
                      isPassword: true,
                      maxLength: 4,
                      prefix: const Icon(Icons.lock_person_rounded),
                      hint: "Confirm New Pin",
                      controller: model.confirmNewPinController,
                      onChanged: model.onChange,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (val) {
                        if (model.confirmNewPinController.text.trim().isEmpty) {
                          return "Confirm Pin cannot be empty";
                        } else if (model.confirmNewPinController.text.trim() !=
                            model.newPinController.text.trim()) {
                          return "Confirm Pin must be the same as Pin";
                        }
                        return null;
                      },
                    )
                  ],
                ),
                const Spacer(),
                AppButton(
                  text: "Change Pin",
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

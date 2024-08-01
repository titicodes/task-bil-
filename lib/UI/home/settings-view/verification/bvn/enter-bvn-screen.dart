import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/home/settings-view/verification/bvn/new_bvn_vm.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../utils/utils.dart';
import '../../../../base/base.ui.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/apptexts.dart';
import '../../../../widgets/text_field.dart';
import 'bvn-vm.dart';

class EnterBVNScreen extends StatelessWidget {
  const EnterBVNScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<NewBvnViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "BVN Verification",
        ),
        body: Form(
          key: model.formKey,
          child: Padding(
            padding: 16.0.padH,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.0.sbH,
                AppText(
                  "We need your Bank Verification Number to generate a Virtual Account for you",
                  size: 12.sp,
                  color: const Color(0xFF6B6B6B),
                  align: TextAlign.start,
                ),
                30.0.sbH,
                AppTextField(
                  hintText: "Enter Your BVN",
                  hintColor: primaryColor,
                  prefix: const Icon(Icons.password),
                  hint: "Enter BVN number",
                  controller: model.bvnController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (newValue) =>
                      model.onDateOfBirthChanged(model.dateOfBirth),
                  validator: (val) {
                    if (model.bvnController.text.trim().isEmpty) {
                      return "BVN cannot be empty";
                    } else if (int.tryParse(model.bvnController.text.trim()) ==
                        null) {
                      return "BVN must only be Numbers";
                    } else if (model.bvnController.text.trim().length != 11) {
                      return "BVN has only eleven (11) characters";
                    }
                    return null;
                  },
                ),
                16.0.sbH,
                AppTextField(
                  hintText: "Date of birth",
                  hint: model.dateOfBirth == null
                      ? "Select Date"
                      : model.formatDateForViewModel(
                          model.dob), // Call the specific formatting method
                  readonly: true,
                  textColor: model.dateOfBirth == null ? null : Colors.black,
                  onTap: () =>
                      model.pickToDateTime(pickDate: true, context: context),
                  prefix: const Icon(Icons.calendar_month),
                  validator: (val) {
                    if (model.dateOfBirth == null) {
                      return "Date of Birth Cannot be empty";
                    }
                    return null;
                  },
                ),
                16.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      "If you can’t remember your BVN dial *565*0# to check your BVN.",
                      size: 11.sp,
                      color: const Color(0xFF6B6B6B),
                      align: TextAlign.center,
                    ),
                  ],
                ),
                67.0.sbH,
                AppButton(
                  text: "Verify BVN",
                  backGroundColor: primaryColor,
                  onTap: model.formKey.currentState?.validate() != true
                      ? null
                      : model.submitForVerification,
                ),
                16.0.sbH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

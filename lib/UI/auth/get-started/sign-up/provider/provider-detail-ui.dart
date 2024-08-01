import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../constants/reuseables.dart';
import '../../../../../utils/string-extensions.dart';
import '../../../../base/base.ui.dart';
import '../../../../widgets/apptexts.dart';
import '../../../../widgets/text_field.dart';
import 'provider-detail-vm.dart';

class ProviderDetailScreen extends StatelessWidget {
  const ProviderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProviderDetailViewModel>(
      notDefaultLoading: true,
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          text: "Complete Sign Up".toTitleCase(),
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
              AppTextField(
                hintText: "Company Name",
                prefix: const Icon(CupertinoIcons.person_fill),
                hint: "Enter company name".toTitleCase(),
                controller: model.companyNameController,
                onChanged: model.onChange,
                validator: emptyValidator,
              ),
              8.0.sbH,
              AppTextField(
                hintText: "Company Description",
                prefix: const Icon(CupertinoIcons.person_fill),
                hint: "Description your company".toTitleCase(),
                controller: model.descriptionController,
                onChanged: model.onChange,
                validator: emptyValidator,
              ),
              8.0.sbH,
              AppTextField(
                hintText: "service type".toTitleCase(),
                hint: model.isLoading
                    ? "Loading..."
                    : model.category == null
                        ? "Enter service type".toTitleCase()
                        : model.category?.name ?? "",
                onTap: model.showSelectServiceBottomSheet,
                suffixIcon: const Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 29,
                ),
                readonly: true,
                textColor: model.category == null ? null : Colors.black,
                validator: (val) {
                  if (model.category == null) {
                    return "Service Type must be selected";
                  }
                  return null;
                },
              ),
              8.0.sbH,
              AppTextField(
                hintText: "do you have any skill?".toTitleCase(),
                hint: model.isLoading
                    ? "Loading..."
                    : model.selectedSkill ?? "Enter skill".toTitleCase(),
                onTap: model.showSelectSkillsBottomSheet,
                suffixIcon: const Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 29,
                ),
                readonly: true,
                textColor: model.selectedSkills.isEmpty ? null : Colors.black,
                validator: (val) {
                  if (model.selectedSkill == null) {
                    return "Skills must be selected";
                  }
                  return null;
                },
              ),
              8.0.sbH,
              AppTextField(
                hintText: "Minumum service amount",
                prefix: const Icon(CupertinoIcons.person_fill),
                hint: "Least amount you charge".toTitleCase(),
                controller: model.minimumAmountController,
                onChanged: model.onChange,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (val) {
                  String value = val ?? "";
                  if (value.isEmpty) {
                    return "Minimum service amount cannot be empty";
                  } else {
                    int price = int.tryParse(value) ?? 0;
                    if (price < 1) {
                      return "Minimum service amount cannot be less than one";
                    }
                  }
                  return null;
                },
              ),
              8.0.sbH,
              Row(
                children: [
                  Expanded(
                    child: NewDropDownSelect(
                      hintText: "available Days".toTitleCase(),
                      onChanged: model.selectStartDay,
                      // prefix: Icon(Icons.timer, color: hintTextColor,),
                      hint: "From",
                      items: model.workDays,
                      validator: (val) {
                        if (model.startDay == null) {
                          return "Select Start work day";
                        }
                        return null;
                      },
                    ),
                  ),
                  16.0.sbW,
                  Expanded(
                    child: NewDropDownSelect(
                      hintText: "available Days".toTitleCase(),
                      onChanged: model.selectEndDay,
                      hint: "To",
                      items: model.toWorkDays,
                      validator: (val) {
                        if (model.endDay == null) {
                          return "Select End work day";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              16.0.sbH,
              Row(
                children: [
                  Expanded(
                    child: NewDropDownSelect(
                      hintText: "available time".toTitleCase(),
                      onChanged: model.selectStartTime,
                      hint: "From",
                      items: model.workTime,
                      validator: (val) {
                        if (model.startTime == null) {
                          return "Select Start work time";
                        }
                        return null;
                      },
                    ),
                  ),
                  16.0.sbW,
                  Expanded(
                    child: NewDropDownSelect(
                      hintText: "available time".toTitleCase(),
                      onChanged: model.selectEndTime,
                      hint: "To",
                      items: model.toWorkTime,
                      validator: (val) {
                        if (model.endTime == null) {
                          return "Select End work time";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              14.0.sbH,
              AppTextField(
                hintText: "Country",
                hint: "Enter Country".toTitleCase(),
                controller: model.countryController,
                onChanged: model.onChange,
                validator: emptyValidator,
              ),
              8.0.sbH,
              AppTextField(
                hintText: "State",
                hint: "Enter State".toTitleCase(),
                controller: model.stateController,
                onChanged: model.onChange,
                validator: emptyValidator,
              ),
              16.0.sbH,
              AppButton(
                text: "Sign Up",
                onTap: model.formKey.currentState?.validate() != true
                    ? null
                    : model.submit,
                    isLoading: model.isLoading,
              ),
              40.0.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

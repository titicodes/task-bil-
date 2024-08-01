import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/base/base.ui.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/text_field.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/size_utils.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/text_styles.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import 'edit-service-vm.dart';

class EditServiceDetailsScreen extends StatelessWidget {
  const EditServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<EditServiceViewModel>(
      notDefaultLoading: true,
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          text: "Update Service Details".toTitleCase(),
        ),
        body: Form(
          key: model.formKey,
          child: ListView(
            padding: 16.0.padH,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(100, 51, 99, 51),
                width: double.infinity,
                height: 126,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12.h),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: model.pickedImage != null
                        ? FileImage(File(model.pickedImage!.path))
                        : model.serviceDetailsData?.image != null
                            ? CachedNetworkImageProvider(
                                "https://api.taskitly.com${model.serviceDetailsData?.image}")
                            : const AssetImage(AppImages.serviceDetailsImage)
                                as ImageProvider<Object>,
                  ),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: model.pickImage,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6.33.h, 0.h, 5.h, 0.h),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffe8f9f1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'REPLACE SERVICE LOGO',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10.h,
                              fontWeight: FontWeight.w600,
                              height: 2.h,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22.v),
              SizedBox(height: 5.v),
              AppTextField(
                hintText: "Company name",
                controller: model.companyNameController,
                hint: "M&M Electronics",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15.h, vertical: 14.v),
                validator: emptyValidator,
              ),
              SizedBox(height: 22.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Set working hours",
                  style: bodySmall,
                ),
              ),
              15.0.sbH,
              Row(
                children: [
                  Expanded(
                    child: NewDropDownSelect(
                      hintText: "Set Working Days".toTitleCase(),
                      onChanged: model.selectStartDay,
                      value: model.startDay,
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
                      hintText: "".toTitleCase(),
                      onChanged: model.selectEndDay,
                      hint: "To",
                      value: model.endDay,
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
              20.0.sbH,
              Row(
                children: [
                  Expanded(
                    child: NewDropDownSelect(
                      hintText: "Set Working Hours".toTitleCase(),
                      onChanged: model.selectStartTime,
                      hint: "From",
                      value: model.startTime,
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
                      hintText: "".toTitleCase(),
                      onChanged: model.selectEndTime,
                      hint: "To",
                      value: model.endTime,
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
              20.0.sbH,
              Row(
                children: [
                  AppTextField(
                    boxWidth: 180.fSize,
                    hintText: "Select Service".toTitleCase(),
                    hint: model.isLoading && model.categories.isEmpty
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
                  const Spacer(),
                  AppTextField(
                    hintText: "Select Skill".toTitleCase(),
                    boxWidth: 180.fSize,
                    hint: model.isLoading && model.skills.isEmpty
                        ? "Loading..."
                        : model.selectedSkill ?? "Enter skill".toTitleCase(),
                    onTap: model.showSelectSkillsBottomSheet,
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 29,
                    ),
                    readonly: true,
                    textColor:
                        model.selectedSkills.isEmpty ? null : Colors.black,
                    validator: (val) {
                      if (model.selectedSkill == null) {
                        return "Skills must be selected";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              40.0.sbH,
              Text(
                "Describe your service",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.5.fSize,
                    color: primaryColor),
              ),
              8.0.sbH,
              AppTextField(
                controller: model.descriptionController,
                hint:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500.",
                maxHeight: 4,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.v, vertical: 17.v),
              ),
              20.0.sbH,
              AppButton(
                text: "Update",
                isLoading: model.isLoading,
                onTap: model.formKey.currentState?.validate() != true
                    ? null
                    : model.updateServiceDetails,
              ),
              60.0.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

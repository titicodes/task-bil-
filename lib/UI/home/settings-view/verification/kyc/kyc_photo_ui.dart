import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/utils/size_utils.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../constants/palette.dart';
import '../../../../../utils/drop_down.dart';
import '../../../../../utils/text_styles.dart';
import '../../../../base/base.ui.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/appbar.dart';
import '../../../../widgets/text_field.dart';
import 'kyc_main_vm.dart';

class KYCPhotoScreen extends StatelessWidget {
  KYCPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<KYCMainViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "KYC Verification",
        ),
        body: Form(
          key: model.formKey,
          child: ListView(
            padding: 16.0.padA,
            children: [
              Text(
                "Kindly Select your ID Type",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: bodySmall.copyWith(height: 1.83, fontSize: 13.sp),
              ),
              20.0.sbH,
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "select iD type",
                  style: bodySmall.copyWith(
                    color: primaryColor,
                    fontSize: 14.fSize,
                  ),
                ),
                SizedBox(height: 5.v),
                CustomDropDown(
                  hintText: model.selectedType.isEmpty
                      ? "Selected ID Type"
                      : model.selectedType,
                  items: model.dropdownItemList2,
                  onChanged: model.onDropDownChanged,
                  contentPadding: EdgeInsets.all(10.sp),
                )
              ]),
              SizedBox(height: 21.v),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    hintText: "enter Card ID",
                    hint: "Enter card ID number",
                    controller: model.enterCardIDNumberController2,
                    onChanged: model.onChange,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Card ID cannot be empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 33.v),
              _buildFrameKindlyMakeSure(context),
              SizedBox(height: 55.v),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 1.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(text: "u".toUpperCase(), style: labelLarge),
                          TextSpan(text: "pload your ", style: labelLarge),
                          TextSpan(text: "ID ", style: labelLarge),
                          TextSpan(text: "Image", style: labelLarge)
                        ]),
                        textAlign: TextAlign.left),
                    SizedBox(height: 30.v),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 84.v, vertical: 13.v),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0XFFD9D9D9).withOpacity(0.1),
                              spreadRadius: 2.v,
                              blurRadius: 2.v,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey.withOpacity(1),
                            width: 2.fSize,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                model.pickImage();
                              },
                              child: Container(
                                height: model.pickedImage != null ? 60.v : 32.v,
                                width: model.pickedImage != null ? 60.v : 33.v,
                                padding: EdgeInsets.all(8.v),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: model.pickedImage != null
                                    ? Image.file(
                                        File(model.pickedImage!.path),
                                        width: 87.v,
                                        height: 87.v,
                                        fit: BoxFit.contain,
                                      )
                                    : Icon(
                                        Icons.add_photo_alternate,
                                        size: 40.v,
                                      ),
                              ),
                            ),
                            SizedBox(height: 24.v),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "click ",
                                    style: bodySmall.copyWith(
                                      color: red500,
                                      fontSize: 12.fSize,
                                    ),
                                  ), // bodySmallErrorContainer
                                  TextSpan(
                                    text: "here to upload/take picture",
                                    style: bodySmall.copyWith(
                                      color: red500,
                                      fontSize: 12.fSize,
                                    ),
                                  ), //bodySmallErrorContainer
                                ],
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              70.0.sbH,
              AppButton(
                text: "Upload ID",
                onTap: model.formKey.currentState?.validate() != true
                    ? null
                    : model.uploadIDSubmit,
                isLoading: model.isLoading,
              ),
              16.0.sbH,
            ],
          ),
        ),
      ),
    );
  }

  // make sure widget
  Widget _buildFrameKindlyMakeSure(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
              TextSpan(text: "kindly ", style: labelLarge),
              TextSpan(
                  text: "make sure your identity have these", style: labelLarge)
            ]),
            textAlign: TextAlign.left),
        SizedBox(height: 15.v),
        Padding(
          padding: EdgeInsets.only(left: 6.v),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "1. clear ", style: bodySmall),
                TextSpan(
                  text: "and complete passport image is required",
                  style: bodySmall,
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 9.v),
        Padding(
          padding: EdgeInsets.only(left: 6.v),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "2. passport ", style: bodySmall),
                TextSpan(
                  text: "must be valid with an unexpired date",
                  style: bodySmall,
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 10.v),
        Padding(
          padding: EdgeInsets.only(left: 6.v),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "3. The ", style: bodySmall),
                TextSpan(
                  text:
                      "data page should display your full name, date of birth and phone",
                  style: bodySmall,
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  var red500 = const Color(0XFFEF4444);
}

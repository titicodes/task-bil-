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

class KYCMainScreen extends StatelessWidget {
  const KYCMainScreen({super.key});

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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.v, vertical: 4.v),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: primaryColor.withOpacity(1),
                    width: 2.fSize,
                  ),
                  borderRadius: BorderRadius.circular(
                    15.sp,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.v),
                  child: Text(
                    "Estimated verification time 10mins",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.v),
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
                  hintText: "Select ID Type",
                  items: model.dropdownItemList,
                  onChanged: model.onDropDownChanged,
                  contentPadding: EdgeInsets.all(10.sp),
                )
              ]),
              SizedBox(height: 21.v),
              if (!model.photoVerifSelected)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      hintText: "enter Card ID",
                      hint: "Enter card ID number",
                      controller: model.bvnController,
                      onChanged: model.onChange,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Card ID cannot be empty";
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
                      textColor:
                          model.dateOfBirth == null ? null : Colors.black,
                      onTap: () => model.pickToDateTime(
                          pickDate: true, context: context),
                      prefix: const Icon(Icons.calendar_month),
                      validator: (val) {
                        if (model.dateOfBirth == null) {
                          return "Date of Birth Cannot be empty";
                        }
                        return null;
                      },
                    ),
                    16.0.sbH,
                  ],
                ),
              SizedBox(height: 33.v),
              _buildKindlyReadThis(context),
              SizedBox(height: 15.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 329.fSize,
                  margin: EdgeInsets.only(right: 28.fSize),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Via USSD\n",
                        style: labelLarge.copyWith(
                          color: primaryColor.withOpacity(1),
                          fontSize: 12.fSize,
                        ),
                      ),
                      TextSpan(
                        text:
                            "Dial *346*3*Your NIN*715461# .\nYour Virtual NIN generated for you will be sent via sms.\n",
                        style: bodySmall.copyWith(height: 1.83),
                      ),
                      TextSpan(
                        text: "\nVia NIMC app\n",
                        style: labelLarge
                            .copyWith(
                              color: primaryColor.withOpacity(1),
                              fontSize: 12.fSize,
                            )
                            .copyWith(height: 1.83),
                      ),
                      TextSpan(
                        text:
                            "Download the NIMC App- Click on \"Get Virtual NIN\"\nSelect \"Input Enterprise short-code\" and type 715461\nClick \"Submit\" and your virtual NIN will be generated.",
                        style: bodySmall.copyWith(height: 1.83),
                      ),
                    ]),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              70.0.sbH,
              AppButton(
                text: "Verify ID",
                onTap: model.photoVerifSelected != true &&
                        model.formKey.currentState?.validate() != true
                    ? null
                    : model.verifyIDSubmit,
                isLoading: model.isLoading,
              ),
              16.0.sbH,
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildKindlyReadThis(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "kindly ",
                style: labelLarge,
              ),
              TextSpan(
                text: "read this to get your ",
                style: labelLarge,
              ),
              TextSpan(
                text: "nIN".toUpperCase(),
                style: labelLarge,
              ),
              TextSpan(
                text: " Number",
                style: labelLarge,
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 17.sp),
        Container(
          width: 338.sp,
          margin: EdgeInsets.only(right: 19.sp),
          child: Text(
            "NIMC has stopped the use of actual 11-digit NINs for verifications, to continue your NIN verification. Generating a vNIN There are two ways to generate a virtual NIN",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: bodySmall.copyWith(height: 1.83),
          ),
        ),
      ],
    );
  }
}

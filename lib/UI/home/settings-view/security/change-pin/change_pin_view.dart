import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/UI/base/base.ui.dart';
import 'package:taskitly/UI/home/settings-view/security/change-pin/new_change_pin_vm.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/text_field.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/text_styles.dart';
import 'package:taskitly/utils/widget_extensions.dart';

class NewChangePinView extends StatelessWidget {
  const NewChangePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return OtherView<ChangePinViewModel>(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return RefreshIndicator(
            onRefresh: () async => model.init(),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: width(context)),
                child: SizedBox(
                  height: height(context) * 0.7,
                  child: Column(
                    children: [
                      6.0.sbH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            "Change Pin",
                            size: 16.sp,
                            overflow: TextOverflow.ellipsis,
                            maxLine: 1,
                            weight: FontWeight.w600,
                          ),
                          InkWell(
                            onTap: navigationService.goBack,
                            child: Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: secondaryColor,
                              ),
                              child: const Icon(
                                Icons.clear,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      12.0.sbH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppImages.mail,
                            colorFilter:
                                ColorFilter.mode(primaryColor, BlendMode.srcIn),
                            height: 18,
                            width: 24,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.oipSentTo,
                                  style: subStyle.copyWith(
                                      fontSize: 15.sp, color: primaryColor),
                                ),
                                TextSpan(
                                  text: "${model.userService.user.phoneNumber}",
                                  style: subStyle.copyWith(
                                      fontSize: 15.sp, color: primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print('Details tapped!');
                                    },
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      12.0.sbH,
                      AppTextField(
                        // hintText: "Enter OTP",
                        isPassword: false,
                        maxLength: 5,
                        //prefix: const Icon(Icons.lock_outline_rounded),
                        controller: model.pinCodeController,
                        onChanged: model.onChange,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "This Pin cannot be empty";
                          }
                          return null;
                        },
                        suffixIcon: TextButton(
                          onPressed:
                              model.isResendOtpEnabled ? model.resendOtp : null,
                          child: AppText(
                            model.isResendOtpEnabled
                                ? "Get OTP"
                                : "Resend OTP ${model.formatTime(model.resendOtpSeconds)}",
                            color: primaryColor,
                            size: 16.sp,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),
                      16.0.sbH,
                      AppButton(
                        text: "Continue",
                        onTap: model.isContinueButtonEnabled
                            ? model.verifyOTP
                            : null, // Enable/disable button
                      ),
                      16.0.sbH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppText(
                            AppStrings.problemSendingOtp,
                            color: primaryDarkColor,
                            size: 13.0.sp,
                          ),
                        ],
                      ),
                      model.isLoading ? const SmallLoader() : 0.0.sbH,
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

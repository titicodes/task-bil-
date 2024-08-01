import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../utils/text_styles.dart';
import '../base/base.ui.dart';
import 'on-boarding-vm.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardingViewModel>(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: height(context),
                    initialPage: 0,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (
                      index,
                      reason,
                    ) {
                      model.changeCarouselIndexValue(index);
                    },
                  ),
                  itemCount: 3,
                  itemBuilder: (context, index, realIndex) {
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          model.onBoardingObjects[index].image),
                                      fit: BoxFit.fitWidth))),
                        ),
                        SizedBox(
                          height: 6,
                          child: AnimatedSmoothIndicator(
                            activeIndex: model.sliderIndex,
                            count: 3,
                            axisDirection: Axis.horizontal,
                            effect: ScrollingDotsEffect(
                              spacing: 10,
                              activeDotColor: primaryColor,
                              activeDotScale: 1,
                              dotColor: secondaryColor,
                              dotHeight: 6,
                              dotWidth: index == realIndex ? 22 : 9,
                            ),
                          ),
                        ),
                        30.0.sbH,
                        AppText(
                          AppStrings.welcome,
                          size: 22.sp,
                        ),
                        10.0.sbH,
                        Padding(
                          padding: 16.0.padH,
                          child: AppText(
                            model.onBoardingObjects[index].details,
                            style: hintStyle,
                            align: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: 16.0.padA,
                child: Column(
                  children: [
                    45.0.sbH,
                    AppButton(
                      text: "Get Started",
                      onTap: model.goToUserType,
                    ),
                    24.0.sbH,
                    AppButton(
                      isTransparent: true,
                      onTap: model.goToUserLogin,
                      text: "Log In",
                    ),
                    35.0.sbH,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppStrings.byContinuing,
                            style: subStyle,
                          ),
                          TextSpan(
                            text: AppStrings.termsAndCondition,
                            style: subUnderlineGreenStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle tap here
                                print('Details tapped!');
                                // Add your navigation or other logic here
                              },
                          ),
                          TextSpan(
                            text: AppStrings.and,
                            style: subStyle,
                          ),
                          TextSpan(
                            text: AppStrings.privacyPolicy,
                            style: subUnderlineGreenStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle tap here
                                print('Details tapped!');
                                // Add your navigation or other logic here
                              },
                          ),
                          TextSpan(text: AppStrings.fullStop, style: subStyle),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    20.0.sbH,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

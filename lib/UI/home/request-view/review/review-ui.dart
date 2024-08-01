import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/text_field.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/palette.dart';
import '../../../../constants/reuseables.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/apptexts.dart';
import 'review-vm.dart';

class ReviewScreen extends StatelessWidget {
  final String orderID;
  const ReviewScreen({super.key, required this.orderID});

  @override
  Widget build(BuildContext context) {
    return BaseView<ReviewViewModel>(
      onModelReady: (m) => m.init(orderID),
      builder: (_, model, child) => Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: Padding(
            padding: 16.sp.padH,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: navigationService.goBack,
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: secondaryColor),
                        child: const Icon(
                          Icons.clear,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                30.0.sbH,
                Expanded(
                    child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        40.0.sbH,
                        AppText(
                          "How was your experience with this service provider?",
                          size: 17.sp,
                          weight: FontWeight.w600,
                          align: TextAlign.center,
                        ),
                        40.sp.sbH,
                        AppText(
                          "Tap on a star rate this service?",
                          size: 12.sp,
                          color: hintTextColor,
                        ),
                        25.0.sbH,
                        RatingBar.builder(
                          initialRating: model.initialRating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemSize: 30,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.sp),
                          itemBuilder: (context, _) => const Icon(
                            CupertinoIcons.star_fill,
                            color: Color(0xFFFFA000),
                            size: 30,
                          ),
                          onRatingUpdate: model.changeRating,
                        ),
                        30.sp.sbH,
                        TextArea(
                          hintText: "Add a comment (optional)",
                          controller: model.textAreaController,
                          onChanged: model.onChange,
                          show: true,
                        ),
                      ],
                    ),
                  ],
                )),
                30.0.sbH,
                AppButton(
                  onTap: model.confirm,
                  isLoading: model.isLoading,
                  text: "Confirm",
                ),
                30.0.sbH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

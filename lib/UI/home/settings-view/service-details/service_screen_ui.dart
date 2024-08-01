import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/base/base.ui.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import 'edit-service-vm.dart';
import 'rating_widget.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<EditServiceViewModel>(
      notDefaultLoading: true,
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          text: "Service Details".toTitleCase(),
        ),
        body: Form(
          key: model.formKey,
          child: ListView(
            padding: 16.0.padH,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 27.h),
                width: double.infinity,
                height: 126.h,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12.sp),
                  image: model.serviceDetailsData == null
                      ? const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(AppImages.serviceDetailsImage),
                        )
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              "https://api.taskitly.com${model.serviceDetailsData?.image}"),
                        ),
                ),
              ),
              20.0.sbH,
              Row(
                children: [
                  Container(
                    child: Text(
                      (model.serviceDetailsData?.companyName ??
                              "Mechanical Services")
                          .toUpperCase(), //'MECHANICAL SERVICES',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.2125.sp,
                        letterSpacing: 0.3000000119.sp,
                        color: const Color(0xff2b2b2b),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // rating
                  // Rating
                  model.averageRating != null
                      ? RatingBar.builder(
                          initialRating: model.averageRating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemSize: 14,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => const Icon(
                            CupertinoIcons.star_fill,
                            color: Color(0xFFFFA000),
                            size: 12,
                          ),
                          onRatingUpdate: (rating) {},
                        )
                      : Text(
                          "No ratings yet",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                ],
              ),
              20.0.sbH,
              Text(
                (model.serviceDetailsData?.description ??
                    "Your description and how you do your service will be here"),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.2125.sp,
                  letterSpacing: 0.3000000119.sp,
                  color: const Color(0xff6b6b6b),
                ),
              ),
              30.0.sbH,
              Text(
                "Working Hours & Days",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  height: 1.2125.sp,
                  letterSpacing: 0.3000000119.sp,
                  color: const Color(
                    0xff2b2b2b,
                  ),
                ),
              ),
              10.0.sbH,
              Row(
                children: [
                  Text(
                    "${model.serviceDetailsData?.weekdays?.first} - ${model.serviceDetailsData?.weekdays?.last}", //"Monday - Sunday"
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2125.sp,
                      letterSpacing: 0.3000000119.sp,
                      color: const Color(
                        0xff2b2b2b,
                      ),
                    ),
                  ),
                  20.0.sbHW,
                  Text(
                    "${model.serviceDetailsData?.startHour}-${model.serviceDetailsData?.endHour}", //, "08:00AM-12:00PM",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.2125.sp,
                      letterSpacing: 0.3000000119.sp,
                      color: const Color(0xff6b6b6b),
                    ),
                  ),
                ],
              ),
              30.0.sbH,
              Text(
                "Set your availability",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  height: 1.2125.sp,
                  letterSpacing: 0.3000000119.sp,
                  color: const Color(
                    0xff2b2b2b,
                  ),
                ),
              ),
              15.0.sbH,
              Container(
                padding: EdgeInsets.fromLTRB(15.h, 13.h, 15.h, 12.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffe6e6e6)),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 155.h,
                      ),
                      child: Text(
                        "Let your clients know when you’re available or unavailable\nwith a simple switch",
                        maxLines: 3,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.2125.h,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // online contasiner
                    Container(
                      padding: 5.0.padL,
                      decoration: BoxDecoration(
                        color: model.switchValue
                            ? const Color(0xffe8f9f1)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(30.h),
                        boxShadow: [
                          BoxShadow(
                            color: model.switchValue
                                ? const Color(0xff1cbf73)
                                : Colors.black45,
                            offset: Offset(0.h, 0.h),
                            blurRadius: 1.h,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.switchValue ? 'Online' : 'Offline',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: model.switchValue
                                  ? const Color(0xff1cbf73)
                                  : Colors.grey,
                            ),
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              value: model.switchValue,
                              onChanged: model.onSwitchChanged,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              30.0.sbH,
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 6.sp, horizontal: 12.sp),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffe6e6e6),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 150.w),
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffe6e6e6),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${(model.completionRate * 1).toStringAsFixed(1)}%', // Fixed to 1 decimal place
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.5625.sp,
                              color: const Color(0xff1cbf73),
                            ),
                          ),
                          Text(
                            'Order Completion',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.5625.sp,
                              color: const Color(0xff212936),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(minWidth: 150.w),
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffe6e6e6))),
                      child: Column(
                        children: [
                          Text(
                            '100%   ',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.5625.sp,
                              color: const Color(0xff1cbf73),
                            ),
                          ),
                          Text(
                            'Completion',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.5625.sp,
                              color: const Color(0xff212936),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              25.0.sbH,
              Container(
                padding: EdgeInsets.fromLTRB(15.h, 13.h, 15.h, 12.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffe6e6e6)),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: 155.h,
                      ),
                      child: Text(
                        "Registered",
                        maxLines: 3,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.2125.h,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Days ago
                    Container(
                      margin: EdgeInsets.fromLTRB(0.h, 0.h, 0.h, 1.h),
                      padding: EdgeInsets.fromLTRB(13.h, 5.h, 13.h, 5.h),
                      width: 120.h,
                      height: 41.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(30.h),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF171818),
                            offset: Offset(0.h, 0.h),
                            blurRadius: 1.h,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.calculateTimeAgo(
                                model.serviceDetailsData?.createdAt ?? ""),
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.2125.h,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              30.0.sbH,
              AppButton(
                text: "Edit Services",
                onTap: model.gotoEditServiceDetails,
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

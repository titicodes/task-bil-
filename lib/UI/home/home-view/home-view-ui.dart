import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/price-widget.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/core/models/prodiders-service-response.dart';
import 'package:taskitly/core/models/user-response.dart';
import 'package:taskitly/utils/shimmer_loaders.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../constants/reuseables.dart';
import '../../../core/models/verification-status.dart';
import '../../../utils/text_styles.dart';
import '../../base/base.ui.dart';
import '../../widgets/appbar.dart';
import 'home-view-vm.dart';

class HomeViewScreen extends StatelessWidget {
  const HomeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewViewModel>(
      notDefaultLoading: true,
      onModelReady: (model) => model.init(),
      builder: (_, model, child) => RefreshIndicator(
        onRefresh: model.refresh,
        child: Scaffold(
          appBar: AppBars(
            leading: 0.0.sbH,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: AppStrings.welcomeUser,
                                style: hintStyle.copyWith(fontSize: 15.sp),
                              ),
                              TextSpan(
                                text: model.userService.user.firstName ?? "",
                                style: bodyTextStyle.copyWith(
                                    fontSize: 15.sp,
                                    color: primaryLimeDarkColor),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    model.userService.isUserServiceProvider
                        ? Container(
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
                          )
                        : Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const ShapeDecoration(
                                  shape: OvalBorder(
                                    side: BorderSide(
                                        width: 1, color: Color(0xFFE6E6E6)),
                                  ),
                                ),
                                child: Image.asset(
                                  AppImages.coinPng,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              12.0.sbW,
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: model.goToRefer,
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    padding: 10.0.padA,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: AppText(
                                      AppStrings.refer,
                                      size: 13,
                                      color: const Color(0xFF1CBF73),
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    12.0.sbW,
                    InkWell(
                        onTap: model.goToViewNotification,
                        child: SvgPicture.asset(
                          AppImages.notification,
                          height: 24,
                          width: 24,
                        ))
                  ],
                )
              ],
            ),
          ),
          body: ListView(
            padding: 16.0.padA,
            children: [
              AppCard(
                backgroundColor: const Color(0xFFE5FDE5),
                padding: 6.0.padA,
                useShadow: true,
                spreadRadius: 1.5,
                blurRadius: 2,
                child: Column(
                  children: [
                    AppCard(
                      backgroundColor: Colors.white,
                      padding: 16.0.padA,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  model.history();
                                },
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    AppText(
                                      AppStrings.transHistory,
                                      size: 11,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 13,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          17.0.sbH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Builder(
                                builder: (context) {
                                  return StreamBuilder<User?>(
                                    stream: model.getUserData(),
                                    builder: (context, snapshot) {
                                      return PriceWidget(
                                        value: snapshot.data?.walletBalance ??
                                            model.userService.user
                                                .walletBalance ??
                                            0,
                                        color: hintTextColor,
                                      );
                                    },
                                  );
                                },
                              ),
                              Row(
                                children: [
                                  AppButton(
                                    onTap: () {
                                      model.withdrawal(model);
                                    },
                                    isExpanded: false,
                                    backGroundColor: const Color(0xFF1CBF73),
                                    height: 34,
                                    child: Padding(
                                      padding: 5.0.padH,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            AppImages.withdraw,
                                            height: 16,
                                            width: 16,
                                          ),
                                          5.0.sbW,
                                          const AppText(
                                            AppStrings.withdraw,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  10.0.sbW,
                                  AppButton(
                                    onTap: () {
                                      model.topUp("Confirm", subtitle: "");
                                    },
                                    isExpanded: false,
                                    backGroundColor: const Color(0xFF1CBF73),
                                    height: 34,
                                    child: Padding(
                                      padding: 5.0.padH,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            AppImages.coins,
                                            height: 16,
                                            width: 16,
                                          ),
                                          5.0.sbW,
                                          const AppText(
                                            AppStrings.topUp,
                                            color: Colors.white,
                                            weight: FontWeight.w600,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    model.emailVerified == true && model.bvnVerified == true
                        ? 0.0.sbH
                        : Builder(
                            builder: (context) {
                              return StreamBuilder<VerificationStatus?>(
                                stream: model.userStatus(),
                                builder: (context, snapshot) {
                                  VerificationStatus? status =
                                      snapshot.data ?? model.status;
                                  return status?.payload?.bvnVerified == true &&
                                          status?.payload?.emailVerified == true
                                      ? 0.0.sbH
                                      : Column(
                                          children: [
                                            6.0.sbH,
                                            Padding(
                                              padding: 10.0.padV,
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    AppImages.stars,
                                                    height: 20,
                                                    width: 19,
                                                  ),
                                                  10.0.sbW,
                                                  Expanded(
                                                    child: Padding(
                                                      padding: 10.0.padR,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: AppStrings
                                                                  .moreInfo,
                                                              style:
                                                                  bodyTextStyle
                                                                      .copyWith(
                                                                fontSize: 12.sp,
                                                                height: 1.5,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: AppStrings
                                                                  .tapToProceed,
                                                              style:
                                                                  subUnderlineGreenStyle
                                                                      .copyWith(
                                                                fontSize: 12.sp,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap = model
                                                                        .goToVerify,
                                                            ),
                                                          ],
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                },
                              );
                            },
                          ),
                  ],
                ),
              ),
              25.0.sbH,
              25.0.sbH,
              model.userService.loginResponse.servicepro == true
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText("Bookings".toTitleCase(),
                                size: 14,
                                style: bodyTextStyle.copyWith(
                                    fontWeight: FontWeight.w600)),
                            InkWell(
                                onTap: model.goToViewBookingsMore,
                                child: AppText(
                                  AppStrings.viewAll,
                                  style: subUnderlineGreenStyle,
                                ))
                          ],
                        ),
                        16.0.sbH,
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: model.orders.length > 2
                                ? 2
                                : model.orders.length,
                            itemBuilder: (_, i) {
                              return model.isLoading && model.orders.isEmpty
                                  ? AppCard(
                                      margin: 10.0.padB,
                                      padding: 0.0.padA,
                                      heights: 150,
                                      child: const ShimmerCard(),
                                    )
                                  : model.isLoading && model.orders.isEmpty
                                      ? Container(
                                          height: 150,
                                          width: width(context),
                                          alignment: Alignment.center,
                                          child: AppText(
                                            "No booking yet... Stay online... It's coming",
                                            size: 15.sp,
                                            weight: FontWeight.w600,
                                          ),
                                        )
                                      : AppCard(
                                          backgroundColor: Colors.black,
                                          padding: 16.0.padA,
                                          margin: 10.0.padB,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppText(
                                                    "${model.orders[i].service?.category?.name}"
                                                        .toTitleCase(),
                                                    color: Colors.white,
                                                    weight: FontWeight.w600,
                                                  ),
                                                  InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onTap: () {},
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8,
                                                          horizontal: 17),
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: model.orders[i]
                                                                    .status ==
                                                                "active"
                                                            ? const Color(
                                                                0xFFE8F9F1)
                                                            : model.orders[i]
                                                                        .status ==
                                                                    "canceled"
                                                                ? errorColor
                                                                    .withOpacity(
                                                                        0.1)
                                                                : secondaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                      child: AppText(
                                                        (model.orders[i]
                                                                    .status ??
                                                                "")
                                                            .toTitleCase(),
                                                        color: primaryColor,
                                                        size: 10,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              20.0.sbH,
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 18,
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(model
                                                                .orders[i]
                                                                .customer
                                                                ?.profileImage ??
                                                            "https://via.placeholder.com/36x36"),
                                                  ),
                                                  10.0.sbW,
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AppText(
                                                          (model
                                                                      .orders[i]
                                                                      .customer
                                                                      ?.username ??
                                                                  "lerry james")
                                                              .toTitleCase(),
                                                          isBold: true,
                                                          color: Colors.white,
                                                        ),
                                                        8.0.sbH,
                                                        Row(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .access_time_filled_outlined,
                                                                  color:
                                                                      primaryColor,
                                                                  size: 14,
                                                                ),
                                                                5.0.sbW,
                                                                AppText(
                                                                  model
                                                                      .formatDateTime(
                                                                          "${model.orders[i].date}")
                                                                      .toTitleCase(),
                                                                  size: 10,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              ],
                                                            ),
                                                            10.0.sbW,
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .location_on_rounded,
                                                                    color:
                                                                        primaryColor,
                                                                    size: 14,
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          AppText(
                                                                    " ajah lekki lagos state"
                                                                        .toTitleCase(),
                                                                    size: 10,
                                                                    color: Colors
                                                                        .white,
                                                                    align: TextAlign
                                                                        .start,
                                                                    maxLine: 1,
                                                                  ))
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  10.0.sbW,
                                                  PriceWidget(
                                                    value:
                                                        model.orders[i].amount,
                                                    roundUp: true,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                            }),
                        25.0.sbH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText("Chats".toTitleCase(),
                                size: 14,
                                style: bodyTextStyle.copyWith(
                                    fontWeight: FontWeight.w600)),
                            InkWell(
                                onTap: model.navigateToChats,
                                child: AppText(
                                  AppStrings.viewAll,
                                  style: subUnderlineGreenStyle,
                                ))
                          ],
                        ),
                        16.0.sbH,
                        GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  4, // Adjust the number of columns as needed
                              crossAxisSpacing:
                                  8.0, // Adjust the spacing between items
                              mainAxisSpacing:
                                  16.0, // Adjust the spacing between rows
                            ),
                            itemCount:
                                model.isLoading && model.userMessages.isEmpty
                                    ? 4
                                    : (model.userMessages.length > 4
                                        ? 4
                                        : model.userMessages.length),
                            itemBuilder: (_, i) {
                              return model.isLoading &&
                                      model.userMessages.isEmpty
                                  ? const ShimmerCard()
                                  : AppCard(
                                      onTap: () => model.goToChatDetail(
                                          model.userMessages[i]),
                                      padding: 5.0.padA,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                CachedNetworkImageProvider(model
                                                        .userMessages[i]
                                                        .profileImage ??
                                                    ""),
                                            radius: 17.sp,
                                          ),
                                          10.0.sbH,
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: AppText(
                                                "${model.userMessages[i].firstName ?? ""} ${model.userMessages[i].lastName ?? ""}",
                                                align: TextAlign.center,
                                                isBold: true,
                                                size: 11,
                                                maxLine: 2,
                                              )),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                            }),
                      ],
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            4, // Adjust the number of columns as needed
                        crossAxisSpacing:
                            8.0, // Adjust the spacing between items
                        mainAxisSpacing:
                            16.0, // Adjust the spacing between rows
                      ),
                      itemCount: model.isLoading && model.categories.isEmpty
                          ? 8
                          : model.categories.length + 1,
                      itemBuilder: (_, i) {
                        return model.isLoading && model.categories.isEmpty
                            ? const ShimmerCard()
                            : AppCard(
                                onTap: () {
                                  if (i == model.categories.length) {
                                    model.goToViewMore();
                                  } else {
                                    model.onTap(model.categories[i]);
                                  }
                                },
                                padding: 0.0.padA,
                                backgroundColor: primaryColor.withOpacity(0.1),
                                radius: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    i == model.categories.length
                                        ? SvgPicture.asset(
                                            AppImages.more,
                                            height: 24,
                                            width: 24,
                                          )
                                        : Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                            model.categories[i]
                                                                    .image ??
                                                                ""))),
                                          ),
                                    10.0.sbH,
                                    AppText(
                                      i == model.categories.length
                                          ? AppStrings.more
                                          : model.categories[i].name ?? "",
                                      align: TextAlign.center,
                                      size: 13,
                                      isBold: true,
                                    )
                                  ],
                                ),
                              );
                      }),
              16.0.sbH,
              model.userService.isUserServiceProvider == false
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText("Popular Services".toTitleCase(),
                            size: 14,
                            style: bodyTextStyle.copyWith(
                                fontWeight: FontWeight.w600)),
                        8.0.sbH,
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: model.isLoading
                              ? 2
                              : model.serviceResponse?.length ?? 0,
                          itemBuilder: (_, i) {
                            ProviderUserResponse provider =
                                model.serviceResponse?[i] ??
                                    ProviderUserResponse();
                            return AppCard(
                              onTap: () => model.onTap(model.categories[i]),
                              key:
                                  UniqueKey(), // Add a unique key for each AppCard
                              bordered: true,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              backgroundColor: Colors.white,
                              borderWidth: 0.5,
                              padding: const EdgeInsets.all(20.0),
                              heights: 154,
                              child: model.isLoading
                                  ? const ShimmerCard()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            height: 114,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      provider.image?[i] ??
                                                          "https://via.placeholder.com/100x100",
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        const SizedBox(width: 22.0),
                                        SizedBox(
                                          height: 114,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    provider.companyName ?? "",
                                                    weight: FontWeight.w600,
                                                    size: 16.sp,
                                                  ),
                                                  const SizedBox(height: 5.0),
                                                  AppText(
                                                    "${provider.category?.serviceProviders}",
                                                    style: hintStyle,
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFF0065FF)
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const AppText(
                                                          AppStrings.from,
                                                          size: 12,
                                                          color:
                                                              Color(0xFF0065FF),
                                                          weight:
                                                              FontWeight.w500,
                                                        ),
                                                        PriceWidget(
                                                          value: double.tryParse(
                                                                  '${provider.amount ?? ""}') ??
                                                              0,
                                                          roundUp: true,
                                                          color: const Color(
                                                              0xFF0065FF),
                                                          fontSize: 12,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 3.0),
                                                  RatingBar.builder(
                                                    initialRating: double.tryParse(
                                                            "${provider.ratings ?? 0}") ??
                                                        0,
                                                    minRating: 0,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    ignoreGestures: true,
                                                    itemSize: 18,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 0.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      CupertinoIcons.star_fill,
                                                      color: Color(0xFFFFA000),
                                                      size: 12,
                                                    ),
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                            );
                          },
                        )
                      ],
                    )
                  : 0.0.sbHW
            ],
          ),
        ),
      ),
    );
  }
}

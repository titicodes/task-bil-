import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/svg_builder.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../constants/reuseables.dart';
import '../../../../../core/models/prodiders-service-response.dart';
import '../../../../base/base.ui.dart';
import '../../../../widgets/appCard.dart';
import '../../../../widgets/apptexts.dart';
import '../../../../widgets/indicator.dart';
import '../../../../widgets/price-widget.dart';
import 'provider-detail.vm.dart';

class ProviderDetailViewScreen extends StatelessWidget {
  const ProviderDetailViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProviderDetailViewViewModel>(
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: ListView(
                  padding: 0.0.padH,
                  children: [
                    Container(
                      height: 200,
                      width: width(context),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(model
                                          .serviceProvider.image !=
                                      null
                                  ? "https://api.taskitly.com${model.serviceProvider.image}"
                                  : "https://cdn.thewirecutter.com/wp-content/uploads/2018/10/basic-toolkit-lowres-0082.jpg"))),
                    ),
                    28.0.sbH,
                    Padding(
                      padding: 16.0.padH,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      model.serviceProvider.companyName ?? "",
                                      weight: FontWeight.w700,
                                      size: 24,
                                      color: primaryColor,
                                    ),
                                    8.0.sbH,
                                    AppText(
                                      model.serviceProvider.category?.name ??
                                          "",
                                      weight: FontWeight.w500,
                                      color: const Color(0xCC212936),
                                    ),
                                    12.0.sbH,
                                    Row(
                                      children: [
                                        Icon(
                                          Iconsax.location5,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                        5.0.sbW,
                                        AppText(
                                          "${model.serviceProvider.state ?? ""}, ${model.serviceProvider.country ?? ""}",
                                          weight: FontWeight.w500,
                                          size: 12,
                                          color: primaryColor,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              25.0.sbW,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
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
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
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
                                  10.0.sbH,
                                  AppCard(
                                    expandable: true,
                                    backgroundColor: const Color(0xFF0065FF)
                                        .withOpacity(0.1),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    radius: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const AppText(
                                          "From: ",
                                          color: Color(0xFF0065FF),
                                          weight: FontWeight.w500,
                                          size: 12,
                                        ),
                                        PriceWidget(
                                          value: double.tryParse(
                                                  "${model.serviceProvider.amount ?? 0}") ??
                                              0.0,
                                          color: const Color(0xFF0065FF),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          roundUp: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          24.0.sbH,
                          const AppText(
                            "Service Description",
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                          5.0.sbH,
                          Row(
                            children: [
                              Expanded(
                                  child: AppText(
                                model.serviceProvider.description ?? "",
                                size: 12,
                                align: TextAlign.start,
                              )),
                            ],
                          ),
                          30.0.sbH,
                          const AppText(
                            "Service Offered",
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                          5.0.sbH,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                model.serviceProvider.skills?.length ?? 0,
                                (index) => AppText(
                                    "${index + 1}. ${model.serviceProvider.skills?[index] ?? ""}")),
                          ),
                          30.0.sbH,
                        ],
                      ),
                    ),
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            padding: 5.0.padA,
                            margin: 16.0.padH,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: const Color(0xFFF2F2F2)),
                            child: TabBar(
                              indicatorColor: primaryColor,
                              labelPadding: 15.0.padH,
                              isScrollable: true,
                              unselectedLabelColor: const Color(0xFFA9A9A9),
                              unselectedLabelStyle: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                              labelColor: white,
                              indicator: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              tabs: const [
                                Tab(text: 'Working hours'),
                                Tab(text: 'Statistics'),
                                Tab(text: 'Reviews'),
                              ],
                            ),
                          ),
                          10.0.sbH,
                          SizedBox(
                            height: 160,
                            child: TabBarView(children: [
                              Padding(
                                padding: 16.0.padH,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AppCard(
                                      backgroundColor: Colors.transparent,
                                      bordered: true,
                                      borderColor:
                                          Theme.of(context).dividerColor,
                                      borderWidth: 0.7,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          AppText(
                                              "${(model.serviceProvider.weekdays?.first ?? "").toTitleCase()} - ${(model.serviceProvider.weekdays?.last ?? "").toTitleCase()}"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.access_time_filled_sharp,
                                                color: primaryColor,
                                                size: 16,
                                              ),
                                              AppText(
                                                " ${DateFormat("hh:mma").format(DateFormat("HH:mm:ss").parse(model.serviceProvider.startHour ?? ""))} - ${DateFormat("hh:mma").format(DateFormat("HH:mm:ss").parse(model.serviceProvider.endHour ?? ""))}",
                                                color: primaryColor,
                                                size: 13,
                                                weight: FontWeight.w500,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: 16.0.padH,
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: AppCard(
                                                backgroundColor:
                                                    Colors.transparent,
                                                bordered: true,
                                                borderColor: Theme.of(context)
                                                    .dividerColor,
                                                borderWidth: 0.7,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${(model.completionRate * 1).toStringAsFixed(1)}%', // Fixed to 1 decimal place
                                                      style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.5625.sp,
                                                        color: const Color(
                                                            0xff1cbf73),
                                                      ),
                                                    ),
                                                    5.0.sbH,
                                                    AppText(
                                                      "order completion"
                                                          .toTitleCase(),
                                                      size: 12.sp,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            16.0.sbW,
                                            Expanded(
                                              child: AppCard(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  bordered: true,
                                                  borderColor: Theme.of(context)
                                                      .dividerColor,
                                                  borderWidth: 0.7,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      AppText(
                                                        "89%",
                                                        color: primaryColor,
                                                        size: 20.sp,
                                                        isBold: true,
                                                      ),
                                                      5.0.sbH,
                                                      AppText(
                                                        "completion"
                                                            .toTitleCase(),
                                                        size: 12.sp,
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        )),
                                    16.0.sbH,
                                    Expanded(
                                      flex: 2,
                                      child: AppCard(
                                        backgroundColor: Colors.transparent,
                                        bordered: true,
                                        borderColor:
                                            Theme.of(context).dividerColor,
                                        borderWidth: 0.7,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppText(
                                              "Registered",
                                              size: 15.sp,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                AppCard(
                                                  expandable: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  bordered: true,
                                                  borderColor: Theme.of(context)
                                                      .dividerColor,
                                                  borderWidth: 0.7,
                                                  padding: 9.0.padA,
                                                  radius: 30,
                                                  child: Row(
                                                    children: [
                                                      buildSvgPicture(
                                                          image:
                                                              AppImages.ribbon,
                                                          size: 16),
                                                      AppText(model
                                                          .calculateTimeAgo(
                                                              "${model.serviceProvider.createdAt}"))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              model.serviceProvider.ratings == null ||
                                      model.serviceProvider.ratings?.length == 0
                                  ? const Center(
                                      child: AppText("No Rating yet"),
                                    )
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: PageView.builder(
                                            scrollDirection: Axis.horizontal,
                                            reverse: false,
                                            itemCount: model.serviceProvider
                                                    .ratings?.length ??
                                                0,
                                            controller: model.pageController,
                                            onPageChanged: model.onSelect,
                                            itemBuilder: (_, i) {
                                              return AppCard(
                                                bordered: true,
                                                borderColor: Theme.of(context)
                                                    .dividerColor,
                                                borderWidth: 0.7,
                                                backgroundColor:
                                                    Colors.transparent,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 9.sp,
                                                    vertical: 16.sp),
                                                margin: 5.0.padH,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 41.sp,
                                                      width: 41.sp,
                                                      decoration: ShapeDecoration(
                                                          shape:
                                                              const OvalBorder(),
                                                          image: DecorationImage(
                                                              image: CachedNetworkImageProvider(
                                                                  "https://api.taskitly.com/${model.serviceProvider.ratings?[i].profileImage ?? ""}"),
                                                              fit:
                                                                  BoxFit.fill)),
                                                    ),
                                                    10.sp.sbW,
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              AppText(
                                                                model
                                                                        .serviceProvider
                                                                        .ratings?[
                                                                            i]
                                                                        .name ??
                                                                    "",
                                                                size: 11.sp,
                                                              ),
                                                              15.sp.sbW,
                                                              RatingBar.builder(
                                                                initialRating: model
                                                                        .serviceProvider
                                                                        .ratings?[
                                                                            i]
                                                                        .rating ??
                                                                    0,
                                                                minRating: 0,
                                                                direction: Axis
                                                                    .horizontal,
                                                                allowHalfRating:
                                                                    true,
                                                                ignoreGestures:
                                                                    true,
                                                                itemSize: 12.sp,
                                                                itemCount: 5,
                                                                itemPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            0.0),
                                                                itemBuilder:
                                                                    (context,
                                                                            _) =>
                                                                        Icon(
                                                                  CupertinoIcons
                                                                      .star_fill,
                                                                  color: const Color(
                                                                      0xFFFFA000),
                                                                  size: 12.sp,
                                                                ),
                                                                onRatingUpdate:
                                                                    (rating) {},
                                                              ),
                                                            ],
                                                          ),
                                                          5.sp.sbH,
                                                          AppText(
                                                            model.formatDate(model
                                                                    .serviceProvider
                                                                    .ratings?[i]
                                                                    .createdAt ??
                                                                ""),
                                                            size: 11.sp,
                                                          ),
                                                          16.sp.sbH,
                                                          Expanded(
                                                            child: AppText(
                                                              model
                                                                      .serviceProvider
                                                                      .ratings?[
                                                                          i]
                                                                      .comment ??
                                                                  "No Comment",
                                                              size: 11.sp,
                                                              color:
                                                                  hintTextColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        10.sp.sbH,
                                        Indicators(
                                            initial: model.serviceProvider
                                                    .ratings?.length ??
                                                0,
                                            current: model.currentIndex),
                                      ],
                                    ),
                            ]),
                          )
                        ],
                      ),
                    ),
                    20.0.sbH,
                  ],
                )),
                Container(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1,
                              color: hintTextColor.withOpacity(0.3)))),
                  child: SafeArea(
                    top: false,
                    bottom: true,
                    child: Row(
                      children: [
                        AppButton(
                          isTransparent: true,
                          isExpanded: false,
                          borderColor: errorColor,
                          onTap: () => model.showDispute(model),
                          child: Padding(
                            padding: 16.sp.padH,
                            child: Icon(
                              Icons.thumb_down_off_alt_sharp,
                              color: errorColor,
                            ),
                          ),
                        ),
                        16.sp.sbW,
                        Expanded(
                          child: AppButton(
                            text: "Chat Now",
                            onTap: model.onTap,
                            backGroundColor: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            IntrinsicHeight(
              child: AppBars(
                backgroundColor: Colors.transparent,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(17.5),
                      onTap: () => model.bookMarkedProvider.any((element) =>
                              element.uid == model.serviceProvider.uid)
                          ? model.removeBookMark(model.serviceProvider)
                          : model.bookMark(model.serviceProvider),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade400.withOpacity(0.6),
                        radius: 17.5,
                        child: Icon(
                          model.bookMarkedProvider.any((element) =>
                                  element.uid == model.serviceProvider.uid)
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: textColor,
                          size: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

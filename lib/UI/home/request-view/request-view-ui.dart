import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/shimmer_loaders.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../base/base.ui.dart';
import 'package:badges/badges.dart' as badges;
import '../../widgets/appbar.dart';
import 'active/active-ui.dart';
import 'canceled/canceled-view.dart';
import 'completed/completed-view.dart';
import 'request-view-vm.dart';

class RequestViewScreen extends StatelessWidget {
  final ValueNotifier<int> someValueNotifier;
  const RequestViewScreen({super.key, required this.someValueNotifier});

  @override
  Widget build(BuildContext context) {
    return BaseView<RequestViewViewModel>(
      notDefaultLoading: true,
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          leading: 0.0.sbH,
          title: Row(
            children: [
              Expanded(
                child: AppText(
                  AppStrings.trackRequest,
                  size: 16.sp,
                  weight: FontWeight.w600,
                  align: TextAlign.start,
                ),
              ),
              15.0.sbW,
              InkWell(
                onTap: model.chat,
                child: badges.Badge(
                  showBadge: true,
                  badgeContent: ValueListenableBuilder(
                      valueListenable: someValueNotifier,
                      builder: (context, value, child) {
                        return AppText(
                          value.toString(),
                          size: 8,
                          weight: FontWeight.w600,
                          color: white,
                        );
                      }),
                  badgeStyle: badges.BadgeStyle(
                    // padding: EdgeInsets.only(bottom: 30, left: 30),
                    badgeColor: primaryColor,
                  ),
                  child: const Icon(
                    CupertinoIcons.chat_bubble_text,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: DefaultTabController(
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
                          Tab(text: 'Active'),
                          Tab(text: 'Canceled'),
                          Tab(text: 'Completed'),
                        ],
                      ),
                    ),
                    10.0.sbH,
                    Expanded(
                      child: StreamBuilder(
                          stream: model.getOrderServices(),
                          builder: (context, snapshot) {
                            // List<Results> orders = snapshot.data??[];
                            // print(orders.length);
                            return TabBarView(children: [
                              snapshot.data ==
                                      null
                                  ? const ListLoader()
                                  : ActiveView(
                                      model: model,
                                      orders: model.orders
                                          .where((order) =>
                                              order
                                                      .status
                                                      ?.toLowerCase() ==
                                                  'active' ||
                                              order
                                                      .status
                                                      ?.toLowerCase() ==
                                                  'ongoing' ||
                                              order.status?.toLowerCase() ==
                                                  'ongoin' ||
                                              order.status?.toLowerCase() ==
                                                  'done')
                                          .toList()),
                              snapshot.data == null
                                  ? const ListLoader()
                                  : CanceledView(
                                      model: model,
                                      orders: model.orders
                                          .where((order) =>
                                              order.status?.toLowerCase() ==
                                              'cancelled')
                                          .toList()),
                              snapshot.data == null
                                  ? const ListLoader()
                                  : CompletedView(
                                      model: model,
                                      orders: model.orders
                                          .where((order) =>
                                              order.status?.toLowerCase() ==
                                              'completed')
                                          .toList()),
                            ]);
                          }),
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

class ListLoader extends StatelessWidget {
  const ListLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (_, i) => Container(
              width: width(context),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 150,
              child: const ShimmerCard(),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../core/models/get-order-response-model.dart';
import '../../../../utils/utils.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/request-card-widget.dart';
import '../request-view-vm.dart';

class ActiveView extends StatelessWidget {
  final RequestViewViewModel model;
  List<Results> orders = [];
  ActiveView({super.key, required this.model, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (orders.isEmpty)
          const Center(
            child: Text(
              'No active orders available',
              style: TextStyle(fontSize: 18),
            ),
          )
        else
          Container(
            height: height(context),
            width: width(context),
            padding: 16.0.padH,
            color: Colors.transparent,
            child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (_, i) {
                  Results order = orders[i];
                  return RequestCard(
                    valid: order.valid ?? false,
                    status: order.status == "ongoin"
                        ? "ongoing"
                        : order.status ?? "",
                    serviceType: order.service?.category?.name ?? "",
                    serviceImage: order.service?.category?.image ??
                        "https://cdn-icons-png.flaticon.com/128/4382/4382040.png",
                    date: model.formatDateTime(
                        "${order.date}"), //Utils.toDates(DateTime.parse("2023-05-01")),
                    time: Utils.toTime(DateTime.parse("2023-05-01")),
                    amount: order.amount.toString(),
                    customerProviderName:
                        model.userService.isUserServiceProvider
                            ? ("${order.customer?.username}").toTitleCase()
                            : (order.provider?.username ?? "").toTitleCase(),
                    customerProviderPic: model.userService.isUserServiceProvider
                        ? order.customer?.profileImage ?? ""
                        : order.provider?.profileImage ?? "",
                    orderNumber: ("${order.orderId}")
                        .substring(("${order.orderId}").length - 2),
                    location: model.userService.isUserServiceProvider
                        ? "ajah lekki lagos state".toTitleCase()
                        : null,
                    isServiceProvider: model.userService.isUserServiceProvider,
                    haveButtons: true,
                    cancel: () => model.popUp(
                        "Cancel Service",
                        () => model.userService.isUserServiceProvider
                            ? (order.valid == true
                                ? model.cancelOrder("${order.uid}")
                                : model.cancel("${order.uid}"))
                            : order.valid == true
                                ? model.cancelOrder("${order.uid}")
                                : model.cancel("${order.uid}"),
                        subtitle: AppStrings.cancelPopMessage),
                    accept: () => model.popUp(
                        "Accept Service", () => model.accept("${order.uid}"),
                        subtitle: "Do you want to accept this service"),
                    start: () => model.popUp(
                        "Start", () => model.start("${order.uid}"),
                        subtitle: AppStrings.startServices),
                    done: () => model.popUp(
                        "Completed Service",
                        model.userService.isUserServiceProvider
                            ? () => model.done("${order.uid}")
                            : () => model.confirm("${order.uid}"),
                        subtitle: AppStrings.doneServices),
                    report: () => model.report(
                        order.orderId ?? "",
                        order.uid ?? "",
                        model.userService.isUserServiceProvider
                            ? ("${order.customer?.username}").toTitleCase()
                            : (order.provider?.username ?? "").toTitleCase()),
                    confirm: () => model.popUp(
                        "Confirm", () => model.confirm("${order.uid}"),
                        subtitle: AppStrings.confirmPopMessage),
                    useButton: order.status == "active" ? "start" : "done",
                  );
                }),
          ),
        model.isLoading ? const SmallLoader() : const SizedBox(),
      ],
    );
  }
}

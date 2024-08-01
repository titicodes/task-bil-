import 'package:flutter/material.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../core/models/get-order-response-model.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/request-card-widget.dart';
import '../request-view-vm.dart';

class CompletedView extends StatelessWidget {
  final RequestViewViewModel model;
  List<Results> orders = [];
  CompletedView({super.key, required this.model, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (orders.isEmpty)
          const Center(
            child: Text(
              'No completed orders available',
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
                    orderID: model.userService.isUserServiceProvider
                        ? null
                        : "457686FHTHD",
                    isServiceProvider: model.userService.isUserServiceProvider,
                    review: () => model.review(order.uid ?? ""),
                  );
                }),
          ),
      ],
    );
  }
}

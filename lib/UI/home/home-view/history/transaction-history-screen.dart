import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/home/home-view/history/tansaction-history-view-vm.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
// import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/history-card.dart';
import 'package:taskitly/constants/palette.dart';
// import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../utils/shimmer_loaders.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/appbar.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionHistoryViewModel>(
      notDefaultLoading: true,
      onModelReady: (m) => m.init(context),
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Transactions",
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       6.0.sbW,
            //       InkWell(
            //         onTap: () {
            //           model.isVisible = true;
            //           model.notifyListeners();
            //         }, //
            //         child: Row(
            //           children: [
            //             SizedBox(
            //               width: 150,
            //               height: 50,
            //               child: Row(
            //                 children: [
            //                   AppText(
            //                     model.selectedCategory ?? "All Categories",
            //                     isBold: true,
            //                     color: hintTextColor,
            //                     weight: FontWeight.w500,
            //                     size: 15,
            //                   ),
            //                   10.0.sbW,
            //                   const Icon(Icons.arrow_drop_down)
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       const Spacer(),
            //       InkWell(
            //         onTap: () {},
            //         child: Row(
            //           children: [
            //             SizedBox(
            //               width: 150,
            //               height: 50,
            //               child: DropdownButtonFormField<String>(
            //                 decoration:
            //                     const InputDecoration(border: InputBorder.none),
            //                 hint: AppText(
            //                   "All",
            //                   isBold: true,
            //                   color: hintTextColor,
            //                   weight: FontWeight.w500,
            //                   size: 15,
            //                 ),
            //                 value: model.dropdownValue,
            //                 onChanged: (String? newValue) {
            //                   model.dropdownValue = newValue!;
            //                 },
            //                 isExpanded: true,
            //                 items: <String>[
            //                   'All',
            //                   'Successful',
            //                   'Pending',
            //                   'Reversed',
            //                   'Failed'
            //                 ].map<DropdownMenuItem<String>>((String value) {
            //                   return DropdownMenuItem<String>(
            //                     value: value,
            //                     child: Text(value),
            //                   );
            //                 }).toList(),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       //20.0.sbW,
            //     ],
            //   ),
            // ),
            // Visibility(
            //   visible: model.isVisible,
            //   child: GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount:
            //             3, // You can change the number of columns here
            //         crossAxisSpacing: 5.0,
            //         // mainAxisSpacing: 8.0,
            //         childAspectRatio: 1.9),
            //     itemCount: model.cats.length,
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     padding: const EdgeInsets.all(16),
            //     itemBuilder: (_, i) {
            //       String cat = model.cats[i];
            //       return GestureDetector(
            //         onTap: () {
            //           model.select(cat);
            //           model.isVisible = false;
            //           model.notifyListeners();
            //           print(model.selectedCategory);
            //         },
            //         child: IntrinsicHeight(
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.stretch,
            //             children: [
            //               Expanded(
            //                 child: AppCard(
            //                   margin: const EdgeInsets.only(bottom: 10.0),
            //                   borderWidth: 1,
            //                   bordered:
            //                       model.selectedCategory == cat ? true : false,
            //                   padding: 16.0.padA,
            //                   child: Center(
            //                     child: AppText(
            //                       cat,
            //                       size: 12,
            //                       color: const Color(0xFF6B6B6B),
            //                       isBold: true,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // const Divider(),
            // 10.0.sbH,
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0),
            //   child: AppText(
            //     "October".toTitleCase(),
            //     size: 14,
            //     isBold: true,
            //     color: hintTextColor,
            //     weight: FontWeight.w500,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0),
            //   child: Row(
            //     children: [
            //       Container(
            //           height: 30,
            //           decoration: const ShapeDecoration(
            //             image: DecorationImage(
            //                 image: CachedNetworkImageProvider(""),
            //                 fit: BoxFit.cover),
            //             shape: OvalBorder(),
            //           )),
            //       const AppText(
            //         "In: ₦1,000.06",
            //         weight: FontWeight.w300,
            //         size: 12,
            //       ),
            //       20.0.sbW,
            //       const AppText(
            //         "Out: ₦3,000.00",
            //         weight: FontWeight.w400,
            //         size: 12,
            //       ),
            //     ],
            //   ),
            // ),
            // 13.0.sbH,
            Expanded(
              child: StreamBuilder(
                  stream: model.getHistories(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: snapshot.data == null
                            ? 4
                            : model.transactionHistory?.reversed.length,
                        padding: EdgeInsets.only(
                            top: 16.sp, left: 16.sp, right: 16.sp),
                        itemBuilder: (_, i) {
                          return snapshot.data == null ||
                                  model.transactionHistory!.isEmpty
                              ? Container(
                                  margin: 8.sp.padB,
                                  height: 50,
                                  width: width(context),
                                  child: const ShimmerCard(),
                                )
                              : AppCard(
                                  backgroundColor: Colors.white,
                                  borderColor: secondaryDarkColor,
                                  padding: 16.0.padV,
                                  margin: 4.0.padV,
                                  useShadow: true,
                                  child: TransactionHistoryCard(
                                    onTap: () {
                                      //model.transactionHistoryDetails();
                                    }, //model.general[i]['onTap'],
                                    icon: (model.transactionHistory?[i]
                                                .transactionType
                                                ?.contains('funding') ??
                                            false)
                                        ? Icon(
                                            Icons.add,
                                            color: primaryColor,
                                          )
                                        : const Icon(
                                            Icons.remove,
                                            color: Colors.red,
                                          ),
                                    text: model.transactionHistory?[i]
                                            .transactionType ??
                                        "",

                                    dateText: model.formatDate(
                                        model.transactionHistory?[i].created ??
                                            ""),

                                    amountText:
                                        model.transactionHistory?[i].amount ??
                                            "",
                                    status:
                                        model.transactionHistory?[i].status ??
                                            "",
                                  ),
                                );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

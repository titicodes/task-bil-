import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/core/localization/app_localization.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../constants/reuseables.dart';
import '../../base/base.ui.dart';
import '../../widgets/appbar.dart';
import '../../widgets/apptexts.dart';
import 'bill-view-vm.dart';

class BillViewScreen extends StatelessWidget {
  const BillViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<BillViewViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          leading: 0.0.sbH,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(AppStrings.payBills),
            ],
          ),
          elevation: 1.5,
        ),
        body: Padding(
          padding: 16.0.padA,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.0.sbH,
              AppText(
                "lbl_utilities".tr,
                size: 15,
              ),
              32.0.sbH,
              Padding(
                padding: 11.0.padH,
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: model.utilities.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 7.0,
                      mainAxisSpacing: 10.0, // padding bottom
                      childAspectRatio:
                          1.5, // Adjust the aspect ratio as needed
                      // Set the itemExtent to fix the height of each item
                      // You may need to adjust the value based on your design
                      mainAxisExtent: 44.0,
                    ),
                    itemBuilder: (_, i) {
                      return AppCard(
                        onTap: () =>
                            model.goToDetail(model.utilities[i]["title"]),
                        margin: 0.0.padA,
                        padding: 5.0.padA,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              model.utilities[i]["icon"],
                              height: 24.sp,
                              width: 24.sp,
                            ),
                            5.0.sbW,
                            Expanded(
                                child: AppText(
                              model.utilities[i]["title"],
                              size: 12.sp,
                              overflow: TextOverflow.ellipsis,
                              maxLine: 1,
                            ))
                          ],
                        ),
                      );
                    }),
              ),
              78.0.sbH,
              AppText(
                "lbl_others".tr.toTitleCase(),
                size: 15,
              ),
              32.0.sbH,
              Padding(
                padding: 11.0.padH,
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: model.others.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7.0,
                      mainAxisSpacing: 10.0, // padding bottom
                      childAspectRatio:
                          1.5, // Adjust the aspect ratio as needed
                      // Set the itemExtent to fix the height of each item
                      // You may need to adjust the value based on your design
                      mainAxisExtent: 44.0,
                    ),
                    itemBuilder: (_, i) {
                      return AppCard(
                        onTap: () => model.goToDetail(model.others[i]["title"]),
                        margin: 0.0.padA,
                        padding: 5.0.padA,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              model.others[i]["icon"],
                              height: 24.sp,
                              width: 24.sp,
                            ),
                            5.0.sbW,
                            Expanded(
                                child: AppText(
                              model.others[i]["title"],
                              size: 12.sp,
                              overflow: TextOverflow.ellipsis,
                              maxLine: 1,
                            ))
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

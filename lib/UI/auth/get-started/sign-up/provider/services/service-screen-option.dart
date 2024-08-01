import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../../constants/palette.dart';
import '../../../../../../constants/reuseables.dart';
import '../../../../../../core/models/all_selected_categories_list.dart';
import '../../../../../widgets/apptexts.dart';

class ServiceScreenOption extends StatelessWidget {
  final List<Category> categories;
  final Function(Category) selectCategory;
  const ServiceScreenOption(
      {super.key, required this.categories, required this.selectCategory});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * 0.7,
      child: Column(
        children: [
          15.0.sbH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.0.sbW,
              AppText(
                "Select service".toTitleCase(),
                size: 18.sp,
                weight: FontWeight.w600,
              ),
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
              ),
            ],
          ),
          15.0.sbH,
          ListView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              itemBuilder: (_, i) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      await selectCategory(categories[i]);
                      navigationService.goBack();
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 15),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: hintTextColor.withOpacity(0.3),
                                  width: 0.5))),
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        categories[i].name ?? "",
                        isBold: true,
                        size: 12,
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

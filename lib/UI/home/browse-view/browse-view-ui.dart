import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/text_field.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../core/models/all_selected_categories_list.dart';
import '../../base/base.ui.dart';
import '../../widgets/apptexts.dart';
import 'browse-view-vm.dart';

class BrowseViewScreen extends StatelessWidget {
  const BrowseViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<BrowseViewViewModel>(
      notDefaultLoading: true,
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => RefreshIndicator(
        onRefresh: () async => model.init(),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: 16.0.padA,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: model.searchController,
                          onChanged: (val) {
                            model.filterCategory();
                          },
                          prefix: const Icon(CupertinoIcons.search),
                          hint: AppStrings.searchServices,
                          contentPadding: const EdgeInsets.all(7),
                        ),
                      ),
                      16.0.sbW,
                      Padding(
                        padding: 5.0.padB,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(17.5),
                          onTap: model.navigateToBookmark,
                          child: CircleAvatar(
                            backgroundColor: primaryColor.withOpacity(0.1),
                            radius: 17.5,
                            child: Icon(
                              Icons.bookmark,
                              color: primaryColor,
                              size: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: GridView.builder(
                  padding: 16.0.padA,
                  itemCount: model.displayCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 1.5, // Adjust the aspect ratio as needed
                    // Set the itemExtent to fix the height of each item
                    // You may need to adjust the value based on your design
                    mainAxisExtent: 129.0,
                  ),
                  itemBuilder: (_, i) {
                    Category category = model.displayCategories[i];

                    return AppCard(
                      onTap: () => model.onTap(category),
                      padding: 10.0.padA,
                      backgroundColor: const Color(0xFFF7F7F7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        category.image ?? ""))),
                          ),
                          AppText(
                            category.name ?? "",
                            align: TextAlign.center,
                            maxLine: 2,
                            size: 13,
                            weight: FontWeight.w600,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: 5.0.padA,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6F0FF),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.groups,
                                        size: 16,
                                        color: Color(0xFF0065FF),
                                      ),
                                      Expanded(
                                          child: FittedBox(
                                              child: AppText(
                                        " ${category.serviceProviders ?? 0} Providers",
                                        color: const Color(0xFF0065FF),
                                        size: 12,
                                        maxLine: 1,
                                      )))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

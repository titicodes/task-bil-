import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/shimmer_loaders.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../base/base.ui.dart';
import '../../../widgets/text_field.dart';
import 'category-detail.vm.dart';
import 'tab-screens/all.dart';

class CategoryDetailTab extends StatelessWidget {
  const CategoryDetailTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryDetailTabViewModel>(
      notDefaultLoading: true,
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          text: model.category.name ?? "",
        ),
        body: Padding(
          padding: 16.0.padH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              16.0.sbH,
              AppTextField(
                controller: model.searchController,
                onChanged: (val) {
                  model.filter();
                },
                prefix: const Icon(CupertinoIcons.search),
                hint: "Search for ${model.category.name}",
                contentPadding: const EdgeInsets.all(7),
              ),
              5.0.sbH,
              AppText(
                "showing result of ${model.filteredProviders.length} plumbing service",
                color: primaryColor,
              ),
              21.0.sbH,
              Expanded(
                  child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        labelPadding: 25.0.padH,
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
                          Tab(text: 'All'),
                          Tab(text: 'Active'),
                        ],
                      ),
                    ),
                    10.0.sbH,
                    Expanded(
                      child: model.providers.isEmpty && model.isLoading
                          ? ListView.builder(
                              itemCount: 3,
                              itemBuilder: (_, i) => Container(
                                    margin: 16.0.padB,
                                    height: 170,
                                    width: width(context),
                                    child: const ShimmerCard(),
                                  ))
                          : TabBarView(children: [
                              AllServiceTab(
                                bookMarkedProvider: model.bookMarkedProvider,
                                bookmark: model.bookMark,
                                providers: model.filteredProviders,
                                navigateToDetail: model.navigateToDetails,
                                removeBookmark: model.removeBookMark,
                              ),
                              AllServiceTab(
                                bookmark: model.bookMark,
                                bookMarkedProvider: model.bookMarkedProvider,
                                providers: model.filteredProviders
                                    .where((element) =>
                                        element.provider?.isOnline == true)
                                    .toList(),
                                navigateToDetail: model.navigateToDetails,
                                removeBookmark: model.removeBookMark,
                              ),
                            ]),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

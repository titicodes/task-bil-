import 'package:flutter/material.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../core/models/prodiders-service-response.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/apptexts.dart';
import '../category-detail-tab/tab-screens/all.dart';
import 'bookmark-vm.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<BookmarkViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Bookmarked Providers",
        ),
        body: model.bookMarkedProvider.isEmpty
            ? const Center(
                child: AppText("No Bookmarked Service provider"),
              )
            : ListView.builder(
                padding: 16.0.padH,
                itemCount: model.bookMarkedProvider.length,
                itemBuilder: (_, i) {
                  ProviderUserResponse provider = model.bookMarkedProvider[i];
                  return ProviderCard(
                    name: provider.companyName ?? "",
                    description: (provider.description ?? "").toTitleCase(),
                    startPrice: "${provider.amount ?? 0}",
                    distance:
                        "${provider.state ?? ""}, ${provider.country ?? ""}",
                    completePercent: "96",
                    orders: provider.orders ?? 0,
                    rating: Ratings.calculateAverageRating(provider.ratings),
                    verified: true,
                    onTap: () => model.navigateToDetails(provider),
                    bookmark: (val) => model.removeBookMark(provider),
                    bookmarked: model.bookMarkedProvider
                        .any((element) => element.uid == provider.uid),
                  );
                }),
      ),
    );
  }
}

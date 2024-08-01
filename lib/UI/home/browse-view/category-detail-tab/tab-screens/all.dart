import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/price-widget.dart';
import 'package:taskitly/UI/widgets/svg_builder.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../../core/models/prodiders-service-response.dart';

class AllServiceTab extends StatelessWidget {
  final Function(ProviderUserResponse) bookmark;
  final Function(ProviderUserResponse) removeBookmark;
  final Function(ProviderUserResponse) navigateToDetail;
  final List<ProviderUserResponse> providers;
  final List<ProviderUserResponse> bookMarkedProvider;
  const AllServiceTab(
      {super.key,
      required this.bookmark,
      required this.providers,
      required this.navigateToDetail,
      required this.bookMarkedProvider,
      required this.removeBookmark});

  @override
  Widget build(BuildContext context) {
    return providers.isEmpty
        ? const Center(
            child: AppText("No Service provider"),
          )
        : ListView.builder(
            padding: 3.0.padH,
            itemCount: providers.length,
            itemBuilder: (_, i) {
              ProviderUserResponse provider = providers[i];
              return ProviderCard(
                name: provider.companyName ?? "",
                description: (provider.description ?? "").toTitleCase(),
                startPrice: "${provider.amount ?? 0}",
                distance: "${provider.state ?? ""}, ${provider.country ?? ""}",
                completePercent: "96",
                orders: provider.orders ?? 0,
                rating: Ratings.calculateAverageRating(provider.ratings),
                verified: true,
                onTap: () => navigateToDetail(provider),
                bookmark: (val) => bookMarkedProvider
                        .any((element) => element.uid == provider.uid)
                    ? removeBookmark(provider)
                    : bookmark(provider),
                bookmarked: bookMarkedProvider
                    .any((element) => element.uid == provider.uid),
              );
            });
  }
}

class ProviderCard extends StatelessWidget {
  final String name;
  final String description;
  final String startPrice;
  final String distance;
  final String completePercent;
  final int orders;
  final bool verified;
  final bool bookmarked;
  final double rating;
  final VoidCallback onTap;
  final Function(String) bookmark;
  const ProviderCard({
    super.key,
    required this.name,
    required this.description,
    required this.startPrice,
    required this.distance,
    required this.completePercent,
    required this.orders,
    required this.rating,
    required this.bookmark,
    required this.verified,
    required this.onTap,
    required this.bookmarked,
  });

  @override
  Widget build(BuildContext context) {
    print(bookmarked);
    return AppCard(
      onTap: onTap,
      bordered: true,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      margin: 12.0.padB,
      backgroundColor: Colors.white.withOpacity(0.3),
      borderColor: primaryColor,
      borderWidth: 0.5,
      radius: 8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppText(
                          name,
                          weight: FontWeight.w600,
                          size: 16,
                        ),
                        5.0.sbW,
                        verified
                            ? buildSvgPicture(
                                image: AppImages.badge,
                                size: 12,
                                color: primaryColor)
                            : 0.0.sbH
                      ],
                    ),
                    5.0.sbH,
                    Row(
                      children: [
                        Expanded(
                            child: AppText(
                          description,
                          overflow: TextOverflow.ellipsis,
                          size: 12,
                          color: hintTextColor,
                          maxLine: 2,
                        )),
                      ],
                    )
                  ],
                ),
              ),
              16.0.sbW,
              InkWell(
                borderRadius: BorderRadius.circular(17.5),
                onTap: () => bookmark("Val"),
                child: CircleAvatar(
                  backgroundColor: primaryColor.withOpacity(0.1),
                  radius: 17.5,
                  child: Icon(
                    bookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: primaryColor,
                    size: 16,
                  ),
                ),
              )
            ],
          ),
          14.0.sbH,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppCard(
                expandable: true,
                backgroundColor: const Color(0xFF0065FF).withOpacity(0.1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                radius: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const AppText(
                      "From: ",
                      color: Color(0xFF0065FF),
                      weight: FontWeight.w500,
                      size: 10,
                    ),
                    PriceWidget(
                      value: double.tryParse(startPrice) ?? 0.0,
                      color: const Color(0xFF0065FF),
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      roundUp: true,
                    ),
                  ],
                ),
              ),
              25.0.sbW,
              const Icon(
                Iconsax.location5,
                color: Colors.black,
                size: 16,
              ),
              5.0.sbW,
              AppText(
                distance,
                isBold: true,
                size: 12,
              )
            ],
          ),
          14.0.sbH,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildSvgPicture(image: AppImages.orderSvg, size: 16),
              4.0.sbW,
              AppText(
                "$orders Orders",
                size: 11,
                color: const Color(0xFF8842F0),
              ),
              7.0.sbW,
              buildSvgPicture(image: AppImages.percentSvg, size: 16),
              4.0.sbW,
              AppText("$completePercent% completed",
                  size: 11, color: primaryColor),
              7.0.sbW,
              buildSvgPicture(image: AppImages.starSvg, size: 16),
              4.0.sbW,
              AppText("$rating", size: 11, color: const Color(0xFFFFA000)),
            ],
          )
        ],
      ),
    );
  }
}

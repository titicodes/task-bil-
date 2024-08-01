import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../routes/routes.dart';
import '../../base/base.ui.dart';
import '../../widgets/appbar.dart';
import '../../widgets/setting-card.dart';
import 'settings-view-vm.dart';

class SettingsViewScreen extends StatelessWidget {
  const SettingsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewViewModel>(
      onModelReady: (model) => model.init(),
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          text: "Settings",
          leading: 0.0.sbH,
        ),
        body: ListView(
          padding: 16.0.padA,
          children: [
            Row(
              children: [
                Container(
                    height: 45,
                    width: 45,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              model.user.profileImage ?? ""),
                          fit: BoxFit.cover),
                      shape: const OvalBorder(),
                    )),
                6.0.sbW,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "${model.user.firstName ?? ""} ${model.user.lastName}",
                      weight: FontWeight.w600,
                      size: 15,
                    ),
                    AppText(
                      "@${model.user.username ?? ""}",
                      size: 13,
                      color: hintTextColor,
                    ),
                  ],
                )
              ],
            ),
            32.0.sbH,
            AppText(
              "general settings".toTitleCase(),
              size: 13,
              color: hintTextColor,
              weight: FontWeight.w500,
            ),
            13.0.sbH,
            AppCard(
              backgroundColor: Colors.white,
              borderColor: secondaryDarkColor,
              padding: 16.0.padV,
              useShadow: true,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.general.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, i) {
                    return SettingCard(
                        onTap: model.general[i]['onTap'],
                        icon: model.general[i]['image'],
                        text: model.general[i]['text']);
                  }),
            ),
            16.0.sbH,
            AppText(
              "security settings".toTitleCase(),
              size: 13,
              color: hintTextColor,
              weight: FontWeight.w500,
            ),
            13.0.sbH,
            AppCard(
              backgroundColor: Colors.white,
              borderColor: secondaryDarkColor,
              padding: 16.0.padV,
              useShadow: true,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.security.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) {
                        return SettingCard(
                          onTap: model.security[i]['isLogout'] == true
                              ? () => model.logOuts(context)
                              : model.security[i]['onTap'],
                          icon: model.security[i]['image'],
                          text: model.security[i]['text'],
                          isLogout: model.security[i]['isLogout'],
                        );
                      }),
                  SettingCard(
                    onTap: () =>
                        navigationService.navigateTo(deleteMyAccountRoute),
                    icon: AppImages.delete,
                    isLogout: true,
                    text: "delete account".toTitleCase(),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      weight: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/routes/routes.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/palette.dart';
import '../../../auth/forget-password/verify-password/verify-password-ui.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/bottomSheet.dart';
import '../../../widgets/setting-card.dart';
import 'blocked-user/block-user-ui.dart';
import 'change-pin/change_pin_view.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBars(
        text: AppStrings.security,
      ),
      body: ListView(
        padding: 16.0.padA,
        children: [
          AppText(
            "Secure your account".toTitleCase(),
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
            child: Column(
              children: [
                // changePinRoute
                SettingCard(
                  onTap: () {
                    cache.comingFromChangePin = true;
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      isDismissible: false,
                      builder: (_) =>
                          const BottomSheetScreen(child: NewChangePinView()),
                    );
                  },
                  icon: AppImages.security,
                  text: "change pin".toTitleCase(),
                ),
                // SettingCard(
                //   onTap: () {
                //     cache.comingFromChangePin = true;
                //     showModalBottomSheet(
                //       backgroundColor: Colors.transparent,
                //       context: context,
                //       isScrollControlled: true,
                //       isDismissible: false,
                //       builder: (_) => const BottomSheetScreen(
                //           child: VerifyPasswordScreen()),
                //     );
                //   },
                //   icon: AppImages.security,
                //   text: "change pin".toTitleCase(),
                // ),
                // changePasswordRoute
                SettingCard(
                  onTap: () =>
                      navigationService.navigateTo(changePasswordRoute),
                  icon: AppImages.security,
                  text: "change password".toTitleCase(),
                ),
                SettingCard(
                  onTap: () => navigationService
                      .navigateToWidget(const BlockUserScreen()),
                  icon: AppImages.security,
                  text: "Blocked Users".toTitleCase(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/palette.dart';
import '../../../../constants/reuseables.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/appCard.dart';
import '../../../widgets/setting-card.dart';
import 'verification-home.vm.dart';

class VerificationHomeView extends StatelessWidget {
  const VerificationHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<VerificationHomeViewModel>(
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Finish up Registration",
        ),
        body: ListView(
          padding: 16.0.padA,
          children: [
            AppText(
              "We need this information to complete your verification",
              size: 12.sp,
              color: const Color(0xFF6B6B6B),
              align: TextAlign.center,
            ),
            20.0.sbH,
            AppCard(
              backgroundColor: Colors.white,
              borderColor: secondaryDarkColor,
              padding: 16.0.padV,
              useShadow: true,
              child: Column(
                children: [
                  model.userService.isUserServiceProvider
                      ? SettingCard(
                          onTap: model.goToVerify,
                          icon: AppImages.profile,
                          text: "KYC Verification",
                        )
                      : 0.0.sbH,
                  model.bvnVerified
                      ? 0.0.sbH
                      : SettingCard(
                          onTap: model.goToBvn,
                          icon: AppImages.bvn,
                          text: "BVN Verification",
                        ),
                  model.emailVerified
                      ? 0.0.sbH
                      : SettingCard(
                          onTap: model.verifyEmail,
                          icon: AppImages.mail,
                          text: "Verify Email",
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

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../../../../routes/routes.dart';
import '../../../base/base.vm.dart';

class ReferAndWinHomeViewModel extends BaseViewModel {
  late BuildContext context;

  copyCode() async {
    FlutterClipboard.copy(userService.user.referalCode ?? "").then((value) {
      final snackBar = SnackBar(
        content:
            Text('${userService.user.referalCode ?? ""} copied to clipboard!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  navigateToSuccess() {
    navigationService.navigateTo(successfulRewardRoute);
  }

  navigateToReward() {
    navigationService.navigateTo(rewardRoute);
  }

  navigateToReferralHistory() {
    navigationService.navigateTo(referralsHistoryRoute);
  }
}

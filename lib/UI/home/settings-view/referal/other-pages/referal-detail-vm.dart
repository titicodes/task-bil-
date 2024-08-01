import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../../../../../routes/routes.dart';
import '../../../../base/base.vm.dart';

class ReferralDetailViewModel extends BaseViewModel {
  copyCode(BuildContext context) async {
    FlutterClipboard.copy(userService.user.referalCode ?? "").then((value) {
      final snackBar = SnackBar(
        content:
            Text('${userService.user.referalCode ?? ""} copied to clipboard!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  navigateToRewardHistory() {
    navigationService.navigateTo(rewardHistoryRoute);
  }
}

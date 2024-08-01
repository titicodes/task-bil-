import 'package:flutter/material.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../base/base.ui.dart';
import 'referal-detail-vm.dart';

class RewardHistoryScreen extends StatelessWidget {
  const RewardHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ReferralDetailViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Rewards History",
        ),
        body: ListView(
          padding: 16.0.padH,
          children: [
            AppText(
              "Rewards earned from transactions performed.",
              color: hintTextColor,
              align: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

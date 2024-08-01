import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/shimmer_loaders.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../core/models/notification-response.dart';
import '../../base/base.ui.dart';
import 'notification-vm.dart';

class NotificationHomeScreen extends StatelessWidget {
  const NotificationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationHomeViewModel>(
      onModelReady: (m) => m.getLocalNot(),
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Notification Screen",
        ),
        body: ListView.builder(
          itemCount: model.notifications.reversed.length,
          padding: EdgeInsets.only(top: 16.sp, left: 16.sp, right: 16.sp),
          itemBuilder: (_, i) {
            return model.notifications.isEmpty
                ? const Center(
                    child: Text('No notifications yet!'),
                  )
                : AppCard(
                    margin: 8.sp.padB,
                    backgroundColor: primaryColor.withOpacity(0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          model.notifications[i].notificationType ?? "",
                          size: 14.sp,
                          weight: FontWeight.w700,
                        ),
                        5.sp.sbH,
                        AppText(
                          (model.notifications[i].verb ?? "").toCapitalized(),
                          size: 12.sp,
                          weight: FontWeight.w500,
                          color: hintTextColor,
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

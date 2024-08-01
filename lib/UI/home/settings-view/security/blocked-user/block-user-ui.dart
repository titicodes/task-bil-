import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/constants/constants.dart';
import 'package:taskitly/utils/shimmer_loaders.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../base/base.ui.dart';
import 'block-user-vm.dart';

class BlockUserScreen extends StatelessWidget {
  const BlockUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<BlockUserViewModel>(
      notDefaultLoading: true,
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => Scaffold(
        appBar: const AppBars(
          text: "Blocked Users",
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: height(context),
              width: width(context),
              child: model.isLoading != true && model.blockedUsers.isEmpty
                  ? const Center(
                      child: AppText("No blocked Users"),
                    )
                  : model.isLoading && model.blockedUsers.isEmpty
                      ? 0.0.sbH
                      : ListView.builder(
                          itemCount:
                              model.isLoading && model.blockedUsers.isEmpty
                                  ? 2
                                  : model.blockedUsers.length,
                          itemBuilder: (_, i) {
                            var user = model.blockedUsers[i];
                            return model.isLoading && model.blockedUsers.isEmpty
                                ? Container(
                                    height: 66.sp,
                                    margin: 8.sp.padV,
                                    width: width(context),
                                    child: const ShimmerCard(),
                                  )
                                : AppCard(
                                    margin: 8.sp.padV,
                                    padding: 8.sp.padA,
                                    radius: 0.sp,
                                    onTap: () => model.popUp(
                                        "Unblock ${user.username ?? ""}?",
                                        () => model.unblockUser(user.uid ?? ""),
                                        subtitle:
                                            "Are you sure you want to unblock this user?"),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50.sp,
                                                width: 50.sp,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.sp),
                                                    image: DecorationImage(
                                                        image: CachedNetworkImageProvider(
                                                            baseUrl +
                                                                (user.profileImage ??
                                                                    "")))),
                                              ),
                                              16.sp.sbW,
                                              AppText(
                                                user.username ?? "",
                                                weight: FontWeight.w500,
                                              )
                                            ],
                                          ),
                                        ),
                                        16.0.sbW,
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16.sp,
                                          weight: 0.5,
                                        )
                                      ],
                                    ),
                                  );
                          }),
            ),
            model.loadings || (model.isLoading && model.blockedUsers.isEmpty)
                ? const SmallLoader()
                : 0.0.sbW
          ],
        ),
      ),
    );
  }
}

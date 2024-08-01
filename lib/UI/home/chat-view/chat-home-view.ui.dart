import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/svg_builder.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/shimmer_loaders.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../base/base.ui.dart';
import 'chat-home-view.vm.dart';

class ChatHomeView extends StatelessWidget {
  const ChatHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatHomeViewViewModel>(
      notDefaultLoading: true,
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          leading: 0.0.sbH,
          title: Row(
            children: [
              AppText(
                "Chats",
                size: 20.sp,
                isBold: true,
              ),
              16.0.sbW,
              Container(
                height: 30,
                width: 30,
                padding: 7.0.sp.padA,
                decoration: ShapeDecoration(
                    color: primaryColor, shape: const OvalBorder()),
                child: buildSvgPicture(
                    image: AppImages.chatFilled,
                    size: 16.sp,
                    color: Colors.white),
              )
            ],
          ),
        ),
        body: StreamBuilder(
            stream: model.getLatestChatsData(),
            builder: (context, snapshot) {
              return SizedBox(
                width: width(context),
                height: height(context),
                child: ListView.builder(
                    padding: 16.0.padH,
                    itemCount:
                        snapshot.data == null && model.userMessages.isEmpty
                            ? 4
                            : model.userMessages.length,
                    itemBuilder: (_, i) {
                      return snapshot.data == null && model.userMessages.isEmpty
                          ? Container(
                              height: 100,
                              width: width(context),
                              margin: 16.0.padB,
                              child: const ShimmerCard(),
                            )
                          : InkWell(
                              onTap: () =>
                                  model.goToChatDetail(model.userMessages[i]),
                              child: Container(
                                  width: width(context),
                                  padding: 18.0.sp.padV,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: hintTextColor
                                                  .withOpacity(0.5),
                                              width: 0.5))),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            primaryColor.withOpacity(0.3),
                                        backgroundImage:
                                            CachedNetworkImageProvider(model
                                                    .userMessages[i]
                                                    .profileImage ??
                                                ""),
                                        radius: 20,
                                      ),
                                      12.0.sbW,
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              "${model.userMessages[i].firstName ?? ""} ${model.userMessages[i].lastName ?? ""}",
                                              weight: FontWeight.w600,
                                            ),
                                            5.0.sbH,
                                            AppText(
                                              (model.userMessages[i].lastMessage
                                                              ?.content ??
                                                          "")
                                                      .contains(
                                                          "https://firebasestorage.googleapis.com/v0/b/taskitly-notifications.appspot.com/")
                                                  ? "🖼️ Image"
                                                  : model.isJson(model
                                                              .userMessages[i]
                                                              .lastMessage
                                                              ?.content ??
                                                          "")
                                                      ? (model.userService
                                                              .isUserServiceProvider
                                                          ? "Sent Invoice"
                                                          : "Received Invoice")
                                                      : model
                                                              .userMessages[i]
                                                              .lastMessage
                                                              ?.content ??
                                                          "",
                                              maxLine: 1,
                                              size: 12,
                                              overflow: TextOverflow.ellipsis,
                                              color: const Color(0xCC212936),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                    }),
              );
            }),
      ),
    );
  }
}

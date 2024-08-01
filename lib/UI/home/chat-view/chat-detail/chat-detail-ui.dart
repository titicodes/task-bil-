import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/svg_builder.dart';
import 'package:taskitly/UI/widgets/text_field.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../core/models/chat/get-messages.dart';
import '../../../../core/models/send-invoice-response.dart';
import '../../../auth/forget-password/new-password/new-password-ui.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/appbar.dart';
import 'chat-detail-vm.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatDetailViewModel>(
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: primaryColor,
                    backgroundImage: CachedNetworkImageProvider(model
                            .chatUserResponse
                            .details
                            ?.userInfo
                            ?.fields
                            ?.profileImage ??
                        ""),
                  ),
                  16.0.sbW,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        "${model.chatUserResponse.details?.userInfo?.fields?.firstName ?? ""} ${model.chatUserResponse.details?.userInfo?.fields?.lastName ?? ""}",
                        color: primaryColor,
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                      5.0.sbH,
                      AppText(
                        "@${model.chatUserResponse.details?.userInfo?.fields?.username ?? ""}",
                        color: const Color(0xFF6B6B6B),
                      ),
                    ],
                  )
                ],
              ),
              PopupMenuButton<String>(
                icon: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child: const Icon(Icons.more_vert),
                ),
                onSelected: (value) {
                  // Handle selected option
                  print('Selected: $value');

                  if (value == "Report") {
                    model.reportUser();
                  } else {
                    model.blockUser();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'Report',
                      child: AppText(
                        "Report  ",
                        size: 14.sp,
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Block',
                      child: AppText(
                        "Block  ",
                        color: Colors.red,
                        size: 14.sp,
                      ),
                    ),
                  ];
                },
              )
            ],
          ),
        ),
        body: Column(
          children: [
            model.userService.isUserServiceProvider
                ? Container(
                    width: width(context),
                    margin: 16.0.padA,
                    padding: 16.0.padA,
                    decoration: BoxDecoration(
                        color: const Color(0x7FF2F2F2),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                          "Create Invoice",
                          weight: FontWeight.w500,
                          color: primaryDarkColor,
                          align: TextAlign.center,
                        ),
                        5.0.sbH,
                        AppText(
                          "click the button below to create an invoice for your service",
                          size: 10.sp,
                          color: const Color(0xCC212936),
                          align: TextAlign.center,
                        ),
                        5.0.sbH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppButton(
                              noHeight: true,
                              padding: 8.0.padA,
                              isExpanded: false,
                              text: "Create Invoice",
                              onTap: () => model.popCreateInvoice(model),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : 0.0.sbH,
            Expanded(
              child: ListView(
                padding: 16.0.padH,
                controller: model.controller,
                children: [
                  16.0.sbH,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model.messages.length,
                    itemBuilder: (_, i) {
                      Messages message = model.messages[i];

                      // Check if the message is JSON
                      if (model.isJson(message.message ?? "")) {
                        // Decode JSON message
                        SendInvoiceResponse response =
                            SendInvoiceResponse.fromJson(
                                jsonDecode(message.message ?? ""));
                        return model.userService.isUserServiceProvider
                            ? 0.0.sbH
                            : Container(
                                margin: 16.0.padA,
                                padding: 16.0.padA,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.sp),
                                  color: secondaryColor,
                                ),
                                child: Column(
                                  children: [
                                    AppText("Invoice Available",
                                        color: primaryColor,
                                        size: 14.sp,
                                        align: TextAlign.center),
                                    10.sp.sbH,
                                    AppText(
                                      "${(model.chatUserResponse.details?.userInfo?.fields?.firstName ?? "").toTitleCase()} just sent you an invoice of work agreement to check for details.",
                                      color: hintTextColor,
                                      size: 11.sp,
                                      align: TextAlign.center,
                                    ),
                                    10.sp.sbH,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppButton(
                                          isExpanded: false,
                                          onTap: model.goToViewBookingsMore,
                                          height: 40.sp,
                                          padding: 0.0.padA,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30.sp),
                                            child: const AppText(
                                              "View",
                                              color: Colors.white,
                                              weight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                      } else {
                        // Display regular message UI
                        return Align(
                          alignment: model.userService.user.username ==
                                  message.username
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft,
                          child: SizedBox(
                            width: width(context) * 0.7,
                            child: Column(
                              crossAxisAlignment:
                                  model.userService.user.username ==
                                          message.username
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                "${message.message}".contains(
                                        "https://firebasestorage.googleapis.com/v0/b/taskitly-notifications.appspot.com/")
                                    ? CachedNetworkImage(
                                        imageUrl: message.message ?? "",
                                        fit: BoxFit.fitWidth,
                                      )
                                    : GestureDetector(
                                        onLongPress: () =>
                                            model.popChat(model, message),
                                        onTap: () =>
                                            model.popChat(model, message),
                                        child: Container(
                                          padding: 10.sp.padA,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: model.userService.user
                                                        .username ==
                                                    message.username
                                                ? const Color(0xFF148651)
                                                : const Color(0xFFF2F2F2),
                                          ),
                                          child: AppText(
                                            message.message ?? "",
                                            color: model.userService.user
                                                        .username ==
                                                    message.username
                                                ? Colors.white
                                                : Colors.black,
                                            size: 13.sp,
                                          ),
                                        ),
                                      ),
                                4.0.sbH,
                                AppText(
                                  model.formatTimeString(
                                      message.naturalTimestamp ?? ""),
                                  size: 12.0,
                                  color: const Color(0xCC212936),
                                ),
                                10.sp.sbH,
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
            SafeArea(
                bottom: true,
                top: false,
                child: Padding(
                  padding: 16.0.padA,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppTextField(
                          borderless: true,
                          borderRadius: 30,
                          textCapitalization: TextCapitalization.sentences,
                          fillColor: secondaryColor,
                          hint: "Type here...",
                          onChanged: model.onChange,
                          controller: model.messageController,
                          suffixIcon: InkWell(
                            onTap: model.getImage,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.sp, vertical: 12.sp),
                              child: buildSvgPicture(
                                  image: AppImages.attach, size: 24.sp),
                            ),
                          ),
                        ),
                      ),
                      model.messageController.text.trim().isEmpty
                          ? 0.0.sbW
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                16.0.sbW,
                                AppCard(
                                  expandable: true,
                                  margin: 0.0.padA,
                                  backgroundColor:
                                      primaryColor.withOpacity(0.1),
                                  onTap: model.sendMessage,
                                  padding: 12.0.padA,
                                  radius: 50,
                                  child: SvgPicture.asset(
                                    AppImages.messageArrow,
                                    height: 28,
                                    width: 28,
                                  ),
                                )
                              ],
                            )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class ReportBlock extends StatelessWidget {
  final ChatDetailViewModel model;
  final Messages message;
  const ReportBlock({super.key, required this.model, required this.message});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Column(
        children: [
          const DrawerAppBar(),
          10.sp.sbH,
          Container(
            padding: 10.sp.padA,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: model.userService.user.username == message.username
                  ? const Color(0xFF148651)
                  : const Color(0xFFF2F2F2),
            ),
            child: AppText(
              message.message ?? "",
              color: model.userService.user.username == message.username
                  ? Colors.white
                  : Colors.black,
              size: 13.sp,
            ),
          ),
          10.sp.sbH,
          Column(
            children: [
              model.userService.user.username == message.username
                  ? OptionChat(
                      onTap: () => model.deleteChat(message),
                      option: "Delete",
                    )
                  : OptionChat(
                      onTap: model.reportChat,
                      option: "Report Chat",
                    ),
            ],
          )
        ],
      ),
    );
  }
}

class OptionChat extends StatelessWidget {
  final VoidCallback onTap;
  final String option;
  const OptionChat({
    super.key,
    required this.onTap,
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50.sp,
          padding: 16.0.padA,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: textColor.withOpacity(0.05))),
          child: AppText(option),
        ),
      ),
    );
  }
}

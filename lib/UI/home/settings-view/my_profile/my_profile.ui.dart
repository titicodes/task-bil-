import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskitly/UI/widgets/app_button.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/palette.dart';
import '../../../base/base.ui.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/text_field.dart';
import 'my_profile.vm.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MyProfileViewModel>(
      onModelReady: (m) => m.init(),
      builder: (_, model, child) => RefreshIndicator(
        onRefresh: () => model.repository.getUser(),
        child: Scaffold(
          appBar: AppBars(
            text: model.isEdit ? "Edit Picture" : "My Profile",
          ),
          body: Padding(
            padding: 16.0.padA,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: model.isEdit
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      height: model.isEdit ? 105 : 45,
                      width: model.isEdit ? 105 : 45,
                      duration: const Duration(milliseconds: 300),
                      child: model.isEdit
                          ? Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  height: 105,
                                  width: 105,
                                  decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            model.user.profileImage ?? ""),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: const OvalBorder(),
                                      color: grey),
                                  child: model.selectedImageFile == null
                                      ? null
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(52.5),
                                          child: Image.file(
                                            File(
                                                model.selectedImageFile?.path ??
                                                    ""),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                !model.showEdit
                                    ? InkWell(
                                        onTap: model.pickImage,
                                        borderRadius:
                                            BorderRadius.circular(17.5),
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: const ShapeDecoration(
                                            color: Color(0xFFE8F9F1),
                                            shape: OvalBorder(),
                                          ),
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                            AppImages.addPhoto,
                                            height: 16,
                                            width: 16,
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: model.selectImage,
                                            child: Container(
                                              height: 36,
                                              width: 36,
                                              margin: const EdgeInsets.only(
                                                  right: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFE8F9F1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)),
                                              child: Icon(
                                                Icons.camera,
                                                color: primaryColor,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => model.selectImage(
                                                source: ImageSource.gallery),
                                            child: Container(
                                              height: 36,
                                              width: 36,
                                              margin: const EdgeInsets.only(
                                                  left: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFE8F9F1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)),
                                              child: Icon(
                                                Icons.image,
                                                color: primaryColor,
                                                size: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                              ],
                            )
                          : Container(
                              height: 45,
                              width: 45,
                              decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        model.user.profileImage ?? ""),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: const OvalBorder(),
                                  color: grey)),
                    ),
                    model.isEdit ? 0.0.sbW : 6.0.sbW,
                    model.isEdit
                        ? 0.0.sbW
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                "${model.user.firstName ?? ""} ${model.user.lastName}",
                                weight: FontWeight.w600,
                                size: 13,
                              ),
                              AppText(
                                model.user.email ?? "",
                                size: 11,
                                color: hintTextColor,
                              ),
                            ],
                          )
                  ],
                ),
                model.isEdit
                    ? 60.0.sbH
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 24.0.sbH,
                          // AppText(
                          //     "Please make sure your details are correct especially your date of birth as we will use it for BVN verification "),
                          24.0.sbH,
                        ],
                      ),
                AppTextField(
                  hintText: "First Name",
                  overrideIconColor: model.isEdit,
                  prefix: Icon(CupertinoIcons.person_fill,
                      color: !model.isEdit
                          ? primaryColor
                          : const Color(0xFFD9D9D9)),
                  hint: "Enter First Name",
                  hintColor: model.isEdit ? null : textColor,
                  controller: model.firstNameController,
                  readonly: !model.isEdit,
                  fillColor: !model.isEdit ? const Color(0xFFF2F2F2) : null,
                ),
                16.0.sbH,
                AppTextField(
                  hintText: "Last Name",
                  overrideIconColor: model.isEdit,
                  prefix: Icon(CupertinoIcons.person_fill,
                      color: !model.isEdit
                          ? primaryColor
                          : const Color(0xFFD9D9D9)),
                  hint: "Enter Last Name",
                  hintColor: model.isEdit ? null : textColor,
                  controller: model.lastNameController,
                  readonly: !model.isEdit,
                  fillColor: !model.isEdit ? const Color(0xFFF2F2F2) : null,
                ),
                16.0.sbH,
                AppTextField(
                  hintText: "Username",
                  prefix: Icon(CupertinoIcons.person_fill,
                      color: !model.isEdit
                          ? primaryColor
                          : const Color(0xFFD9D9D9)),
                  hint: "Enter Username",
                  overrideIconColor: model.isEdit,
                  hintColor: model.isEdit ? null : textColor,
                  controller: model.userNameController,
                  readonly: !model.isEdit,
                  fillColor: !model.isEdit ? const Color(0xFFF2F2F2) : null,
                ),
                16.0.sbH,
                AppTextField(
                  hintText: "Email address",
                  overrideIconColor: model.isEdit,
                  prefix: Icon(CupertinoIcons.mail_solid,
                      color: !model.isEdit
                          ? primaryColor
                          : const Color(0xFFD9D9D9)),
                  hint: "Enter Email address",
                  hintColor: model.isEdit ? null : textColor,
                  controller: model.emailNameController,
                  readonly: !model.isEdit,
                  fillColor: !model.isEdit ? const Color(0xFFF2F2F2) : null,
                ),
                16.0.sbH,
                AppButton(
                    onTap: model.isEdit ? model.submit : model.changeEdit,
                    backGroundColor: primaryColor,
                    text: !model.isEdit
                        ? "Edit Profile"
                        : 'save changes'.toTitleCase())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

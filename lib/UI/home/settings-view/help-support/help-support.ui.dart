import 'package:flutter/material.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/svg_builder.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/string-extensions.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../base/base.ui.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/setting-card.dart';
import 'help-support.vm.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HelpAndSupportViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: AppBars(
          text: AppStrings.help,
        ),
        body: ListView(
          padding: 16.0.padA,
          children: [
            AppCard(
              backgroundColor: Colors.white,
              padding: 16.0.padV,
              useShadow: true,
              child: Column(
                children: [
                  SettingCard(
                    onTap: model.sendMail,
                    icon: AppImages.mail,
                    text: "email us".toTitleCase(),
                    trailing: AppText(
                      model.email,
                      color: primaryColor,
                    ),
                  ),
                  SettingCard(
                      onTap: model.makeCall,
                      icon: AppImages.call,
                      text: "contact us".toTitleCase(),
                      trailing:
                          AppText(model.phoneNumber, color: primaryColor)),
                  SettingCard(
                      onTap: model.liveChat,
                      icon: AppImages.message,
                      text: "live chat".toTitleCase()),
                  SettingCard(
                      onTap: model.whatsappCall,
                      leading:
                          buildSvgPicture(image: AppImages.whatsapp, size: 30),
                      text: "chat with us on whatsapp".toTitleCase()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

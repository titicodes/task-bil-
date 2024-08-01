import 'package:flutter/material.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/widget_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBars(
        text: AppStrings.termsAndCondition,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        children: [
          Html(
            data: AppStrings.TandC,
            onLinkTap: (url, _, __) => launchURL(url!),
          ),
          10.0.sbH,
        ],
      ),
    );
  }

  void launchURL(String url) async {
    String prefix = "https://adashe.com";
    if (await canLaunch(prefix + url)) {
      await launch(prefix + url);
    } else {
      throw 'Could not launch ${prefix + url}';
    }
  }
}

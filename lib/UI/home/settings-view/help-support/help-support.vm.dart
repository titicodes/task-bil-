import 'package:url_launcher/url_launcher.dart';
import '../../../base/base.vm.dart';
import 'tawk-to.dart';

class HelpAndSupportViewModel extends BaseViewModel {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  String phoneNumber = "+2348037985961";
  String email = "support@taskitly.com";

  sendMail() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Complain',
      }),
    );
    launchUrl(emailLaunchUri, mode: LaunchMode.platformDefault);
  }

  liveChat() {
    navigationService.navigateToWidget(const LiveChatScreen());
  }

  makeCall() {
    canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber)).then((bool result) {
      print(result);
      // launchUrlString(phoneNumber);
      launchUrl(Uri(scheme: 'tel', path: phoneNumber),
          mode: LaunchMode.platformDefault);
    });
  }

  whatsappCall() {
    final Uri telLaunchUri =
        Uri.parse("https://api.whatsapp.com/send?phone=2348037985961");
    launchUrl(telLaunchUri, mode: LaunchMode.platformDefault);
  }
}

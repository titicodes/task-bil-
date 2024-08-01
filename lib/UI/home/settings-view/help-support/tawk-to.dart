import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';
import '../../../../constants/palette.dart';
import '../../../../constants/reuseables.dart';
import '../../../widgets/appbar.dart';

class LiveChatScreen extends StatelessWidget {
  const LiveChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBars(
        text: "Live Chat",
      ),
      body: SafeArea(
        bottom: true,
        child: Tawk(
          directChatLink:
              'https://tawk.to/chat/64aff2e194cf5d49dc6356e4/1h57kpgmv',
          visitor: TawkVisitor(
            name:
                "${userService.user.firstName ?? ""} ${userService.user.lastName ?? ""}",
            email: userService.user.email ?? "",
          ),
          onLoad: () {
            print('Hello Tawk!');
          },
          onLinkTap: (String url) {
            print(url);
          },
          placeholder: Center(
              child: SpinKitDualRing(
            color: primaryColor,
            size: 60,
          )),
        ),
      ),
    );
  }
}

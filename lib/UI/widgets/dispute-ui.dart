import 'package:flutter/material.dart';
import 'package:taskitly/UI/base/base.vm.dart';
import 'package:taskitly/locator.dart';

import '../../constants/palette.dart';
import '../../constants/reuseables.dart';
import '../../utils/text_styles.dart';
import '../../utils/widget_extensions.dart';
import '../base/base.ui.dart';
import 'app_button.dart';
import 'apptexts.dart';
import 'text_field.dart';

class DisputeHOMEView extends StatefulWidget {
  final String userID;
  final String type;
  const DisputeHOMEView({super.key, required this.userID, required this.type});

  @override
  State<DisputeHOMEView> createState() => _DisputeHOMEViewState();
}

class _DisputeHOMEViewState extends State<DisputeHOMEView> {
  var disputeTextController = TextEditingController();

  BaseViewModel model = locator.get<BaseViewModel>();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  onChange(String val) {
    formKey.currentState!.validate();
    setState(() {});
  }

  dispute() async {
    startLoading();
    var res = await model.disputeOrBlock(
        type: widget.type,
        userIDs: widget.userID,
        texts: disputeTextController.text.trim());
    stopLoading();
    if (res == true) {
      navigationService.goBack(value: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:
            height(navigationService.navigatorKey.currentState!.context) * 0.35,
        child: SafeArea(
          bottom: true,
          top: false,
          child: Stack(
            children: [
              Scaffold(
                body: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          30.0.sbW,
                          AppText(
                            widget.type == "report"
                                ? "Report User"
                                : "Block User",
                            style: titleMedium.copyWith(color: textColor),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                disputeTextController.clear();
                                navigationService.goBack();
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: secondaryColor,
                              ),
                              child: const Icon(
                                Icons.clear,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      10.0.sbH,
                      TextArea(
                        controller: disputeTextController,
                        hintText: widget.type == "report"
                            ? "Enter dispute"
                            : "Reason to block user",
                        onChanged: onChange,
                      ),
                      10.0.sbH,
                      AppButton(
                        text: "Submit",
                        onTap: formKey.currentState?.validate() != true
                            ? null
                            : dispute,
                      )
                    ],
                  ),
                ),
              ),
              isLoading ? const SmallLoader() : 0.0.sbW
            ],
          ),
        ));
  }
}

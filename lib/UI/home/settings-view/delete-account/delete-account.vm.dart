import 'package:flutter/material.dart';
import 'package:taskitly/constants/reuseables.dart';

import '../../../base/base.vm.dart';
import '../../../widgets/bottom-pop-up.dart';
import '../../../widgets/bottomSheet.dart';
import '../../../widgets/successful-pop-up.dart';

class DeleteMyAccountViewModel extends BaseViewModel {
  late BuildContext context;

  List<String> issues = [
    "Having issue with payments",
    "Just want to delete my account",
    "Having issue with payment",
    "Just want to delete"
  ];

  String? selectedIssue;

  select(String issue) {
    selectedIssue = issue;
    notifyListeners();
  }

  var helpImproveController = TextEditingController();

  showSuccesses() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => const BottomSheetScreen(
          child: SuccessfulPopUpWidget(
        title: "Submitted",
        subTitle: AppStrings.submittedSubtext,
        removeButton: true,
      )),
    ).whenComplete(navigationService.goBack);
  }

  delete() async {
    startLoader();
    try {
      var response = await repository.deleteAccount();
      if (response != null) {
        String res = response ?? "";
        if (res.length > 1) {
          stopLoader();
          notifyListeners();
          await showSuccesses();
        }
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  deleteAccount() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
          child: BottomOptionScreen(
              title: "Delete Account",
              onTap: delete,
              subTitle: AppStrings.deleteAccountText)),
    );
  }
}

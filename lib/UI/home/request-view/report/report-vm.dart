import 'package:flutter/material.dart';

import '../../../../utils/snack_message.dart';
import '../../../base/base.vm.dart';

class ReportOrderViewModel extends BaseViewModel {
  String orderID = "";

  init(String order) {
    orderID = order;
    notifyListeners();
  }

  onChange(String val) {
    notifyListeners();
  }

  var textAreaController = TextEditingController();

  submit() async {
    startLoader();
    try {
      var response = await repository.report(
          orderId: orderID, description: textAreaController.text.trim());
      if (response != null) {
        showCustomToast("Report has been sent expect a message from us soon",
            success: true);
        navigationService.goBack();
      }
      stopLoader();
    } catch (err) {
      stopLoader();
    }
    notifyListeners();
  }
}

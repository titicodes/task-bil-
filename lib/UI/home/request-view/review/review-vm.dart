import 'package:flutter/cupertino.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../base/base.vm.dart';

class ReviewViewModel extends BaseViewModel {
  String orderID = "";

  init(String order) {
    orderID = order;
    notifyListeners();
  }

  double initialRating = 0;

  var textAreaController = TextEditingController();

  onChange(String val) {
    notifyListeners();
  }

  changeRating(double initial) {
    initialRating = initial;
    notifyListeners();
  }

  confirm() async {
    if (initialRating == 0) {
      showCustomToast("Select Rating to proceed");
    } else {
      startLoader();
      try {
        var response = await repository.reviewOrder(
            orderId: orderID,
            comment: textAreaController.text.trim(),
            rating: initialRating.toStringAsFixed(0));
        if (response != null) {
          showCustomToast("Successful Submission of Review", success: true);
          navigationService.goBack();
        }
        stopLoader();
      } catch (err) {
        stopLoader();
      }
    }
    notifyListeners();
  }
}

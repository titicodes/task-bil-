import 'package:taskitly/routes/routes.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../constants/reuseables.dart';
import '../../base/base.vm.dart';

class BillViewViewModel extends BaseViewModel {
  List<Map<String, dynamic>> utilities = [
    {"title": "Airtime", "icon": AppImages.airtime},
    {"title": "Data", "icon": AppImages.data},
    {"title": "Television", "icon": AppImages.television},
    {"title": "Electricity", "icon": AppImages.electricity},
    {"title": "Internet", "icon": AppImages.internet},
    {"title": "Education", "icon": AppImages.internet},
  ];

  List<Map<String, dynamic>> others = [
    {"title": "Betting", "icon": AppImages.betting},
    // {"title": "Book Flight", "icon": AppImages.flight},
    {"title": "Send Gift", "icon": AppImages.gift},
  ];

  goToDetail(String path) {
    switch (path.toLowerCase()) {
      case "airtime":
        {
          _goToAirtimeBilling();
        }
      case "data":
        {
          _data();
        }
      case "electricity":
        {
          _electricity();
        }
      case "television":
        {
          _television();
        }
      case "internet":
        {
          _internet();
        }
      case "education":
        {
          _education();
        }
      case "betting":
        {
          _betting();
        }
      case "book flight":
        {
          _flight();
        }
      case "send gift":
        {
          _sendGift();
        }
      default:
        {
          showCustomToast("No option for that");
        }
    }
  }

  _betting() {
    navigationService.navigateTo(bettingBillsRoute);
  }

  _flight() {}

  _sendGift() {
    navigationService.navigateTo(sendGiftRoute);
  }

  _data() {
    navigationService.navigateTo(dataBillsRoute);
  }

  _television() {
    navigationService.navigateTo(televisionBillsRoute);
  }

  _internet() {
    navigationService.navigateTo(internetBillsRoute);
  }

  _electricity() {
    navigationService.navigateTo(electricityBillsRoute);
  }

  _education() {
    navigationService.navigateTo(educationBillsRoute);
  }

  _goToAirtimeBilling() {
    navigationService.navigateTo(airtimeBillsRoute);
  }
}

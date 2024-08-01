import 'package:taskitly/UI/base/base.vm.dart';
import 'package:taskitly/utils/string-extensions.dart';

import '../../../../routes/routes.dart';
import '../../../on-boarding/on-boarding-vm.dart';

class SelectUserTypeViewModel extends BaseViewModel {
  OnBoardingData? selectedData;

  onChange(OnBoardingData select) {
    if (select == selectedData) {
      selectedData = null;
    } else {
      selectedData = select;
    }
    notifyListeners();
  }

  goToUserLogin() {
    navigationService.navigateTo(loginScreenRoute);
  }

  onSubmit() {
    appCache.userType = selectedData?.value;
    navigationService.navigateTo(signupRoute);
  }

  List<OnBoardingData> clientData = [
    OnBoardingData(
        image: "As Client",
        details: 'discover quality Services and payments'.toCapitalized(),
        value: "client"),
    OnBoardingData(
        image: "As Provider",
        details: 'list your service and skill while earning.'.toCapitalized(),
        value: "provider"),
  ];
}

import 'package:taskitly/UI/base/base.vm.dart';
import 'package:taskitly/constants/reuseables.dart';

import '../../routes/routes.dart';

class OnBoardingViewModel extends BaseViewModel {
  int sliderIndex = 0;
  int totalSize = 3;

  List<OnBoardingData> onBoardingObjects = [
    OnBoardingData(image: AppImages.onboard1, details: AppStrings.onboard1),
    OnBoardingData(image: AppImages.onboard2, details: AppStrings.onboard2),
    OnBoardingData(image: AppImages.onboard3, details: AppStrings.onboard3),
  ];

  changeCarouselIndexValue(int indexValue) {
    sliderIndex = indexValue;
    notifyListeners();
  }

  goToUserType() {
    navigationService.navigateTo(selectUserTypeRoute);
  }

  goToUserLogin() {
    navigationService.navigateTo(loginScreenRoute);
  }
}

class OnBoardingData {
  String image;
  String details;
  String? value;

  OnBoardingData({required this.image, required this.details, this.value});
}

import '../../../constants/reuseables.dart';
import '../../../core/models/user-response.dart';
import '../../../routes/routes.dart';
import '../../base/base.vm.dart';
import 'verification/verification-home.ui.dart';

class SettingsViewViewModel extends BaseViewModel {
  List<Map<String, dynamic>> general = [];
  List<Map<String, dynamic>> security = [];
  User user = User();

  init() async {
    user = userService.user;
    general = userService.isUserServiceProvider == true
        ? [
            {
              "image": AppImages.profile,
              "text": AppStrings.myProfile,
              'onTap': goToProfile
            },
            {
              "image": AppImages.profile,
              "text": AppStrings.serviceDetail,
              'onTap': goToPServiceDetail
            },
            {
              "image": AppImages.refer,
              "text": AppStrings.refer,
              'onTap': goToRefer
            },
          ]
        : [
            {
              "image": AppImages.profile,
              "text": AppStrings.myProfile,
              'onTap': goToProfile
            },
            {
              "image": AppImages.refer,
              "text": AppStrings.refer,
              'onTap': goToRefer
            },
          ];
    security = userService.isUserServiceProvider == true
        ? [
            {
              "image": AppImages.verify,
              "text": AppStrings.verification,
              'onTap': goToVerify
            },
            {
              "image": AppImages.help,
              "text": AppStrings.help,
              'onTap': goToHelp
            },
            {
              "image": AppImages.security,
              "text": AppStrings.security,
              'onTap': goToSecurity
            },
            {
              "image": AppImages.terms,
              "text": AppStrings.terms,
              'onTap': goToTerms
            },
            {
              "image": AppImages.logout,
              "text": AppStrings.logout,
              'onTap': () {},
              "isLogout": true
            },
          ]
        : [
            {
              "image": AppImages.verify,
              "text": AppStrings.verification,
              'onTap': goToVerify
            },
            {
              "image": AppImages.help,
              "text": AppStrings.help,
              'onTap': goToHelp
            },
            {
              "image": AppImages.security,
              "text": AppStrings.security,
              'onTap': goToSecurity
            },
            {
              "image": AppImages.terms,
              "text": AppStrings.terms,
              'onTap': goToTerms
            },
            {
              "image": AppImages.logout,
              "text": AppStrings.logout,
              'onTap': () {},
              "isLogout": true
            },
          ];
    notifyListeners();
  }

  goToProfile() {
    navigationService.navigateTo(myProfileRoute).whenComplete(init);
  }

  goToPServiceDetail() {
    navigationService.navigateTo(serviceDetailsRoute);
  }

  goToRefer() {
    // referAndWinHomeRoute
    navigationService.navigateTo(referAndWinHomeRoute);
  }

  goToHelp() {
    navigationService.navigateTo(helpAndSupportRoute);
  }

  goToSecurity() {
    navigationService.navigateTo(securityRoute);
  }

  goToVerify() {
    navigationService.navigateToWidget(const VerificationHomeView());
  }

  goToTerms() {
    navigationService.navigateTo(termsAndConditionRoute);
  }
}

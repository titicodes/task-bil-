import '../../../../constants/reuseables.dart';
import '../../../../core/models/verification-status.dart';
import '../../../../routes/routes.dart';
import '../../../base/base.vm.dart';
import 'bvn/enter-bvn-screen.dart';
import 'verify-email/email-verify-ui.dart';

class VerificationHomeViewModel extends BaseViewModel {
  bool _emailVerified = false;
  bool _bvnVerified = false;

  bool get emailVerified => _emailVerified;
  bool get bvnVerified => _bvnVerified;

  init() async {
    final response = await userStatus();
    if (response != null) {
      _emailVerified = response.payload?.emailVerified ?? _emailVerified;
      _bvnVerified = response.payload?.bvnVerified ?? _bvnVerified;
    }
    notifyListeners();
  }

  Future<VerificationStatus?> userStatus() async {
    startLoader();
    final response = await repository.userStatus();
    stopLoader();
    return response;
  }

  Future<VerificationStatus?> userLocalStatus() async {
    final response = await repository.getLocalUserStatus();
    return response;
  }

  verifyEmail() async {
    startLoader();
    try {
      await repository.emailVerify();
      navigationService.navigateToWidget(const EmailVerificationScreen());
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  goToVerify() {
    navigationService.navigateTo(kycMainScreen);
  }

  goToBvn() async {
    navigationService.navigateToWidget(const EnterBVNScreen());
  }
}

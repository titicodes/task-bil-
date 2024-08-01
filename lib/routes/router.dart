import 'package:flutter/material.dart';
import 'package:taskitly/UI/auth/forget-password/new-password/new-password-ui.dart';
import 'package:taskitly/UI/home/bills-view/coming_soon/coming_soon_ui.dart';
import 'package:taskitly/UI/home/bills-view/gifting-view/gifting-view-ui.dart';
import 'package:taskitly/UI/home/home-view/wallet-transaction/confirmation_screen.dart';
import 'package:taskitly/UI/home/settings-view/security/change-pin/change_pin_view.dart';
import 'package:taskitly/UI/home/settings-view/security/change-pin/verify_otp.dart';
import '../UI/auth/forget-password/forget-password-ui.dart';
import '../UI/auth/get-started/select-user/select-user-type-ui.dart';
import '../UI/auth/get-started/sign-up/enter_phone/enter-phone-number.ui.dart';
import '../UI/auth/get-started/sign-up/provider/provider-detail-ui.dart';
import '../UI/auth/get-started/sign-up/sign-up-ui.dart';
import '../UI/auth/get-started/sign-up/verify_user/verify-phone-ui.dart';
import '../UI/auth/login/login-ui.dart';
import '../UI/home/bills-view/airtime-view/airtime-view-ui.dart';
import '../UI/home/bills-view/betting-view/betting-view-ui.dart';
import '../UI/home/bills-view/data-view/data-view-ui.dart';
import '../UI/home/bills-view/education-view/education-view-ui.dart';
import '../UI/home/bills-view/electricity-view/electricity-view-ui.dart';
import '../UI/home/bills-view/internet-view/internet-view-ui.dart';
import '../UI/home/bills-view/television-view/television-view-ui.dart';
import '../UI/home/browse-view/category-detail-tab/category-detail.ui.dart';
import '../UI/home/browse-view/category-detail-tab/provider-detail/provider-detail.ui.dart';
import '../UI/home/chat-view/chat-detail/chat-detail-ui.dart';
import '../UI/home/chat-view/chat-home-view.ui.dart';
import '../UI/home/home-view/history/transaction-history-screen.dart';
import '../UI/home/home-view/history/transaction_history_detals.dart';
import '../UI/home/home.navigation.ui.dart';
import '../UI/home/settings-view/delete-account/delete-account.ui.dart';
import '../UI/home/settings-view/help-support/help-support.ui.dart';
import '../UI/home/settings-view/my_profile/my_profile.ui.dart';
import '../UI/home/settings-view/referal/other-pages/referal-history-ui.dart';
import '../UI/home/settings-view/referal/other-pages/reward-history-ui.dart';
import '../UI/home/settings-view/referal/other-pages/reward-ui.dart';
import '../UI/home/settings-view/referal/other-pages/successful-referal-ui.dart';
import '../UI/home/settings-view/referal/refer-and-win.ui.dart';
import '../UI/home/settings-view/security/change-password/change.password.ui.dart';
import '../UI/home/settings-view/security/change-pin/change.pin.ui.dart';
import '../UI/home/settings-view/security/security.ui.dart';
import '../UI/home/settings-view/service-details/edit_service_ui.dart';
import '../UI/home/settings-view/service-details/service_screen_ui.dart';
import '../UI/home/settings-view/terms-condition/terms-condition.ui.dart';
import '../UI/home/settings-view/verification/kyc/kyc_main_ui.dart';
import '../UI/home/settings-view/verification/kyc/kyc_photo_ui.dart';
import '../UI/on-boarding/on-boarding-ui.dart';
import '../UI/on-boarding/splash_screen.dart';
import '../UI/widgets/bills-success-widget.dart';
import '../core/services/local-service/app-cache.dart';
import '../locator.dart';
import 'routes.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final cache = locator<AppCache>();
    switch (settings.name) {
      case splashscreenRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
                  selectedIndex: cache.initialIndex,
                ));
      case selectUserTypeRoute:
        return MaterialPageRoute(builder: (_) => const SelectUserTypeScreen());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case verifyPhoneNumber:
        return MaterialPageRoute(
            builder: (_) => const VerifyPhoneNumberScreen());
      case enterPhoneNumberRoute:
        return MaterialPageRoute(
            builder: (_) => const EnterPhoneNumberScreen());
      case loginScreenRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case updateProviderRoute:
        return MaterialPageRoute(builder: (_) => const ProviderDetailScreen());
      case helpAndSupportRoute:
        return MaterialPageRoute(builder: (_) => const HelpAndSupportScreen());
      case termsAndConditionRoute:
        return MaterialPageRoute(
            builder: (_) => const TermsAndConditionScreen());
      case securityRoute:
        return MaterialPageRoute(builder: (_) => const SecurityScreen());
      case deleteMyAccountRoute:
        return MaterialPageRoute(builder: (_) => const DeleteMyAccountScreen());
      case onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case myProfileRoute:
        return MaterialPageRoute(builder: (_) => const MyProfileScreen());
      case airtimeBillsRoute:
        return MaterialPageRoute(builder: (_) => const AirtimeViewScreen());
      case changePasswordRoute:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case changePinRoute:
        return MaterialPageRoute(builder: (_) => const ChangePinScreen());
      case referAndWinHomeRoute:
        return MaterialPageRoute(builder: (_) => const ReferAndWinHomeScreen());
      case rewardHistoryRoute:
        return MaterialPageRoute(builder: (_) => const RewardHistoryScreen());
      case rewardRoute:
        return MaterialPageRoute(builder: (_) => const RewardScreen());
      case successfulRewardRoute:
        return MaterialPageRoute(
            builder: (_) => const SuccessfulRewardScreen());
      case referralsHistoryRoute:
        return MaterialPageRoute(
            builder: (_) => const ReferralsHistoryScreen());
      case dataBillsRoute:
        return MaterialPageRoute(builder: (_) => const DataViewScreen());
      case kycMainScreen:
        return MaterialPageRoute(builder: (_) => const KYCMainScreen());
      case kycMainPhotoScreen:
        return MaterialPageRoute(builder: (_) => KYCPhotoScreen());
      case electricityBillsRoute:
        return MaterialPageRoute(builder: (_) => const ElectricityViewScreen());
      case bettingBillsRoute:
        return MaterialPageRoute(builder: (_) => const BettingViewScreen());
      case televisionBillsRoute:
        return MaterialPageRoute(builder: (_) => const TelevisionViewScreen());
      case internetBillsRoute:
        return MaterialPageRoute(builder: (_) => const InternetViewScreen());
      case categoryDetailRoute:
        return MaterialPageRoute(builder: (_) => const CategoryDetailTab());
      case chatDetailRoute:
        return MaterialPageRoute(builder: (_) => const ChatDetailScreen());
      case sendGiftRoute:
        return MaterialPageRoute(builder: (_) => const GiftingViewScreen());
      case chatHomeRoute:
        return MaterialPageRoute(builder: (_) => const ChatHomeView());
      case transactionHistoryRoute:
        return MaterialPageRoute(
            builder: (_) => const TransactionHistoryScreen());
      case transactionHistoryDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => const TransactionHistoryDetailsScreen());
      case providerDetailViewRoute:
        return MaterialPageRoute(
            builder: (_) => const ProviderDetailViewScreen());
      case educationBillsRoute:
        return MaterialPageRoute(builder: (_) => const EducationViewScreen());
      case serviceDetailsRoute:
        return MaterialPageRoute(builder: (_) => const ServiceDetailsScreen());
      case editServiceDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => const EditServiceDetailsScreen());
      case successWidgetRoute:
        return MaterialPageRoute(
          builder: (_) => const BillsSuccessfulWidget(
            subTitle: "",
            title: "Purchase Successful",
          ),
        );
      case verifyChangePinOtpRoute:
        return MaterialPageRoute(
            builder: (_) => const VerifyChangePinOtpScreen());
      case newPasswordRoute:
        return MaterialPageRoute(builder: (_) => const NewPasswordScreen());
      case commingSoonRoute:
        return MaterialPageRoute(builder: (_) => const ComingSoonScreen());
      case newChangePinRoute:
        return MaterialPageRoute(builder: (_) => const NewChangePinView());

      case confrimationPageRoute:
        return MaterialPageRoute(builder: (_) => const ConfirmationPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

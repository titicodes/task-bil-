import 'package:get_it/get_it.dart';
import 'package:taskitly/UI/home/bills-view/airtime-view/airtime-view-vm.dart';
import 'package:taskitly/UI/home/bills-view/betting-view/betting-view-vm.dart';
import 'package:taskitly/UI/home/bills-view/gifting-view/gifting-pin-vm.dart';
import 'package:taskitly/UI/home/bills-view/gifting-view/gifting-view-vm.dart';
import 'package:taskitly/UI/home/bills-view/internet-view/internet-view-vm.dart';
import 'package:taskitly/UI/home/browse-view/bookmark/bookmark-vm.dart';
import 'package:taskitly/UI/home/settings-view/verification/bvn/new_bvn_vm.dart';
import 'package:taskitly/core/services/web-services/wallet_api_service.dart';

import 'UI/auth/forget-password/forget-password-vm.dart';
import 'UI/auth/forget-password/new-password/new-password-vm.dart';
import 'UI/auth/forget-password/verify-password/verify-password-vm.dart';
import 'UI/auth/get-started/select-user/select-user-type-vm.dart';
import 'UI/auth/get-started/sign-up/enter_phone/enter-phone-number.vm.dart';
import 'UI/auth/get-started/sign-up/provider/provider-detail-vm.dart';
import 'UI/auth/get-started/sign-up/sign-up-vm.dart';
import 'UI/auth/get-started/sign-up/verify_user/verify-phone-vm.dart';
import 'UI/auth/login/login-vm.dart';
import 'UI/base/base.vm.dart';
import 'UI/home/bills-view/bill-view-vm.dart';
import 'UI/home/bills-view/data-view/data-view-vm.dart';
import 'UI/home/bills-view/education-view/education-view-vm.dart';
import 'UI/home/bills-view/electricity-view/electricity-provider-type-view/electricity-provider-type-view-vm.dart';
import 'UI/home/bills-view/electricity-view/electricity-view-vm.dart';
import 'UI/home/bills-view/payment-view/internet-payment-details-vm.dart';
import 'UI/home/bills-view/payment-view/payment-details-vm.dart';
import 'UI/home/bills-view/pin-view/pin-view-vm.dart';
import 'UI/home/bills-view/television-view/television-view-vm.dart';
import 'UI/home/browse-view/browse-view-vm.dart';
import 'UI/home/browse-view/category-detail-tab/category-detail.vm.dart';
import 'UI/home/browse-view/category-detail-tab/provider-detail/provider-detail.vm.dart';
import 'UI/home/chat-view/chat-detail/chat-detail-vm.dart';
import 'UI/home/chat-view/chat-detail/send-invoice.vm.dart';
import 'UI/home/chat-view/chat-home-view.vm.dart';
import 'UI/home/home-view/history/tansaction-history-view-vm.dart';
import 'UI/home/home-view/home-view-vm.dart';
import 'UI/home/home-view/trasaction-view-vm/transactions-view-model.dart';
import 'UI/home/home.navigation.vm.dart';
import 'UI/home/notification/notification-vm.dart';
import 'UI/home/request-view/report/report-vm.dart';
import 'UI/home/request-view/request-view-vm.dart';
import 'UI/home/request-view/review/review-vm.dart';
import 'UI/home/settings-view/delete-account/delete-account.vm.dart';
import 'UI/home/settings-view/help-support/help-support.vm.dart';
import 'UI/home/settings-view/my_profile/my_profile.vm.dart';
import 'UI/home/settings-view/referal/other-pages/referal-detail-vm.dart';
import 'UI/home/settings-view/referal/refer-and-win.vm.dart';
import 'UI/home/settings-view/security/blocked-user/block-user-vm.dart';
import 'UI/home/settings-view/security/change-password/change.password.vm.dart';
import 'UI/home/settings-view/security/change-pin/change.pin.vm.dart';
import 'UI/home/settings-view/security/change-pin/new_change_pin_vm.dart';
import 'UI/home/settings-view/service-details/edit-service-vm.dart';
import 'UI/home/settings-view/settings-view-vm.dart';
import 'UI/home/settings-view/verification/bvn/bvn-vm.dart';
import 'UI/home/settings-view/verification/kyc/kyc_main_vm.dart';
import 'UI/home/settings-view/verification/kyc/new_kyc_vm.dart';
import 'UI/home/settings-view/verification/verification-home.vm.dart';
import 'UI/home/settings-view/verification/verify-email/email-verify-vm.dart';
import 'UI/on-boarding/on-boarding-vm.dart';
import 'core/repository/repository.dart';
import 'core/services/local-service/app-cache.dart';
import 'core/services/local-service/navigation_services.dart';
import 'core/services/local-service/storage-service.dart';
import 'core/services/local-service/user.service.dart';
import 'core/services/web-services/auth.api.dart';
import 'core/services/web-services/bills-service.dart';
import 'core/services/web-services/chat-service.dart';
import 'core/services/web-services/location.service.dart';
import 'core/services/web-services/notification-service.dart';
import 'core/services/web-services/product-service.dart';
import 'core/services/web-services/services-service.dart';

GetIt locator = GetIt.I;

//
setupLocator() {
  registerViewModels();
  registerServices();
}

void registerViewModels() {
  /* TODO Setup viewModels*/
  locator.registerFactory<BaseViewModel>(() => BaseViewModel());
  locator.registerFactory<HomeTabViewModel>(() => HomeTabViewModel());
  locator.registerFactory<OnBoardingViewModel>(() => OnBoardingViewModel());
  locator.registerFactory<SelectUserTypeViewModel>(
      () => SelectUserTypeViewModel());
  locator.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<EnterPhoneNumberViewModel>(
      () => EnterPhoneNumberViewModel());
  locator.registerFactory<VerifyPhoneNumberViewModel>(
      () => VerifyPhoneNumberViewModel());
  locator.registerFactory<ForgetPasswordViewModel>(
      () => ForgetPasswordViewModel());
  locator.registerFactory<VerifyPasswordViewModel>(
      () => VerifyPasswordViewModel());
  locator.registerFactory<NewPasswordViewModel>(() => NewPasswordViewModel());
  locator.registerFactory<BrowseViewViewModel>(() => BrowseViewViewModel());
  locator.registerFactory<BillViewViewModel>(() => BillViewViewModel());
  locator.registerFactory<HomeViewViewModel>(() => HomeViewViewModel());
  locator.registerFactory<TransactionViewModel>(() => TransactionViewModel());
  locator.registerFactory<RequestViewViewModel>(() => RequestViewViewModel());
  locator.registerFactory<SettingsViewViewModel>(() => SettingsViewViewModel());
  locator.registerFactory<MyProfileViewModel>(() => MyProfileViewModel());
  locator.registerFactory<HelpAndSupportViewModel>(
      () => HelpAndSupportViewModel());
  locator.registerFactory<DeleteMyAccountViewModel>(
      () => DeleteMyAccountViewModel());
  locator.registerFactory<ChangePinViewModel>(() => ChangePinViewModel());
  locator.registerFactory<ReferAndWinHomeViewModel>(
      () => ReferAndWinHomeViewModel());
  locator.registerFactory<ReferralDetailViewModel>(
      () => ReferralDetailViewModel());
  locator.registerFactory<ChangePasswordViewModel>(
      () => ChangePasswordViewModel());
  locator.registerFactory<ProviderDetailViewModel>(
      () => ProviderDetailViewModel());

  locator.registerFactory<AirtiemBillViewViewModel>(
      () => AirtiemBillViewViewModel());
  locator.registerFactory<DataBillViewViewModel>(() => DataBillViewViewModel());
  locator.registerFactory<ChatDetailViewModel>(() => ChatDetailViewModel());
  locator.registerFactory<ChatHomeViewViewModel>(() => ChatHomeViewViewModel());
  locator.registerFactory<CategoryDetailTabViewModel>(
      () => CategoryDetailTabViewModel());
  locator.registerFactory<ProviderDetailViewViewModel>(
      () => ProviderDetailViewViewModel());
  locator.registerFactory<ElectricityBillViewViewModel>(
      () => ElectricityBillViewViewModel());

  locator.registerFactory<PaymentDetailsViewModel>(
      () => PaymentDetailsViewModel());
  locator.registerFactory<TransactionPinViewModel>(
      () => TransactionPinViewModel());
  // locator.registerFactory<ElectricityProviderViewModel>(
  //     () => ElectricityProviderViewModel());
  locator.registerFactory<ElectricityProviderTypeViewModel>(
      () => ElectricityProviderTypeViewModel());
  locator.registerFactory<BettingBillViewViewModel>(
      () => BettingBillViewViewModel());
  // locator.registerFactory<BettingProviderViewModel>(
  //     () => BettingProviderViewModel());
  // locator.registerFactory<BettingProviderTypeViewModel>(
  //     () => BettingProviderTypeViewModel());
  locator.registerFactory<TelevisionBillViewViewModel>(
      () => TelevisionBillViewViewModel());
  locator.registerFactory<TransactionGiftPinViewModel>(
      () => TransactionGiftPinViewModel());
  locator.registerFactory<GiftingViewViewModel>(() => GiftingViewViewModel());
  locator.registerFactory<InternetBillViewViewModel>(
      () => InternetBillViewViewModel());
  locator.registerFactory<InternetPaymentDetailsViewModel>(
      () => InternetPaymentDetailsViewModel());
  locator.registerFactory<EducationBillViewViewModel>(
      () => EducationBillViewViewModel());
  locator.registerFactory<KYCMainViewModel>(() => KYCMainViewModel());
  locator.registerFactory<VerifyBVNViewModel>(() => VerifyBVNViewModel());
  locator.registerFactory<SendInvoiceViewModel>(() => SendInvoiceViewModel());
  locator.registerFactory<BookmarkViewModel>(() => BookmarkViewModel());
  locator.registerFactory<ReviewViewModel>(() => ReviewViewModel());
  locator.registerFactory<NotificationHomeViewModel>(
      () => NotificationHomeViewModel(locator<HomeTabViewModel>()));
  locator.registerFactory<TransactionHistoryViewModel>(
      () => TransactionHistoryViewModel());
  locator.registerFactory<ReportOrderViewModel>(() => ReportOrderViewModel());
  locator.registerFactory<EditServiceViewModel>(() => EditServiceViewModel());
  locator.registerFactory<BlockUserViewModel>(() => BlockUserViewModel());
  locator.registerFactory<EmailVerificationViewModel>(
      () => EmailVerificationViewModel());
  locator.registerFactory<VerificationHomeViewModel>(
      () => VerificationHomeViewModel());
  locator.registerFactory<NewBvnViewModel>(() => NewBvnViewModel());
   //locator.registerFactory<NewKYCMainViewModel>(() => NewKYCMainViewModel());
}

void registerServices() {
  /// Services
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<LocationViewModel>(() => LocationViewModel());
  locator.registerLazySingleton(() => UserService());
  // locator.registerLazySingleton(() => ProductServices());
  locator.registerLazySingleton(() => AppCache());
  // locator.registerLazySingleton(() => FireBaseApi());
  locator.registerLazySingleton<StorageService>(() => StorageService());
  locator.registerLazySingleton<ChatServices>(() => ChatServices());
  locator.registerLazySingleton<Repository>(() => Repository());
  locator.registerLazySingleton<AuthenticationApiService>(
      () => AuthenticationApiService());
  locator.registerLazySingleton<ProductService>(() => ProductService());
  locator.registerLazySingleton<ServicesService>(() => ServicesService());
  locator
      .registerLazySingleton<NotificationService>(() => NotificationService());
  locator.registerLazySingleton<BillsService>(() => BillsService());
  locator.registerLazySingleton<WalletAPIService>(() => WalletAPIService());
}

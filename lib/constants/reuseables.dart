import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskitly/utils/string-extensions.dart';

import '../core/repository/repository.dart';
import '../core/services/local-service/app-cache.dart';
import '../core/services/local-service/navigation_services.dart';
import '../core/services/local-service/user.service.dart';
import '../locator.dart';

//Loading State
enum ViewState { idle, busy }

NavigationService navigationService = locator<NavigationService>();
UserService userService = locator<UserService>();
AppCache cache = locator<AppCache>();
Repository repository = locator<Repository>();

class AppStrings {
  static const String appName = 'Taskitly';
  static const String home = 'Home';
  static const String electrical = 'Electrical';
  static const String cleaning = 'Cleaning';
  static const String painting = 'Painting';
  static const String furniture = 'Furniture';
  static const String repair = 'Repair';
  static const String interior = 'Interior';
  static const String lighting = 'Lighting';
  static const String more = 'More';
  static const String trackRequest = 'Track all your requests at a go';
  static const String payBills = 'Pay bills';
  static const String transHistory = 'Transaction History';
  static const String account = 'Account';
  static const String byContinuing =
      'By continuing, you agree that you are 18+ years old and you accept our ';
  static const String termsAndCondition = 'Terms and Conditions';
  static const String and = ' and ';
  static const String topUp = 'Top Up';
  static const String active = 'Active';
  static const String withdraw = 'Withdrawal';
  static const String welcomeUser = 'Welcome, ';
  static const String viewAll = 'View All';
  static const String moreInfo =
      'There are a few more information we need to complete your verification. ';
  static const String signIn = ' Sign in ';
  static const String cancelPopMessage =
      'please confirm you want to cancel this service, you can’t undo this';
  static const String confirmPopMessage =
      'You are about to release payment, By clicking on "Confirm", it means the service provider has completed their task for you, and you consider the service rendered.';
  static String deleteMyAccount = 'delete my account'.toTitleCase();
  static String deleteAccount = 'delete account'.toTitleCase();
  static const String searchServices = 'Search for services';
  static const String startServices = 'Confirm you want to start this service';
  static const String doneServices = 'Confirm you have completed this service';
  static const String cancelOrderDetail =
      'You have cancled this order and fund has been released back to the customer,  you have questions about this, contact support';
  static const String deleteMyAccountDetails =
      'Why do you want to delete your account?';
  static const String tapToProceed = 'Tap to proceed';
  static const String signUp = ' Sign Up';
  static const String from = 'From ';
  static const String serviceDesc = 'Service Description';
  static const String useReferral =
      'Use your referral code below to invite your friends and earn rewards when they perform a transaction.';
  static const String myProfile = 'My Profile';
  static const String aboutTaskify =
      'Readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like.)';
  static const String ourServices =
      'Readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like.)';
  static const String serviceDetail = 'Service details';
  static const String verification = 'Verification';
  static const String submittedSubtext =
      'We have received your account delete request this will take 72 hours for this to be effected, change your mind? contact us via support@taskitly.com';
  static String refer = 'refer & earn'.toTitleCase();
  static String help = 'help & support'.toTitleCase();
  static String terms = 'terms & condition'.toTitleCase();
  static String yourDetails = 'your details'.toTitleCase();
  static const String security = 'Security';
  static const String deleteAccountText =
      'Are you sure you want to delete your account? if you have any fund left on you account, with before proceed';
  static const String logout = 'Log out';
  static const String offerService = 'To offer a service';
  static const String dontHaveAccount = 'Don’t have an account?';
  static const String findService = 'To find a service';
  static const String privacyPolicy = 'Privacy Policy';
  static const String forgotPin = 'Forgot Payment Pin?';
  static const String fullStop = '.';
  static const String createNewPassword =
      'kindly set a new password for your account.';
  static const String enterDigits =
      'please enter 5 digits code sent to your phone number for password confirmation change.';
  static const String enterPinDigits =
      'please enter 5 digits code sent to your phone number for pin confirmation change.';
  static const String enterEmail =
      'please enter your registered email address and a code will be sent for confirmation.';
  static const String enterOTP = 'Enter the OTP code sent to ';
  static const String oipSentTo = 'Send the code to ';
  static const problemSendingOtp = "Having problems with changing pin?";
  static const String didntReceive = 'Didn’t receive the OTP? ';
  static const String welcome = 'Welcome to Taskitly';
  static const String alreadyHaveAnAccount = 'Already have an account?';
  static const String howTwoUse = 'How do you want to use taskitly';
  static const onboard1 = "Discover top-notch handymen with ease on Taskitly.";
  static const onboard2 =
      "Join Taskitly, showcase your skills and grow your business!";
  static const onboard3 =
      "Simplify bill payments with Taskitly's seamless feature.";
  static const String comingSoon =
      "Dear customer, this feature is not currently available.";
  static const String TandC = '''
  <div class="col-lg-10 offset-lg-1">
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><strong><span style='font-size:25px;font-family:"Arial",sans-serif;color:black;'>Terms and Conditions</span></strong></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-size:16px;font-family:"Times New Roman",serif;'>&nbsp;</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-family:"Arial",sans-serif;color:black;'>Effective Date: 1st June 2023</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-size:16px;font-family:"Times New Roman",serif;'>&nbsp;</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-family:"Arial",sans-serif;color:black;'>These terms and conditions (&quot;<strong>Terms</strong>&quot;) govern your use of Taskitly, an innovative service platform developed by T<strong>askit Technology Limited</strong> (&quot;<strong>Taskitly</strong>,&quot; &quot;<strong>we</strong>,&quot; &quot;<strong>us</strong>,&quot; or &quot;<strong>ou</strong>r&quot;). By accessing or using Taskitly, you agree to be bound by these Terms. Please read them carefully before using Taskitly.</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-size:16px;font-family:"Times New Roman",serif;'><br>&nbsp;</span></p>
                <div style='margin-top:0cm;margin-right:0cm;margin-bottom:8.0pt;margin-left:0cm;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'>
                    <p><strong style="font-weight: 700; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span style="font-size: 19pt; color: black;">1. Acceptance of Terms</span></strong></p>
                </div>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-family:"Arial",sans-serif;color:black;'>By accessing or using Taskitly, you acknowledge that you have read, understood, and agree to be bound by these Terms. If you do not agree with any provision of these Terms, you should not access or use Taskitly.</span><span style='font-size:16px;font-family:"Times New Roman",serif;'><br>&nbsp;</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><br></p>
                <div style='margin-top:0cm;margin-right:0cm;margin-bottom:8.0pt;margin-left:0cm;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'>
                    <p><strong style="font-weight: 700; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span style="font-size: 19pt; color: black;">2. User Responsibilities</span></strong></p>
                </div>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><strong><span style='font-family:"Arial",sans-serif;color:black;'>2.1 Eligibility:&nbsp;</span></strong><span style='font-family:"Arial",sans-serif;color:black;'>You must be at least 18 years old to access or use Taskitly. By accessing or using Taskitly, you represent and warrant that you are 18 years of age or older.</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><strong><span style='font-family:"Arial",sans-serif;color:black;'>2.2. User Account:</span></strong><span style='font-family:"Arial",sans-serif;color:black;'>&nbsp;You may need to create a user account to access certain features of Taskitly. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><strong><span style='font-family:"Arial",sans-serif;color:black;'>2.3. Compliance with Laws:&nbsp;</span></strong><span style='font-family:"Arial",sans-serif;color:black;'>You agree to comply with all applicable laws, regulations, and third-party rights when using Taskitly. You shall not use Taskitly for any unlawful or unauthorised purposes.</span><span style='font-size:16px;font-family:"Times New Roman",serif;'><br>&nbsp;</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><br></p>
                <div style='margin-top:0cm;margin-right:0cm;margin-bottom:8.0pt;margin-left:0cm;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'>
                    <p><strong style="font-weight: 700; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span style="font-size: 19pt; color: black;">3. Services and Payments</span></strong></p>
                </div>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><strong><span style='font-family:"Arial",sans-serif;color:black;'>3.1. Service Providers</span></strong><span style='font-family:"Arial",sans-serif;color:black;'>: Taskitly connects users with skilled service providers for home repair and maintenance services. Taskitly does not provide the services directly but facilitates the booking process.</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><strong><span style='font-family:"Arial",sans-serif;color:black;'>3.2. Payment:&nbsp;</span></strong><span style='font-family:"Arial",sans-serif;color:black;'>Taskitly may offer integrated bill payment functionality for certain services. By using Taskitly&apos;s bill payment feature, you agree to provide accurate and up-to-date payment information. Taskitly will process payments on your behalf and may charge applicable fees for its services.</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><strong><span style='font-family:"Arial",sans-serif;color:black;'>3.3. Third-Party Services:&nbsp;</span></strong><span style='font-family:"Arial",sans-serif;color:black;'>Taskitly may integrate or provide links to third-party services or websites. Your use of such third-party services is subject to their respective terms and conditions. Taskitly does not endorse, warrant, or guarantee the availability, quality, or legality of third-party services.</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-size:16px;font-family:"Times New Roman",serif;'><br>&nbsp;</span></p>
                <div style='margin-top:0cm;margin-right:0cm;margin-bottom:8.0pt;margin-left:0cm;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'>
                   <p><strong style="font-weight: 700; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span style="font-size: 19pt; color: black;">4. Intellectual Property</span></strong></p>
                </div>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><strong><span style='font-family:"Arial",sans-serif;color:black;'>4.1. Taskitly Content:</span></strong><span style='font-family:"Arial",sans-serif;color:black;'>&nbsp;All content available on Taskitly, including but not limited to text, graphics, logos, images, videos, and software, is the property of Taskitly Technology Limited or its licensors and is protected by intellectual property laws.</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><strong><span style='font-family:"Arial",sans-serif;color:black;'>4.2. User Content:</span></strong><span style='font-family:"Arial",sans-serif;color:black;'>&nbsp;By submitting any content, such as reviews or feedback, to Taskitly, you grant Taskitly Technology Limited a non-exclusive, worldwide, royalty-free, and transferable licence to use, reproduce, modify, adapt, publish, translate, distribute, and display such content.</span><span style='font-size:16px;font-family:"Times New Roman",serif;'><br>&nbsp;<br>&nbsp;</span></p>
                <div style='margin-top:0cm;margin-right:0cm;margin-bottom:8.0pt;margin-left:0cm;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'>
                    <p><strong style="font-weight: 700; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span style="font-size: 19pt; color: black;">5. Privacy and Data Protection</span></strong></p>
                </div>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-family:"Arial",sans-serif;color:black;'>Taskitly&apos;s privacy practices are outlined in the <strong>Privacy Policy</strong>, which is an integral part of these Terms. By using Taskitly, you consent to the collection, use, and disclosure of your personal information as described in the Privacy Policy.</span><span style='font-size:16px;font-family:"Times New Roman",serif;'><br>&nbsp;</span></p>
                <div style='margin-top:0cm;margin-right:0cm;margin-bottom:8.0pt;margin-left:0cm;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'>
                    <p><strong style="font-weight: 700; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span style="font-size: 19pt; color: black;">6. Limitation of Liability</span></strong></p>
                </div>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-family:"Arial",sans-serif;color:black;'>To the extent permitted by applicable laws, Taskitly Technology Limited shall not be liable for any direct, indirect, incidental, consequential, or punitive damages arising out of or in connection with the use of Taskitly or these Terms.</span><span style='font-size:16px;font-family:"Times New Roman",serif;'><br>&nbsp;</span></p>
                <div style='margin-top:0cm;margin-right:0cm;margin-bottom:8.0pt;margin-left:0cm;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'>
                    <p><strong style="font-weight: 700; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span style="font-size: 19pt; color: black;">7. Governing Law and Dispute Resolution</span></strong></p>
                </div>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-family:"Arial",sans-serif;color:black;'>These Terms shall be governed by the law of the federal government of Nigeria and in accordance with the laws of Nigeria. Any dispute arising out of or relating to these Terms or the use of Taskitly shall be resolved through arbitration in accordance with the rules of the Nigerian Arbitration and Conciliation Act.</span><span style='font-size:16px;font-family:"Times New Roman",serif;'><br>&nbsp;</span></p>
                <div style='margin-top:0cm;margin-right:0cm;margin-bottom:8.0pt;margin-left:0cm;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'>
                    <p><strong style="font-weight: 700; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span style="font-size: 19pt; color: black;">8. Modifications to Terms</span></strong></p>
                </div>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;line-height:normal;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-family:"Arial",sans-serif;color:black;'>Taskitly Technology Limited reserves the right to modify or update these Terms at any time. You are responsible for reviewing these Terms periodically.<br>&nbsp;<br>&nbsp;Thank you for Choosing Taskitly.</span></p>
                <p style='margin-top:0cm;margin-right:0cm;margin-bottom:8.0pt;margin-left:0cm;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'>&nbsp;</p>
            </div>
  ''';
}

class DbTable {
  static const String USER_TABLE_NAME = 'user';
  static const String OTP = 'otp';
  static const String TOKEN_TABLE_NAME = 'token';
  static const String APP_FIRST_TIME_TABLE_NAME = 'isFirstTime';
  static const String ONBOARDING_TABLE_NAME = 'onboarding';
  static const String CATEGORIES_TABLE_NAME = 'categories';
  static const String USER_STATUS_TABLE_NAME = 'current_user_status';
  static const String SERVICE_TABLE_NAME = 'service_provider';
  static const String SERVICE_DETAIL_TABLE_NAME =
      'service_provider_detail_table';
  static const String BOOKMARK_TABLE_NAME = 'bookmarked_service_provider';
  static const String NOTIFICATION_TABLE_NAME = 'notification_provider';
  static const String TRANSACTION_HISTORY_TABLE_NAME = 'notification_provider';
  static const String AIRTIME_TABLE_NAME = 'airtime_provider';
  static const String DATA_TABLE_NAME = 'data_provider';
  static const String CHATROOM_DETAIL_TABLE_NAME = '/store_chatroom_provider';
  static const String ELECTRICITY_TABLE_NAME = 'electricity_provider';
  static const String STORE_ALL_CHATS_TABLE_NAME = '/store_all_chats';
  static const String STORE_CHAT_USER_TABLE_NAME = '/store_chats_user';
  static const String STORE_CHAT_MESSAGES_TABLE_NAME = '/store_chats_messages';
  static const String ELECTRICITY_TYPE_TABLE_NAME = 'electricity_type_provider';
  static const String BETTING_TYPE_TABLE_NAME = 'betting_type_provider';
  static const String TELEVISION_TYPE_TABLE_NAME = 'television_type_provider';
  static const String INTERNET_TYPE_TABLE_NAME = 'internet_type_provider';
  static const String EDUCATION_TABLE_NAME = 'education_provider';
  static const String BANK_LIST_TABLE_NAME = 'bank_list';
  static const String BLOCKED_USER_LIST_TABLE_NAME = 'blocked_user_list';
  static const String LOGIN_TABLE_NAME = 'login';
  static const String PIN_TABLE_NAME = 'savePin';
  static const String PASSWORD_TABLE_NAME = 'password';
  static const String EMAIL_TABLE_NAME = 'email';
  static const String FIRST_NAME_TABLE = 'firstName';
  static const String USER_INFO_TABLE = 'userInfo';
  static const String PROVIDER_DETAILS_TABLE = 'provider_details';
  static const String FUND_WALLET_INFO = 'fund_wallet_info';
  static const String POPULAR_SERVICE_PROVIDER = 'popular_service_provider';
  static const String TV_DATA = 'tv_data_table';
  static const String haService = 'hasService';
}

class AppStyle {
  static const double padding = 20;
  static const double avatarRadius = 45;
  static const double avatarRadius2 = 25;
  // text color
  static const Color textColorWhite = Colors.white;
  // background color
  static const Color backgroundColor = Colors.black;
  //card height
  static const double cardHeight = 70;
}

class AppFontSizes {
  static double headingFontSize32 = 32.0.sp;
  static double headingFontSize24 = 24.0.sp;
  static double headingFontSize22 = 22.0.sp;
  static double appBarFontSize20 = 20.0.sp;
  static double titleFontSize16 = 16.0.sp;
  static double titleNormalSize15 = 15.0.sp;
  static double bodyNormalSize14 = 14.0.sp;
  static double bodySmallSize12 = 12.0.sp;
  static double bodyCaptionSize10 = 10.0.sp;
}

class Sized16Container extends StatelessWidget {
  final Widget? child;
  final Decoration? decoration;

  const Sized16Container({super.key, this.child, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: child,
    );
  }
}

class AppImages {
  static const appLogo = "assets/images/taxity_logo.png";
  static const serviceDetailsImage = "assets/images/service_details.png";
  static const onboard1 = "assets/images/onboard1.png";
  static const onboard2 = "assets/images/onboard2.png";
  static const onboard3 = "assets/images/onboard3.png";
  static const homeFilled = "assets/svg/home_filled.svg";
  static const browseFilled = "assets/svg/browse_filled.svg";
  static const requestFilled = "assets/svg/request_filled.svg";
  static const settingsFilled = "assets/svg/settings-filled.svg";
  static const billsFilled = "assets/svg/bills_filled.svg";
  static const chatFilled = "assets/svg/chat_filled.svg";
  static const homeBlank = "assets/svg/home-blank.svg";
  static const chatBlank = "assets/svg/chat_black.svg";
  static const browseBlank = "assets/svg/browse_blank.svg";
  static const requestBlank = "assets/svg/request_blank.svg";
  static const settingsBlank = "assets/svg/settings_blank.svg";
  static const billsBlank = "assets/svg/bills_blank.svg";
  static const help = "assets/svg/help_service.svg";
  static const logout = "assets/svg/logouts.svg";
  static const naira = 'assets/svg/Naira.svg';
  static const attach = 'assets/svg/attach.svg';
  static const refer = "assets/svg/refer.svg";
  static const stars = "assets/svg/group_stars.svg";
  static const security = "assets/svg/security.svg";
  static const terms = "assets/svg/terms.svg";
  static const coin = "assets/svg/coin.svg";
  static const repair = "assets/svg/repair.svg";
  static const interior = "assets/svg/interior.svg";
  static const light = "assets/svg/light.svg";
  static const more = "assets/svg/more.svg";
  static const topUp = "assets/svg/topUp.svg";
  static const withdraw = "assets/svg/withdraw.svg";
  static const funiture = "assets/svg/funiture.svg";
  static const painting = "assets/svg/painting.svg";
  static const electric = "assets/svg/electric.svg";
  static const star = "assets/images/stars.jpg";
  static const clean = "assets/svg/clean.svg";
  static const coins = "assets/svg/coins.svg";
  static const coinPng = "assets/images/coin.png";
  static const notification = "assets/svg/notification_bell.svg";
  static const profile = "assets/svg/profile.svg";
  static const airtime = "assets/svg/airtime.svg";
  static const data = "assets/svg/data.svg";
  static const flight = "assets/svg/flight.svg";
  static const addPhoto = "assets/svg/addPhoto.svg";
  static const television = "assets/svg/television.svg";
  static const electricity = "assets/svg/electricity.svg";
  static const internet = "assets/svg/internet.svg";
  static const betting = "assets/svg/betting.svg";
  static const gift = "assets/svg/gift.svg";
  static const verify = "assets/svg/verify.svg";
  static const badge = "assets/svg/verify-badge.svg";
  static const mtn = "assets/svg/mtn.svg";
  static const envelop = "assets/images/envelop.png";
  static const envelops = "assets/images/envelope-open.png";
  static const call = "assets/svg/call.svg";
  static const mail = "assets/svg/mail.svg";
  static const bvn = "assets/svg/bvn.svg";
  static const message = "assets/svg/message.svg";
  static const whatsapp = "assets/svg/whatsapp.svg";
  static const glo = "assets/svg/glo.svg";
  static const ribbon = "assets/svg/ribbon.svg";
  static const starSvg = "assets/svg/star_new.svg";
  static const orderSvg = "assets/svg/order_svg.svg";
  static const percentSvg = "assets/svg/percentage_svg.svg";
  static const airtel = "assets/svg/airtel.svg";
  static const walletImage = "assets/svg/wallet_img.svg";
  static const transationProcessing = "assets/svg/transaction_processing.svg";
  static const nineMobile = "assets/svg/9mobile.svg";
  static const delete = "assets/svg/delete.svg";
  static const messageArrow = "assets/svg/message_arrow.svg";
  static const personCircle = "assets/svg/person_circle.svg";
  static const walletBalance = "assets/svg/wallet.svg";
  static const referFriends = "assets/images/refer_friend.png";
  static const soundFile = "assets/images/sound.mp3";
  static const cominSoonImage = "assets/images/coming.png";
  //"C:\Users\HP\Documents\VsCodeApplications\FlutterProjects\Taskitly-Mobile\assets\images\sound.mp3"
}

class UrlPath {
  static const String signup = 'user/create-user';
  static const String login = 'auth/login';
  static const String user = 'auth/user/';
}

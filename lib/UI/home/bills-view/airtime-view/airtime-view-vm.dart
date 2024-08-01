import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskitly/UI/home/bills-view/payment-view/payment-details-screen.dart';
import 'package:taskitly/UI/widgets/appCard.dart';
import 'package:taskitly/UI/widgets/appbar.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/UI/widgets/bottomSheet.dart';
import 'package:taskitly/utils/widget_extensions.dart';
import '../../../../core/models/airtime_response_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/snack_message.dart';
import '../../../base/base.vm.dart';

class AirtiemBillViewViewModel extends BaseViewModel {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountNumberController = TextEditingController();
  TextEditingController billerController = TextEditingController();
  AirtimeResponseModel airtimeResponseModel = AirtimeResponseModel();
  List<AirTimeServiceProvider> providers = [];
  late BuildContext context;
  AirTimeServiceProvider? provider;

  init(BuildContext contexts) async {
    context = contexts;
    await getLocalAirtimeProvider();
    if (airtimeResponseModel.data == null) {
      await fetchAirtime();
    }
    await onChanged(providers[0]);
  }

  Future<void> requestContactsPermission() async {
    var status = await Permission.contacts.status;
    if (status.isDenied) {
      // Explain to the user why the permission is needed
      // Optionally, provide instructions on how to enable the permission manually
      final PermissionStatus permissionStat =
          await Permission.contacts.request();
      if (permissionStat.isGranted) {
        await _openContactPicker();
      } else {
        showCustomToast('Contacts permission denied');
      }
    } else {
      await _openContactPicker();
    }
  }

  String formatPhoneNumber(String phoneNumber) {
    print(phoneNumber);
    // Remove any non-numeric characters
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'[\D\s]'), '');
    print(cleanedNumber);

    // Check if the number contains '+234'
    if (cleanedNumber.contains('234')) {
      // Replace '+234' with '0'
      cleanedNumber = cleanedNumber.replaceAll('234', '0');
    }

    // Check the length of the cleaned number
    if (cleanedNumber.length == 10 && !cleanedNumber.startsWith('0')) {
      // If the length is 10 and it doesn't start with '0', add '0' to the front
      cleanedNumber = '0$cleanedNumber';
    } else if (cleanedNumber.length == 11 && cleanedNumber.startsWith('0')) {
      // If the length is 11 and it starts with '0', return as it is
      // No action needed
    } else {
      // Otherwise, the number is invalid
      throw ArgumentError('Invalid phone number format');
    }

    return cleanedNumber;
  }

  Future<void> _openContactPicker() async {
    Contact? contact = await contactPicker.selectContact();
    if (contact != null) {
      String contactInfo = formatPhoneNumber(contact.phoneNumbers?.first ?? "");
      phoneNumberController = TextEditingController(text: contactInfo);
      onChange(contactInfo);
    }
    // List<Contact>? _contacts = contact == null ? null : [contact];
    // if(_contacts!=null){
    //   await showContacts(_contacts??[]);
    // }
    notifyListeners();
  }

  String phoneNumber = "";
  getPhoneNumber(phone) {
    phoneNumber = phone;
    notifyListeners();
  }

  // showContacts(List<Contact> contacts)async{
  //   showAppBottomSheet(BottomSheetContact(contacts: contacts));
  // }

  onChange(String? val) {
    checkNetworkProvider(val ?? "");
    notifyListeners();
  }

  onChanged(AirTimeServiceProvider? provide) {
    provider = provide;
    notifyListeners();
  }

  List<String> value = [
    "50",
    "100",
    "200",
    "500",
    "1000",
    "2000",
    "5000",
    "10000",
  ];
  history() async {
    navigationService.navigateTo(transactionHistoryRoute);
  }

  //::// manipulate the numbers to handle amount //:://
  void onChipSelected(String amount) {
    amountNumberController = TextEditingController(text: amount);
    notifyListeners();
  }

  //::// fetch the already stored airtime billers from the local db //:://
  getLocalAirtimeProvider() async {
    var response = await repository.getLocalAirtimeProvider();
    if (response?.data != null) {
      airtimeResponseModel = response ?? AirtimeResponseModel();
      providers = convertToServiceProviderList(airtimeResponseModel);

      stopLoader();
      notifyListeners();
    }
  }

  //::// fetch all the airtime billers available //:://
  fetchAirtime() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getAirtime();
      if (response?.data != null) {
        airtimeResponseModel = response ?? AirtimeResponseModel();
        providers = convertToServiceProviderList(airtimeResponseModel);
        stopLoader();
        notifyListeners();
      }
      stopLoader();
      notifyListeners();
    } on DioException {
      stopLoader();
      notifyListeners();
    }
  }

  checkNetworkProvider(String phoneNumber) async {
    // Check if the length of the phone number is at least 11 characters
    if (phoneNumber.length < 11 || phoneNumber.length > 11) {
      return null; // Return null if the phone number is too short
    }

    // Extract the first 4 characters of the phone number
    String prefix = phoneNumber.substring(0, 4);

    // Check the first 4 characters against known prefixes
    if ([
      '0803',
      '0806',
      '0703',
      '0903',
      '0906',
      '0806',
      '0706',
      '0813',
      '0810',
      '0814',
      '0816',
      '0913',
      '0916',
      '0704'
    ].contains(prefix)) {
      return await onChanged(providers.firstWhere(
          (element) => element.name!.toLowerCase().contains("mtn")));
    } else if (['0805', '0705', '0905', '0807', '0815', '0811', '0915']
        .contains(prefix)) {
      return await onChanged(providers.firstWhere(
          (element) => element.name!.toLowerCase().contains("glo")));
    } else if (['0802', '0902', '0701', '0808', '0708', '0812', '0901', '0907']
        .contains(prefix)) {
      return await onChanged(providers.firstWhere(
          (element) => element.name!.toLowerCase().contains("airtel")));
    } else if (['0809', '0909', '0817', '0818', '0908'].contains(prefix)) {
      return await onChanged(providers.firstWhere(
          (element) => element.name!.toLowerCase().contains("9mobile")));
    } else {
      provider = null;
      notifyListeners();
      return showCustomToast(
          "This number is not a valid Nigerian number"); // Return null if the prefix doesn't match any known provider
    }
  }

  //:::// Pay for airtime bills //::://
  payAirtime() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      stopLoader();
      if (phoneNumberController.text.isNotEmpty &&
          phoneNumberController.text.length >= 11 &&
          amountNumberController.text.isNotEmpty &&
          provider != null) {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (_) => BottomSheetScreen(
              child: PaymentDetailsScreen(
            phoneNumber: phoneNumberController.text.trim(),
            amount: amountNumberController.text.trim(),
            selectedProvider: provider,
          )),
        );
      } else {
        showCustomToast("Invalid input please try again!", success: false);
      }
    } catch (err) {}
  }
}

class BottomSheetContact extends StatelessWidget {
  final List<Contact> contacts;
  const BottomSheetContact({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBars(),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (_, i) {
            Contact contact = contacts[i];
            return AppCard(
              child: Column(
                children: [
                  AppText(contact.fullName ?? ""),
                  5.0.sbH,
                  ListView.builder(
                      itemCount: contact.phoneNumbers?.length ?? 0,
                      itemBuilder: (_, i) {
                        return AppCard(
                          child: AppText(contact.phoneNumbers?[i] ?? ""),
                        );
                      })
                ],
              ),
            );
          }),
    );
  }
}

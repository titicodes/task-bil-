import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskitly/UI/home/bills-view/gifting-view/gift-pin-ui.dart';
import 'package:taskitly/UI/widgets/bottomSheet.dart';
import 'package:taskitly/core/models/name-look-up-response.dart';
import '../../../../core/models/airtime_response_model.dart';
import '../../../../routes/routes.dart';
import '../../../base/base.vm.dart';

class GiftingViewViewModel extends BaseViewModel {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountNumberController = TextEditingController();
  TextEditingController billerController = TextEditingController();
  AirtimeResponseModel airtimeResponseModel = AirtimeResponseModel();
  List<AirTimeServiceProvider> providers = [];
  AirTimeServiceProvider? provider;

  onChange(String? val) {
    notifyListeners();
  }

  onPhoneChange(String? val) async {
    if (phoneNumberController.text.trim().length == 11) {
      await nameCheck();
    } else {
      nameLookUpResponse = null;
    }
    notifyListeners();
  }

  Future<void> requestContactsPermission() async {
    final PermissionStatus status = await Permission.contacts.request();
    if (status.isGranted) {
      await _openContactPicker();
    } else {
      print('Contacts permission denied');
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
      onPhoneChange(contactInfo);
    }
    notifyListeners();
  }

  nameCheck() async {
    startLoader();
    try {
      var response = await repository.nameCheck(
          phoneNumber: phoneNumberController.text.trim());
      if (response?.name != null) {
        nameLookUpResponse = response;
      }
      stopLoader();
      notifyListeners();
    } catch (err) {
      print(err);
      notifyListeners();
      stopLoader();
    }
  }

  NameLookUpResponse? nameLookUpResponse;

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

  payGift() async {
    bool? response = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: navigationService.navigatorKey.currentState!.context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
          child: TransactionGiftPinScreen(
        phoneNumber: phoneNumberController.text.trim(),
        amount: amountNumberController.text.trim(),
      )),
    );
    if (response == true) {
      amountNumberController.clear();
      phoneNumberController.clear();
      nameLookUpResponse = null;
      notifyListeners();
    }
  }
}

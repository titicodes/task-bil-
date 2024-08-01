import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskitly/UI/home/bills-view/payment-view/payment-details-screen.dart';
import 'package:taskitly/UI/widgets/bottomSheet.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/core/models/mtn_data_response_model.dart';
import '../../../../core/models/airtime_response_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/snack_message.dart';
import '../../../base/base.vm.dart';

class DataBillViewViewModel extends BaseViewModel {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountNumberController = TextEditingController();
  TextEditingController billerController = TextEditingController();
  ConvertedDataResponse dataResponseModel = ConvertedDataResponse();
  List<AirTimeServiceProvider> providers = [];

  List<UseData> daily = [];
  List<UseData> weekly = [];
  List<UseData> monthly = [];
  List<UseData> other = [];

  sortData(ConvertedDataResponse dataResponseModel) {
    List<UseData> data = dataResponseModel.data ?? [];
    daily.clear();
    weekly.clear();
    monthly.clear();
    other.clear();
    for (var dataPlan in data) {
      String name = dataPlan.name ?? "";
      if (name.toLowerCase().contains("DAILY".toLowerCase())) {
        daily.add(dataPlan);
      } else if (name.toLowerCase().contains("MONTHLY".toLowerCase())) {
        monthly.add(dataPlan);
      } else if (name.toLowerCase().contains("WEEKLY".toLowerCase())) {
        weekly.add(dataPlan);
      } else {
        other.add(dataPlan);
      }
    }
    notifyListeners();
  }

  selectData(UseData? data) async {
    print(data?.name);
  }

  late BuildContext context;
  AirTimeServiceProvider? provider;

  init(BuildContext contexts) async {
    context = contexts;
    await changeBiller(dataBillers[0]);
  }

  onChange(String? val) {
    checkNetworkProvider(val ?? "");
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
      onChange(contactInfo);
    }
    // List<Contact>? _contacts = contact == null ? null : [contact];
    // if(_contacts!=null){
    //   await showContacts(_contacts??[]);
    // }
    notifyListeners();
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
      return await changeBiller(dataBillers.firstWhere(
          (element) => element["name"].toLowerCase().contains("mtn")));
    } else if (['0805', '0705', '0905', '0807', '0815', '0811', '0915']
        .contains(prefix)) {
      return await changeBiller(dataBillers.firstWhere(
          (element) => element["name"].toLowerCase().contains("glo")));
    } else if (['0802', '0902', '0701', '0808', '0708', '0812', '0901', '0907']
        .contains(prefix)) {
      return await changeBiller(dataBillers.firstWhere(
          (element) => element["name"].toLowerCase().contains("airtel")));
    } else if (['0809', '0909', '0817', '0818', '0908'].contains(prefix)) {
      return await changeBiller(dataBillers.firstWhere(
          (element) => element["name"].toLowerCase().contains("9mobile")));
    } else {
      selectedBiller = null;
      daily = [];
      weekly = [];
      monthly = [];
      other = [];
      notifyListeners();
      return showCustomToast(
          "This number is not a valid Nigerian number"); // Return null if the prefix doesn't match any known provider
    }
  }

  history() async {
    navigationService.navigateTo(transactionHistoryRoute);
  }

  void printPhoneNumber() {
    print("Phone Number: ${phoneNumberController.text}");
    print("Selected Amount: ${amountNumberController.text.trim()}");
  }

  onChanged(AirTimeServiceProvider? provide) async {
    provider = provide;
    notifyListeners();
  }

  //::// Fetch the data //:://
  fetch() async {
    dataResponseModel = ConvertedDataResponse();
    await getLocalDataProvider();
    if (dataResponseModel.data == null) {
      await fetchData();
    }
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
  List<Map<String, dynamic>> dataBillers = [
    {
      "name": "MTN",
      "value": "mtn_data",
      "image": AppImages.mtn,
    },
    {
      "name": "AIRTEL",
      "value": "airtel_data",
      "image": AppImages.airtel,
    },
    {
      "name": "GLO",
      "value": "glo_data",
      "image": AppImages.glo,
    },
    {
      "name": "9MOBILE",
      "value": "9mobile_data",
      "image": AppImages.nineMobile,
    },
  ];

  Map<String, dynamic>? selectedBiller;
  //::// Handle when the dropdown is beign changed //:://
  changeBiller(Map<String, dynamic>? biller) async {
    selectedBiller = biller;
    notifyListeners();
    await fetch();
  }

  //::// Handle chip selection of different data //:://
  void onChipSelected(String amount) {
    amountNumberController = TextEditingController(text: amount);
    notifyListeners();
  }

  //:://Fetch the local datas that was stored on the local db //:://
  getLocalDataProvider() async {
    var response =
        await repository.getLocalDataProvider(selectedBiller?["value"]);
    if (response?.data != null) {
      dataResponseModel = response ?? ConvertedDataResponse();
      sortData(dataResponseModel);
      stopLoader();
      notifyListeners();
    }
  }

  //::// Fetch the different data available //:://
  fetchData() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response =
          await repository.getData(dataBillers: selectedBiller?["value"]);
      if (response?.data != null) {
        dataResponseModel = response ?? ConvertedDataResponse();
        sortData(dataResponseModel);
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

  //::// Handle payment for the data biller selected //:://
  Future<void> payData(
      String? selectedDataName, double? selectedDataAmount) async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      stopLoader();
      if (phoneNumberController.text.isNotEmpty &&
          phoneNumberController.text.length >= 11 &&
          selectedDataName != null) {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (_) => BottomSheetScreen(
              child: PaymentDetailsScreen(
            phoneNumber: phoneNumberController.text.trim(),
            amount: selectedDataAmount.toString(),
            selectedDataName: selectedDataName,
          )),
        );
      } else {
        showCustomToast("Invalid input please try again!", success: false);
      }
    } catch (err) {}
  }
}

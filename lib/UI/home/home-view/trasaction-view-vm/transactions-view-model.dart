import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/home/home-view/wallet-transaction/new_topup_screen.dart';
import 'package:taskitly/core/models/fund_wallet_response.dart';
import 'package:taskitly/utils/string-extensions.dart';
import '../../../base/base.vm.dart';
import '../../../../constants/reuseables.dart';
import '../../../../core/models/account-verify-response.dart';
import '../../../../core/models/bank-list-response.dart';
import '../../../../utils/snack_message.dart';
import '../../../widgets/bottomSheet.dart';
import '../wallet-transaction/confirm-withdrawal-details.dart';
import '../wallet-transaction/withdrawal-bank-list-screen.dart';

class TransactionViewModel extends BaseViewModel {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController narrationController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  AccountVerifyResponse? accountVerifyResponse;
  BankListResponse? bankListResponse;
  FundWalletResponse? fundWalletResponse = FundWalletResponse();
  late BuildContext context;
  late List<BankResult> banks = [];
  String? selectedBankName;
  String? selectedBankCode;
  String? amount;
  @override
  bool isLoading = false;

  init() async {
    context = navigationService.navigatorKey.currentState!.context;
    bankNameController.text = "";
    await getLocalBankList();
    await getLocalFundWalletInfo();
    // if (fundWalletResponse?.detail == null) {
    // fundWallet(amount: amount ?? "");
    // }
    if (banks.isEmpty) {
      await fetchAllBanks();
    }
  }

  void clearName() {
    nameController.clear();
    accountNumberController.clear(); //09132058051
    notifyListeners();
  }

  onBankSelected(String bankName, String bankCode) {
    selectedBankName = bankName;
    selectedBankCode = bankCode;
    nameController.clear();
    accountNumberController.clear();
    bankNameController.text = selectedBankName ?? "";
    print('Selected bank: $selectedBankName, Code: $selectedBankCode');

    navigationService.goBack();
  }

  void onChange(String? value) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  void onNumberChange(String? value) {
    nameController = TextEditingController();
    formKey.currentState?.validate();
    notifyListeners();
  }

  void onBankChange(String? value) {
    accountNumberController = TextEditingController();
    nameController = TextEditingController();
    formKey.currentState?.validate();
    notifyListeners();
  }

  fetchAllBanks({String? page}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getBankList(page: page);
      if (response?.results != null) {
        if (response?.next != null) {
          String next = response?.next ?? "";
          List<String> nexts = next.split("=");
          await fetchAllBanks(page: nexts[1]);
        }

        banks = await getLocalBankList();
        print(banks);

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

  getLocalBankList() async {
    var response = await repository.getLocalBankList();
    if (response != null) {
      banks = response;
      print(response.length);
      notifyListeners();
    }
  }

  void showBankListBottomSheet() async {
    fetchAllBanks();
    await showModalBottomSheet<List<String>>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
        child: WithdrawalBankListScreen(
          banks: banks,
          onBankSelected: onBankSelected,
        ),
      ),
    ).whenComplete(() => onBankChange(""));

    notifyListeners();
  }

  void verifyAccountDetails() async {
    startLoader();
    try {
      accountVerifyResponse = await repository.verifyBankAccount(
          accountNumber: accountNumberController.text,
          code: selectedBankCode ?? "");
      if (accountVerifyResponse?.success == true) {
        nameController.text =
            (accountVerifyResponse?.data?.accountName ?? "").toTitleCase();
        showCustomToast(accountVerifyResponse?.message ?? "", success: true);
      } else {
        showCustomToast(
            accountVerifyResponse?.message ?? "Fail to verified this account");
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  void confirmWithdrawalDetails() async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => BottomSheetScreen(
          child: ConfirmWithdrawalDetailScreen(
        accountName: nameController.text.trim(),
        accountNumber: accountNumberController.text.trim(),
        amount: amountController.text.toString(),
        bankName: selectedBankName,
        narration: narrationController.text.trim(),
        bankCode: selectedBankCode,
      )),
    );
  }

  void fundWallet({required String amount, Function? onComplete}) async {
    startLoader();
    try {
      var response = await repository.fundWallet(amount: amount);
      if (response?.detail != null) {
        fundWalletResponse = await getLocalFundWalletInfo();
        if (onComplete != null) onComplete();
      }
      stopLoader();
      if (response != null) {
        fundWalletResponse = response;

        notifyListeners();
      } else {
        showCustomToast("Failed to fetch info! Please try again later.");
      }
    } catch (e) {
      print("Error funding wallet: $e");
      showCustomToast(
          "An error occurred while funding wallet. Please try again later.");
    }
  }

  void topUpWallet({required String amount, Function? onComplete}) async {
    startLoader();
    try {
      var response = await repository.topUpWallet(amount: amount);
      // if (response?.detail != null) {
      //   fundWalletResponse = await getLocalFundWalletInfo();
      // }
      stopLoader();
      if (response.contains('Success')) {
        if (onComplete != null) onComplete();

        // fundWalletResponse = response;
        // showCustomToast("", success: true);
        notifyListeners();
      } else {
        showCustomToast("Request Failed, Please try again later!");
      }
    } catch (e) {
      showCustomToast(
          "An error occurred while funding wallet. Please try again later.");
    }
  }

  accountInfo(String title, {Function? onTap, String? subtitle}) async {
    BuildContext context = navigationService.navigatorKey.currentState!.context;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => const BottomSheetScreen(child: NewTopUpScreen()),
    );
  }

  getLocalFundWalletInfo() async {
    startLoader();
    var response = await repository.getLocalFundWalletInfo();
    if (response != null) {
      fundWalletResponse = response ?? FundWalletResponse();
      print(response);
      stopLoader();
      notifyListeners();
    }
  }
}

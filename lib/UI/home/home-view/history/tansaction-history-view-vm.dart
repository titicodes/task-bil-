import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskitly/core/models/transaction-history-model.dart';

import '../../../base/base.vm.dart';

class TransactionHistoryViewModel extends BaseViewModel {
  TransactionHistoryModel transactionHistoryModel = TransactionHistoryModel();
  List<History>? transactionHistory = [];
  late BuildContext context;
  String? dropdownValue;
  String? selectedCategory;
  bool isVisible = false;

  init(BuildContext contexts) async {
    context = contexts;
    await getLocalHistory();
    if (transactionHistoryModel.results == null) {
      await fetchAllTransactionsHistory();
    }
  }

  List<String> cats = [
    "All categories",
    "Services",
    "Airtime",
    "Betting",
    "Top up",
    "Mobile data"
  ];

  select(String cat) {
    selectedCategory = cat;
    //selectedCategory = cats.isNotEmpty ? cats[0] : cat;
    notifyListeners();
  }

  //::// fetch all the histories available //:://
  fetchAllTransactionsHistory() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getTransactionHistory();
      if (response?.results != null) {
        // banks = response!.results!;
        transactionHistoryModel = response ?? TransactionHistoryModel();
        transactionHistory = response?.results;
        print(
            "The history: ${response?.results?.map((e) => e.transactionType).toList()}");

        // providers = convertToServiceProviderList(bankListResponse);
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

  getLocalHistory() async {
    var res = await repository.getLocalTransactionHistory();
    transactionHistory = res?.results ?? [];
  }

  Stream<List<History>?> getHistories() async* {
    Future.delayed(const Duration(seconds: 30), () async {
      var res = await repository.getLocalTransactionHistory();
      transactionHistory = res?.results ?? [];
      notifyListeners();
    });
    yield transactionHistory;
  }

  @override
  String formatDate(String dateString) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Define the format you want
    final DateFormat formatter = DateFormat('MMM d, HH:mm');

    // Format the DateTime object
    return formatter.format(dateTime);
  }
}

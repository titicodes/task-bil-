import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../../base/base.vm.dart';

class VerifyBVNViewModel extends BaseViewModel {
  onChange(String? val) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  // Method to format date specifically for this view model
  String formatDateForViewModel(DateTime? date) {
    if (date != null) {
      return DateFormat('dd-MM-yyyy').format(date);
    }
    return '';
  }

  submitForVerification() async {
    startLoader();
    try {
      var res = await repository.verifyBVNAndKYC(
          idNumber: bvnController.text.trim(),
          isBvn: true,
          dateOfBirth: formatter.format(dob));
      if (res?.detail?.verificationStatus == "VERIFIED") {
        await repository.getUser();
        showCustomToast("BVN verified successfully!", success: true);
        navigationService.goBack();
      } else {
        showCustomToast(res?.detail?.verificationStatus ?? "");
      }
      stopLoader();
      notifyListeners();
    } catch (err) {
      print(err);
      stopLoader();
      notifyListeners();
    }
  }

  DateTime? dateOfBirth;
  DateTime dob = DateTime.now();
  final formatter = DateFormat('MM-dd-yyyy');

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    required BuildContext context,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future pickToDateTime(
      {required bool picDate, required BuildContext context}) async {
    final date = await pickDateTime(
      dob,
      pickDate: picDate,
      context: context,
    );
    if (date == null) return null;
    dob = date;
    dateOfBirth = date;
    notifyListeners();
  }

  var bvnController = TextEditingController();
}

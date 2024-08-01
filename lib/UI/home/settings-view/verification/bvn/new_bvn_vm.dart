import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskitly/UI/base/base.vm.dart';
import '../../../../../utils/snack_message.dart';

class NewBvnViewModel extends BaseViewModel {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bvnController = TextEditingController();
  DateTime? dateOfBirth;
  DateTime dob = DateTime.now();

  Future<DateTime?> pickDateTime({
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

      final time = Duration(hours: dob.hour, minutes: dob.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(dob),
      );
      if (timeOfDay == null) return null;

      final date = DateTime(dob.year, dob.month, dob.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Future<void> pickToDateTime({
    required bool pickDate,
    required BuildContext context,
  }) async {
    final date = await pickDateTime(
      pickDate: pickDate,
      context: context,
    );
    if (date == null) return;

    dob = date;
    dateOfBirth = date;
    notifyListeners();
  }

  String formatDateForViewModel(DateTime? date) {
    if (date != null) {
      return DateFormat('dd-MM-yyyy').format(date);
    }
    return '';
  }

  onDateOfBirthChanged(DateTime? newDate) {
    dateOfBirth = newDate;
    notifyListeners();
  }

  Future<void> submitForVerification() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    startLoader();

    try {
      final res = await repository.kycBvn(
        idNumber: bvnController.text.trim(),
        type: "BVN",
        dob: formatDateForViewModel(
            dateOfBirth), // Use the specific formatting method
      );

      print(res == null);
      if (res == null) {
        showCustomToast('An error occured! Please try again later.');
      } else {
        if (res.status == true) {
          showCustomToast(res.datail ?? '', success: true);
          await repository.getUser();
          navigationService.goBack();
        } else {
          showCustomToast(res.datail ?? '', success: false);
        }
      }
    } on Exception catch (_) {
      showCustomToast("BVN verification failed, please try again!");
    }

    stopLoader();
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import '../../../../core/models/send-invoice-response.dart';
import '../../../../utils/snack_message.dart';
import '../../../../utils/utils.dart';
import '../../../base/base.vm.dart';

class SendInvoiceViewModel extends BaseViewModel {
  var serviceToRenderController = TextEditingController();
  var serviceAmountController = TextEditingController();
  var additionalInfoController = TextEditingController();
  var startDateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endDateController = TextEditingController();
  var endTimeController = TextEditingController();

  DateTime? startDate;
  DateTime selectedDate = DateTime.now();
  DateTime? endDate;
  DateTime end = DateTime.now();

  clearControllers(SendInvoiceResponse response) {
    startDateController.clear();
    serviceToRenderController.clear();
    serviceAmountController.clear();
    additionalInfoController.clear();
    startTimeController.clear();
    endDateController.clear();
    startDate == null;
    endDate == null;
    selectedDate = DateTime.now();
    end = DateTime.now();
    endTimeController.clear();
    navigationService.goBack(value: response);
  }

  onChanges(String? val) {
    formKey.currentState!.validate();
    // print(formKey.currentState?.validate());
    notifyListeners();
  }

  sendInvoice(List<String> skills) async {
    startLoader();
    try {
      var response = await repository.sendInvoice(
          customerID: appCache.chatDetailResponse.user2Id ?? "",
          skills: skills,
          amount: serviceAmountController.text.trim(),
          startDate: selectedDate.toString(),
          endDate: end.toString(),
          additionalText: additionalInfoController.text.trim());
      if (response == null) {
        showCustomToast("Error sending invoice");
      } else {
        showCustomToast("Invoice sent", success: true);
        await clearControllers(response);
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  Future pickFromDateTime({required bool picDate}) async {
    final date = await pickDateTime(selectedDate, pickDate: picDate);
    if (date == null) return null;

    if (date.isAfter(end)) {
      end = DateTime(date.year, date.month, date.day, date.hour, date.minute);
    }

    if (picDate) {
      startDateController.text = Utils.toDate(selectedDate);
    } else {
      startTimeController.text = Utils.toTime(selectedDate);
    }

    selectedDate = date;
    startDate = date;
    await onChanges("");
    notifyListeners();
  }

  Future pickToDateTime({required bool picDate}) async {
    final date = await pickDateTime(selectedDate, pickDate: picDate);
    if (date == null) return null;

    end = date;
    endDate = date;
    if (picDate) {
      endDateController.text = Utils.toDate(end);
    } else {
      endTimeController.text = Utils.toTime(end);
    }
    await onChanges("");
    notifyListeners();
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    BuildContext context = navigationService.navigatorKey.currentState!.context;
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: initialDate,
        lastDate: DateTime(2101),
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
}

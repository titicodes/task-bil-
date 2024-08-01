import 'package:intl/intl.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../core/models/get-order-response-model.dart';
import '../../base/base.vm.dart';
import '../chat-view/nav-chat-home-view.ui.dart';
import 'report/report-ui.dart';
import 'review/review-ui.dart';

class RequestViewViewModel extends BaseViewModel {
  GetOrderResponse? orderResponse;
  List<Results> orders = [];
  List<Results> displayOrders = [];

  cancel(String orderID) async {
    startLoader();
    try {
      var response =
          await repository.sendOrdersValidator(orderId: orderID, valid: false);
      if (response != null) {
        await repository.getUser();
        showSuccess("Order Canceled", AppStrings.cancelOrderDetail);
      }
      stopLoader();
    } catch (err) {
      stopLoader();
    }
    notifyListeners();
  }

  start(String orderID) async {
    startLoader();
    try {
      var response =
          await repository.sendOrdersAction(orderId: orderID, action: "start");
      if (response != null) {
        await repository.getUser();
        showSuccess("Order Started", response["detail"]);
      }
      stopLoader();
    } catch (err) {
      stopLoader();
    }
    notifyListeners();
  }

  cancelOrder(String orderID) async {
    startLoader();
    try {
      var response =
          await repository.sendOrdersAction(orderId: orderID, action: "cancel");
      if (response != null) {
        await repository.getUser();
        showSuccess("Order Started", response["detail"]);
      }
      stopLoader();
    } catch (err) {
      stopLoader();
    }
    notifyListeners();
  }

  done(String orderID) async {
    startLoader();
    try {
      var response =
          await repository.sendOrdersAction(orderId: orderID, action: "done");
      if (response != null) {
        await repository.getUser();
        showSuccess("Order Completed", response["detail"]);
      }
      stopLoader();
    } catch (err) {
      stopLoader();
    }
    notifyListeners();
  }

  accept(String orderID) async {
    startLoader();
    try {
      var response =
          await repository.sendOrdersValidator(orderId: orderID, valid: true);
      if (response != null) {
        await repository.getUser();
        showSuccess("Order Accepted", response["detail"]);
      }
      stopLoader();
    } catch (err) {
      stopLoader();
    }
    notifyListeners();
  }

  report(String orderID, String order, String name) async {
    navigationService.navigateToWidget(ReportOrderView(
      orderID: orderID,
      reportedName: name,
      order: order,
    ));
  }

  review(String orderID) async {
    navigationService.navigateToWidget(ReviewScreen(
      orderID: orderID,
    ));
  }

  chat() async {
    navigationService.navigateToWidget(const NavChatHomeView());
  }

  confirm(String orderID) async {
    startLoader();
    try {
      var response = await repository.sendOrdersAction(
          orderId: orderID, action: "confirm");
      if (response != null) {
        await repository.getUser();
        showCustomToast("Order has been confirmed", success: true);
        navigationService.navigateToWidget(ReviewScreen(
          orderID: orderID,
        ));
      }
      stopLoader();
    } catch (err) {
      stopLoader();
    }
    notifyListeners();
  }

  updateStoredList(List<Results> newList, List<Results> storedList) {
    List<Results> itemsToRemove = [];

    for (var newItem in newList) {
      var existingItemIndex =
          storedList.indexWhere((item) => item.orderId == newItem.orderId);
      if (existingItemIndex != -1) {
        // If item exists in storedList
        if (storedList[existingItemIndex].status != newItem.status) {
          // If status is different, mark existing item for removal
          // itemsToRemove.add(storedList[existingItemIndex]);
          // Add new item
          storedList.removeAt(existingItemIndex);
          storedList.insert(existingItemIndex, newItem);
        }
        // If status is the same, do nothing
      } else {
        // If item doesn't exist in storedList, add it
        storedList.add(newItem);
      }
    }

    // Remove items marked for removal
    // for (var itemToRemove in itemsToRemove) {
    //   storedList.remove(itemToRemove);
    // }
  }

  bool isOrderAlreadyStored(Results bankResult, List<Results> storedList) {
    for (Results storedBank in storedList) {
      if (storedBank.uid == bankResult.uid &&
          storedBank.status == bankResult.status) {
        return true; // BankResult already exists in storedList
      }
    }
    return false; // BankResult does not exist in storedList
  }

  int messageCount = 0;

  List<Results> tempOrder = [];

  getNew(List<Results> latest) async {
    List<Results> nTempOrder = updateStoredList(latest, tempOrder);
    tempOrder = nTempOrder;
    notifyListeners();
  }

  Future<List<Results>> getAllOrders({String? page}) async {
    try {
      var response = await repository.getOrderService(page: page);
      orderResponse = response;
      if (response?.results != null) {
        List<Results> latest = response?.results ?? [];
        await updateStoredList(latest, tempOrder);

        if (response?.next != null) {
          String next = response?.next ?? "";
          List<String> nexts = next.split("=");
          await getAllOrders(page: nexts[1]);
        }
      }

      return tempOrder;
    } catch (err) {
      return [];
    }
  }

  Stream<List<Results>> getOrderServices() async* {
    var response = await getAllOrders();
    orders = response;
    notifyListeners();
    // orders = response;
    yield response;

    // var response = await getAllOrders();
    // // orders.clear();
    // orders = response;
    // notifyListeners();
    // yield orders;
  }

  String formatDateTime(String dateTimeString) {
    // Parse the date string
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the date according to your preference
    String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);

    return formattedDate;
  }
}

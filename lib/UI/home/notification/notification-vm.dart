import '../../../constants/reuseables.dart';
import '../../../core/models/notification-response.dart';
import '../../base/base.vm.dart';
import '../home.navigation.vm.dart';

class NotificationHomeViewModel extends BaseViewModel {
  final HomeTabViewModel homes;

  List<Notifications> notifications = [];

  NotificationHomeViewModel(this.homes);

  getLocalNot() async {
    var res = await repository.getLocalNotification();
    notifications = res?.notifications ?? [];
    notifyListeners();
  }

  // Future<> getNotifications() async* {
  //   // Future.delayed(const Duration(seconds: 2), () async {
  //   var res = await repository.getLocalNotification();
  //   notifications = res?.notifications ?? [];
  //   // });
  //   yield notifications;
  // }
}

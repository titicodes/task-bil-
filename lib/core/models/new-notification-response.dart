import 'notification-response.dart';

class NotificationIncomingResponse {
  Notifications? message;

  NotificationIncomingResponse({this.message});

  NotificationIncomingResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] != null
        ? Notifications.fromJson(json['message'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

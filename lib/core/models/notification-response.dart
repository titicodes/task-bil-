class NotificationResponses {
  int? generalMsgType;
  List<Notifications>? notifications;

  NotificationResponses({this.generalMsgType, this.notifications});

  NotificationResponses.fromJson(Map<String, dynamic> json) {
    generalMsgType = json['general_msg_type'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['general_msg_type'] = generalMsgType;
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? notificationType;
  String? notificationId;
  String? verb;
  String? naturalTimestamp;
  String? isRead;
  String? timestamp;
  Actions? actions;
  String? valid;
  String? status;

  Notifications(
      {this.notificationType,
      this.notificationId,
      this.verb,
      this.naturalTimestamp,
      this.isRead,
      this.timestamp,
      this.actions,
      this.valid,
      this.status});

  Notifications.fromJson(Map<String, dynamic> json) {
    notificationType = json['notification_type'];
    notificationId = json['notification_id'];
    verb = json['verb'];
    naturalTimestamp = json['natural_timestamp'];
    isRead = json['is_read'];
    timestamp = json['timestamp'];
    actions =
        json['actions'] != null ? Actions.fromJson(json['actions']) : null;
    valid = json['valid'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_type'] = notificationType;
    data['notification_id'] = notificationId;
    data['verb'] = verb;
    data['natural_timestamp'] = naturalTimestamp;
    data['is_read'] = isRead;
    data['timestamp'] = timestamp;
    if (actions != null) {
      data['actions'] = actions!.toJson();
    }
    data['valid'] = valid;
    data['status'] = status;
    return data;
  }
}

class Actions {
  String? redirectUrl;

  Actions({this.redirectUrl});

  Actions.fromJson(Map<String, dynamic> json) {
    redirectUrl = json['redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['redirect_url'] = redirectUrl;
    return data;
  }
}

import 'prodiders-service-response.dart';

class GetOrderResponse {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  GetOrderResponse({this.count, this.next, this.previous, this.results});

  GetOrderResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? uid;
  String? orderId;
  Provider? provider;
  Provider? customer;
  ProviderUserResponse? service;
  String? startDate;
  String? endDate;
  String? date;
  int? amount;
  String? additionalText;
  String? status;
  bool? valid;

  Results(
      {this.orderId,
      this.uid,
      this.provider,
      this.customer,
      this.service,
      this.startDate,
      this.endDate,
      this.date,
      this.amount,
      this.additionalText,
      this.status,
      this.valid});

  Results.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    orderId = json['order_id'];
    provider =
        json['provider'] != null ? Provider.fromJson(json['provider']) : null;
    customer =
        json['customer'] != null ? Provider.fromJson(json['customer']) : null;
    service = json['service'] != null
        ? ProviderUserResponse.fromJson(json['service'])
        : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    date = json['date'];
    amount = json['amount'];
    additionalText = json['additional_text'];
    status = json['status'];
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['uid'] = uid;
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['date'] = date;
    data['amount'] = amount;
    data['additional_text'] = additionalText;
    data['status'] = status;
    data['valid'] = valid;
    return data;
  }
}

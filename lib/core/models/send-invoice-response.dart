class SendInvoiceResponse {
  String? uid;
  String? orderId;
  String? startDate;
  String? endDate;
  String? date;
  int? amount;
  String? additionalText;
  bool? valid;
  String? status;
  String? provider;
  String? customer;
  String? service;

  SendInvoiceResponse(
      {this.uid,
      this.orderId,
      this.startDate,
      this.endDate,
      this.date,
      this.amount,
      this.additionalText,
      this.valid,
      this.status,
      this.provider,
      this.customer,
      this.service});

  SendInvoiceResponse.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    orderId = json['order_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    date = json['date'];
    amount = json['amount'];
    additionalText = json['additional_text'];
    valid = json['valid'];
    status = json['status'];
    provider = json['provider'];
    customer = json['customer'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['order_id'] = orderId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['date'] = date;
    data['amount'] = amount;
    data['additional_text'] = additionalText;
    data['valid'] = valid;
    data['status'] = status;
    data['provider'] = provider;
    data['customer'] = customer;
    data['service'] = service;
    return data;
  }
}

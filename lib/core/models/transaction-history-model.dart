class TransactionHistoryModel {
  int? count;
  var next;
  var previous;
  List<History>? results;

  TransactionHistoryModel({this.count, this.next, this.previous, this.results});

  TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <History>[];
      json['results'].forEach((v) {
        results!.add(History.fromJson(v));
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

class History {
  String? transactionId;
  String? status;
  String? transactionType;
  String? totalFee;
  String? amount;
  String? initiateType;
  var destAccountName;
  var destAccountNumber;
  var destBankName;
  var destBankCode;
  var callbackUrl;
  String? created;
  String? remark;

  History(
      {this.transactionId,
      this.status,
      this.transactionType,
      this.totalFee,
      this.amount,
      this.initiateType,
      this.destAccountName,
      this.destAccountNumber,
      this.destBankName,
      this.destBankCode,
      this.callbackUrl,
      this.created,
      this.remark});

  History.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    status = json['status'];
    transactionType = json['transaction_type'];
    totalFee = json['totalFee'];
    amount = json['amount'];
    initiateType = json['initiateType'];
    destAccountName = json['destAccountName'];
    destAccountNumber = json['destAccountNumber'];
    destBankName = json['destBankName'];
    destBankCode = json['destBankCode'];
    callbackUrl = json['callbackUrl'];
    created = json['created'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['status'] = status;
    data['transaction_type'] = transactionType;
    data['totalFee'] = totalFee;
    data['amount'] = amount;
    data['initiateType'] = initiateType;
    data['destAccountName'] = destAccountName;
    data['destAccountNumber'] = destAccountNumber;
    data['destBankName'] = destBankName;
    data['destBankCode'] = destBankCode;
    data['callbackUrl'] = callbackUrl;
    data['created'] = created;
    data['remark'] = remark;
    return data;
  }
}

// To parse this JSON data, do
//
//     final fundWalletResponse = fundWalletResponseFromJson(jsonString);

import 'dart:convert';

FundWalletResponse fundWalletResponseFromJson(String str) =>
    FundWalletResponse.fromJson(json.decode(str));

String fundWalletResponseToJson(FundWalletResponse data) =>
    json.encode(data.toJson());

class FundWalletResponse {
  Detail? detail;

  FundWalletResponse({
    this.detail,
  });

  factory FundWalletResponse.fromJson(Map<String, dynamic> json) =>
      FundWalletResponse(
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
      );

  Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
      };
}

class Detail {
  Transfer? transfer;
  String? accountNumber;
  String? bankName;
  String? amount;
  String? beneficiary;

  Detail(
      {this.transfer,
      this.accountNumber,
      this.bankName,
      this.amount,
      this.beneficiary});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        transfer: json["Transfer"] == null
            ? null
            : Transfer.fromJson(json["Transfer"]),
        accountNumber: json["AccountNumber"] ?? '',
        bankName: json["BankName"] ?? '',
        amount: json['amount'] ?? 0.0,
        beneficiary: json['Beneficiary'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Transfer": transfer?.toJson(),
        "AccountNumber": accountNumber,
        "BankName": bankName,
        "amount": amount,
        'Beneficiary': beneficiary
      };
}

class Transfer {
  String? account;
  String? bankname;
  String? accountname;

  Transfer({
    this.account,
    this.bankname,
    this.accountname,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
        account: json["account"],
        bankname: json["bankname"],
        accountname: json["accountname"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "bankname": bankname,
        "accountname": accountname,
      };
}

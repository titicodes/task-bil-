class BuyAirtimeModel {
  final bool error;
  final String status;
  final String message;
  final String responseCode;
  final BuyAirtimeResponseData responseData;

  BuyAirtimeModel({
    required this.error,
    required this.status,
    required this.message,
    required this.responseCode,
    required this.responseData,
  });

  factory BuyAirtimeModel.fromJson(Map<String, dynamic> json) {
    return BuyAirtimeModel(
      error: json['data']['error'],
      status: json['data']['status'],
      message: json['data']['message'],
      responseCode: json['data']['responseCode'],
      responseData:
          BuyAirtimeResponseData.fromJson(json['data']['responseData']),
    );
  }
}

class BuyAirtimeResponseData {
  final String packageName;
  final bool paid;
  final String paymentReference;
  final String transactionId;
  final double walletBalance;
  final String vendStatus;
  final String narration;
  final String statusCode;
  final double convenienceFee;
  final String customerMessage;

  BuyAirtimeResponseData({
    required this.packageName,
    required this.paid,
    required this.paymentReference,
    required this.transactionId,
    required this.walletBalance,
    required this.vendStatus,
    required this.narration,
    required this.statusCode,
    required this.convenienceFee,
    required this.customerMessage,
  });

  factory BuyAirtimeResponseData.fromJson(Map<String, dynamic> json) {
    return BuyAirtimeResponseData(
      packageName: json['packageName'],
      paid: json['paid'],
      paymentReference: json['paymentReference'],
      transactionId: json['transactionId'],
      walletBalance: json['walletBalance'].toDouble(),
      vendStatus: json['vendStatus'],
      narration: json['narration'],
      statusCode: json['statusCode'],
      convenienceFee: json['convenienceFee'].toDouble(),
      customerMessage: json['customerMessage'],
    );
  }
}

class ElectricityVendResponseModel {
  late Map<String, dynamic> data;

  ElectricityVendResponseModel({required this.data});

  ElectricityVendResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  ElectricityVendResponseData get responseData =>
      ElectricityVendResponseData.fromJson(data['responseData']);
}

class ElectricityVendResponseData {
  late bool error;
  late String status;
  late String message;
  late String responseCode;
  late ElectricityVendTokenData tokenData;
  late bool paid;
  late String paymentReference;
  late String transactionId;
  late double walletBalance;
  late String vendStatus;
  late String narration;
  late String statusCode;
  late double amount;
  late double convenienceFee;
  late String customerMessage;

  ElectricityVendResponseData({
    required this.error,
    required this.status,
    required this.message,
    required this.responseCode,
    required this.tokenData,
    required this.paid,
    required this.paymentReference,
    required this.transactionId,
    required this.walletBalance,
    required this.vendStatus,
    required this.narration,
    required this.statusCode,
    required this.amount,
    required this.convenienceFee,
    required this.customerMessage,
  });

  ElectricityVendResponseData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    message = json['message'];
    responseCode = json['responseCode'];
    tokenData =
        ElectricityVendTokenData.fromJson(json['responseData']['tokenData']);
    paid = json['paid'];
    paymentReference = json['paymentReference'];
    transactionId = json['transactionId'];
    walletBalance = json['walletBalance'];
    vendStatus = json['vendStatus'];
    narration = json['narration'];
    statusCode = json['statusCode'];
    amount = json['amount'];
    convenienceFee = json['convenienceFee'];
    customerMessage = json['customerMessage'];
  }
}

class ElectricityVendTokenData {
  late Map<String, dynamic> stdToken;
  late String resetToken;
  late String configureToken;
  late String kct1;
  late String kct2;

  ElectricityVendTokenData({
    required this.stdToken,
    required this.resetToken,
    required this.configureToken,
    required this.kct1,
    required this.kct2,
  });

  ElectricityVendTokenData.fromJson(Map<String, dynamic> json) {
    stdToken = json['stdToken'];
    resetToken = json['resetToken'];
    configureToken = json['configureToken'];
    kct1 = json['kct1'];
    kct2 = json['kct2'];
  }
}

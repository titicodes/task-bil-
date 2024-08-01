class AccountVerifyResponse {
  final bool success;
  final AccountData? data;
  final String message;

  AccountVerifyResponse({
    required this.success,
    this.data,
    required this.message,
  });

  factory AccountVerifyResponse.fromJson(Map<String, dynamic> json) {
    return AccountVerifyResponse(
      success: json['success'] as bool,
      data: json['data'] != null ? AccountData.fromJson(json['data']) : null,
      message: json['message'] as String,
    );
  }
}

class AccountData {
  final String accountName;
  final String accountNumber;

  AccountData({
    required this.accountName,
    required this.accountNumber,
  });

  factory AccountData.fromJson(Map<String, dynamic> json) {
    return AccountData(
      accountName: json['account_name'] as String,
      accountNumber: json['account_number'] as String,
    );
  }
}


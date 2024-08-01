class CustomerAccountResponse {
  late CustomerAccountDetail detail;

  CustomerAccountResponse({required this.detail});

  CustomerAccountResponse.fromJson(Map<String, dynamic> json) {
    detail = CustomerAccountDetail.fromJson(json['detail']);
  }
}

class CustomerAccountDetail {
  late bool error;
  late String status;
  late String message;
  late String responseCode;
  late CustomerAccountResponseData responseData;

  CustomerAccountDetail({
    required this.error,
    required this.status,
    required this.message,
    required this.responseCode,
    required this.responseData,
  });

  CustomerAccountDetail.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    message = json['message'];
    responseCode = json['responseCode'];
    responseData = CustomerAccountResponseData.fromJson(json['responseData']);
  }
}

class CustomerAccountResponseData {
  late String billerName;
  late Customer customer;
  late bool paid;
  late String statusCode;
  late int amount;

  CustomerAccountResponseData({
    required this.billerName,
    required this.customer,
    required this.paid,
    required this.statusCode,
    required this.amount,
  });

  CustomerAccountResponseData.fromJson(Map<String, dynamic> json) {
    billerName = json['billerName'];
    customer = Customer.fromJson(json['customer']);
    paid = json['paid'];
    statusCode = json['statusCode'];
    amount = json['amount'];
  }
}

class Customer {
  late String firstName;
  late String lastName;
  late String customerName;
  late String accountNumber;
  late String dueDate;
  late bool canVend;
  late String phoneNumber;
  late String emailAddress;

  Customer({
    required this.firstName,
    required this.lastName,
    required this.customerName,
    required this.accountNumber,
    required this.dueDate,
    required this.canVend,
    required this.phoneNumber,
    required this.emailAddress,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    customerName = json['customerName'];
    accountNumber = json['accountNumber'];
    dueDate = json['dueDate'];
    canVend = json['canVend'];
    phoneNumber = json['phoneNumber'];
    emailAddress = json['emailAddress'];
  }
}

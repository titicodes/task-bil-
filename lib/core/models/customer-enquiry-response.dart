class CustomerEnquiryResponse {
  Detail? detail;

  CustomerEnquiryResponse({this.detail});

  CustomerEnquiryResponse.fromJson(Map<String, dynamic> json) {
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    return data;
  }
}

class Detail {
  bool? error;
  String? status;
  String? message;
  String? responseCode;
  ResponseDataEnquiry? responseData;

  Detail(
      {this.error,
      this.status,
      this.message,
      this.responseCode,
      this.responseData});

  Detail.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    message = json['message'];
    responseCode = json['responseCode'];
    responseData = json['responseData'] != null
        ? new ResponseDataEnquiry.fromJson(json['responseData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['status'] = this.status;
    data['message'] = this.message;
    data['responseCode'] = this.responseCode;
    if (this.responseData != null) {
      data['responseData'] = this.responseData!.toJson();
    }
    return data;
  }
}

// class Detail {
//   bool? error;
//   String? status;
//   String? message;
//   String? responseCode;
//   ResponseDataEnquiry? responseData; // Changed here
//
//   Detail(
//       {this.error,
//       this.status,
//       this.message,
//       this.responseCode,
//       this.responseData});
//
//   Detail.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     status = json['status'];
//     message = json['message'];
//     responseCode = json['responseCode'];
//     responseData = json['responseData'] != null
//         ? ResponseDataEnquiry.fromJson(json['responseData']) // Changed here
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['error'] = error;
//     data['status'] = status;
//     data['message'] = message;
//     data['responseCode'] = responseCode;
//     if (responseData != null) {
//       data['responseData'] = responseData!.toJson();
//     }
//     return data;
//   }
// }

class ResponseDataEnquiry {
  // Changed here
  String? billerName;
  Customer? customer;
  bool? paid;
  String? statusCode;
  int? minPayableAmount;

  ResponseDataEnquiry(
      {this.billerName,
      this.customer,
      this.paid,
      this.statusCode,
      this.minPayableAmount});

  ResponseDataEnquiry.fromJson(Map<String, dynamic> json) {
    billerName = json['billerName'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    paid = json['paid'];
    statusCode = json['statusCode'];
    minPayableAmount = json['minPayableAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billerName'] = billerName;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['paid'] = paid;
    data['statusCode'] = statusCode;
    data['minPayableAmount'] = minPayableAmount;
    return data;
  }
}

class Customer {
  String? firstName;
  String? lastName;
  String? customerName;
  String? accountNumber;
  String? customerType;
  int? arrearsBalance;
  String? address;
  String? phoneNumber;
  String? emailAddress;

  Customer(
      {this.firstName,
      this.lastName,
      this.customerName,
      this.accountNumber,
      this.customerType,
      this.arrearsBalance,
      this.address,
      this.phoneNumber,
      this.emailAddress});

  Customer.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    customerName = json['customerName'];
    accountNumber = json['accountNumber'];
    customerType = json['customerType'];
    arrearsBalance = json['arrearsBalance'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    emailAddress = json['emailAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['customerName'] = customerName;
    data['accountNumber'] = accountNumber;
    data['customerType'] = customerType;
    data['arrearsBalance'] = arrearsBalance;
    data['address'] = address;
    data['phoneNumber'] = phoneNumber;
    data['emailAddress'] = emailAddress;
    return data;
  }
}

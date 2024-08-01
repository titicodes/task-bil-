import 'prodiders-service-response.dart';

class ProviderServiceDetailResponse {
  bool? status;
  List<ProviderUserResponse>? data;

  ProviderServiceDetailResponse({this.status, this.data});

  ProviderServiceDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProviderUserResponse>[];
      json['data'].forEach((v) {
        data!.add(ProviderUserResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

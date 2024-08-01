import 'dart:convert';

class TvBillerResponse {
  Data? data;

  TvBillerResponse({
    this.data,
  });

  TvBillerResponse copyWith({
    Data? data,
  }) =>
      TvBillerResponse(
        data: data ?? this.data,
      );

  factory TvBillerResponse.fromRawJson(String str) =>
      TvBillerResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvBillerResponse.fromJson(Map<String, dynamic> json) =>
      TvBillerResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  bool? error;
  String? status;
  String? message;
  String? responseCode;
  List<ResponseData>? responseData;

  Data({
    this.error,
    this.status,
    this.message,
    this.responseCode,
    this.responseData,
  });

  Data copyWith({
    bool? error,
    String? status,
    String? message,
    String? responseCode,
    List<ResponseData>? responseData,
  }) =>
      Data(
        error: error ?? this.error,
        status: status ?? this.status,
        message: message ?? this.message,
        responseCode: responseCode ?? this.responseCode,
        responseData: responseData ?? this.responseData,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        error: json["error"],
        status: json["status"],
        message: json["message"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null
            ? []
            : List<ResponseData>.from(
                json["responseData"]!.map((x) => ResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "status": status,
        "message": message,
        "responseCode": responseCode,
        "responseData": responseData == null
            ? []
            : List<dynamic>.from(responseData!.map((x) => x.toJson())),
      };
}

class ResponseData {
  int? id;
  String? name;
  String? slug;
  int? groupId;
  bool? skipValidation;
  bool? handleWithProductCode;
  bool? isRestricted;
  bool? hideInstitution;

  ResponseData({
    this.id,
    this.name,
    this.slug,
    this.groupId,
    this.skipValidation,
    this.handleWithProductCode,
    this.isRestricted,
    this.hideInstitution,
  });

  ResponseData copyWith({
    int? id,
    String? name,
    String? slug,
    int? groupId,
    bool? skipValidation,
    bool? handleWithProductCode,
    bool? isRestricted,
    bool? hideInstitution,
  }) =>
      ResponseData(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        groupId: groupId ?? this.groupId,
        skipValidation: skipValidation ?? this.skipValidation,
        handleWithProductCode:
            handleWithProductCode ?? this.handleWithProductCode,
        isRestricted: isRestricted ?? this.isRestricted,
        hideInstitution: hideInstitution ?? this.hideInstitution,
      );

  factory ResponseData.fromRawJson(String str) =>
      ResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        groupId: json["groupId"],
        skipValidation: json["skipValidation"],
        handleWithProductCode: json["handleWithProductCode"],
        isRestricted: json["isRestricted"],
        hideInstitution: json["hideInstitution"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "groupId": groupId,
        "skipValidation": skipValidation,
        "handleWithProductCode": handleWithProductCode,
        "isRestricted": isRestricted,
        "hideInstitution": hideInstitution,
      };
}

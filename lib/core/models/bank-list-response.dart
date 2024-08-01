class BankListResponse {
  int? count;
  String? next;
  String? previous;
  List<BankResult>? results;

  BankListResponse({this.count, this.next, this.previous, this.results});

  BankListResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <BankResult>[];
      json['results'].forEach((v) {
        results!.add(BankResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results;
    }
    return data;
  }
}

class StoreBankListResponse {
  List<BankResult>? results;

  StoreBankListResponse({this.results});

  StoreBankListResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <BankResult>[];
      json['results'].forEach((v) {
        results!.add(BankResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results;
    }
    return data;
  }
}

class BankResult {
  String? code;
  String? name;

  BankResult({this.code, this.name});

  BankResult.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}

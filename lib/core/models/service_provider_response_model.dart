class ServiceProviderResponseModel {
  bool? status;
  List<Data>? data;

  ServiceProviderResponseModel({this.status, this.data});

  ServiceProviderResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? uid;
  Provider? provider;
  String? companyName;
  Category? category;
  int? amount;
  List<String>? skills;
  dynamic image;
  List<String>? weekdays;
  String? startHour;
  String? endHour;
  String? description;
  String? country;
  String? state;
  int? orders;
  dynamic rating;

  Data(
      {this.uid,
      this.provider,
      this.companyName,
      this.category,
      this.amount,
      this.skills,
      this.image,
      this.weekdays,
      this.startHour,
      this.endHour,
      this.description,
      this.country,
      this.state,
      this.orders,
      this.rating});

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    provider =
        json['provider'] != null ? Provider.fromJson(json['provider']) : null;
    companyName = json['company_name'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    amount = json['amount'];
    skills = json['skills'].cast<String>();
    image = json['image'];
    weekdays = json['weekdays'].cast<String>();
    startHour = json['start_hour'];
    endHour = json['end_hour'];
    description = json['description'];
    country = json['country'];
    state = json['state'];
    orders = json['orders'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    data['company_name'] = companyName;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['amount'] = amount;
    data['skills'] = skills;
    data['image'] = image;
    data['weekdays'] = weekdays;
    data['start_hour'] = startHour;
    data['end_hour'] = endHour;
    data['description'] = description;
    data['country'] = country;
    data['state'] = state;
    data['orders'] = orders;
    data['rating'] = rating;
    return data;
  }
}

class Provider {
  String? uid;
  String? username;
  bool? isOnline;

  Provider({this.uid, this.username, this.isOnline});

  Provider.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    isOnline = json['is_online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['username'] = username;
    data['is_online'] = isOnline;
    return data;
  }
}

class Category {
  String? uid;
  String? name;
  String? image;
  int? serviceProviders;

  Category({this.uid, this.name, this.image, this.serviceProviders});

  Category.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    image = json['image'];
    serviceProviders = json['service_providers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['image'] = image;
    data['service_providers'] = serviceProviders;
    return data;
  }
}

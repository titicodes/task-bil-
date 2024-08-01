import 'dart:convert';

import 'prodiders-service-response.dart';

class AllSelectedServicesCategoriesList {
  int count;
  dynamic next;
  dynamic previous;
  List<ServiceCategory> results;

  AllSelectedServicesCategoriesList({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory AllSelectedServicesCategoriesList.fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);
    return AllSelectedServicesCategoriesList(
      count: data['count'],
      next: data['next'],
      previous: data['previous'],
      results: List<ServiceCategory>.from(
        data['results'].map((category) => ServiceCategory.fromJson(category)),
      ),
    );
  }
}

class ServiceCategory {
  String uid;
  Provider provider;
  String companyName;
  Category category;
  int amount;
  String skill;
  List<String> weekdays;
  String country;
  String state;
  int orders;
  dynamic rating;

  ServiceCategory({
    required this.uid,
    required this.provider,
    required this.companyName,
    required this.category,
    required this.amount,
    required this.skill,
    required this.weekdays,
    required this.country,
    required this.state,
    required this.orders,
    required this.rating,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      uid: json['uid'],
      provider: Provider.fromJson(json['provider']),
      companyName: json['company_name'],
      category: Category.fromJson(json['category']),
      amount: json['amount'],
      skill: json['skill'],
      weekdays: List<String>.from(json['weekdays']),
      country: json['country'],
      state: json['state'],
      orders: json['orders'],
      rating: json['rating'],
    );
  }
  factory ServiceCategory.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return ServiceCategory.fromJson(json);
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

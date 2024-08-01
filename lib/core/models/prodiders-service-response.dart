import 'dart:convert';

import 'all_selected_categories_list.dart';

List<ProviderUserResponse> geProviderUserListFromJson(String str) =>
    List<ProviderUserResponse>.from(
        json.decode(str).map((x) => ProviderUserResponse.fromJson(x)));

class ProviderUserResponse {
  String? uid;
  Provider? provider;
  String? companyName;
  Category? category;
  double? amount;
  List<String>? skills;
  String? image;
  List<String>? weekdays;
  String? startHour;
  String? endHour;
  String? description;
  String? country;
  String? state;
  int? orders;
  String? createdAt;
  List<Ratings>? ratings;

  ProviderUserResponse(
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
      this.createdAt,
      this.orders,
      this.ratings});

  ProviderUserResponse.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    provider =
        json['provider'] != null ? Provider.fromJson(json['provider']) : null;
    companyName = json['company_name'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    amount = double.tryParse(json['amount'].toString()) ?? 0.0;
    skills = json['skills'].cast<String>();
    image = json['image'];
    createdAt = json['created_at'];
    weekdays = json['weekdays'].cast<String>();
    startHour = json['start_hour'];
    endHour = json['end_hour'];
    description = json['description'];
    country = json['country'];
    state = json['state'];
    orders = json['orders'];
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(Ratings.fromJson(v));
      });
    }
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
    data['created_at'] = createdAt;
    data['skills'] = skills;
    data['image'] = image;
    data['weekdays'] = weekdays;
    data['start_hour'] = startHour;
    data['end_hour'] = endHour;
    data['description'] = description;
    data['country'] = country;
    data['state'] = state;
    data['orders'] = orders;
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provider {
  String? uid;
  String? username;
  String? profileImage;
  bool? isOnline;

  Provider({this.uid, this.username, this.profileImage, this.isOnline});

  Provider.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    profileImage = json['profile_image'];
    isOnline = json['is_online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['username'] = username;
    data['profile_image'] = profileImage;
    data['is_online'] = isOnline;
    return data;
  }
}

class Ratings {
  double? rating;
  String? comment;
  String? profileImage;
  String? name;
  String? createdAt;

  Ratings(
      {this.rating,
      this.comment,
      this.profileImage,
      this.name,
      this.createdAt});

  Ratings.fromJson(Map<String, dynamic> json) {
    rating = double.tryParse(json['rating'].toString()) ?? 0.0;
    comment = json['comment'];
    profileImage = json['profile_image'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['comment'] = comment;
    data['profile_image'] = profileImage;
    data['name'] = name;
    data['created_at'] = createdAt;
    return data;
  }

  static double calculateAverageRating(List<Ratings>? ratings) {
    if (ratings == null || ratings.isEmpty) {
      return 0.0; // Return 0 if the list is empty to avoid division by zero
    }

    double sum = 0.0;
    for (var rating in ratings) {
      sum += rating.rating ?? 0.0; // Add the rating to the sum
    }

    double average = sum / ratings.length; // Calculate the average rating
    return double.parse(
        average.toStringAsFixed(2)); // Round up to 2 decimal places
  }
}

class CreateServiceResponse {
  String? uid;
  String? companyName;
  String? image;
  int? amount;
  List<String>? skill;
  List<String>? weekdays;
  String? startHour;
  String? endHour;
  String? description;
  String? country;
  String? state;
  String? provider;
  String? category;

  CreateServiceResponse(
      {this.uid,
      this.companyName,
      this.image,
      this.amount,
      this.skill,
      this.weekdays,
      this.startHour,
      this.endHour,
      this.description,
      this.country,
      this.state,
      this.provider,
      this.category});

  CreateServiceResponse.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    companyName = json['company_name'];
    image = json['image'];
    amount = json['amount'];
    skill = json['skill'];
    weekdays = json['weekdays'].cast<String>();
    startHour = json['start_hour'];
    endHour = json['end_hour'];
    description = json['description'];
    country = json['country'];
    state = json['state'];
    provider = json['provider'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['company_name'] = companyName;
    data['image'] = image;
    data['amount'] = amount;
    data['skill'] = skill;
    data['weekdays'] = weekdays;
    data['start_hour'] = startHour;
    data['end_hour'] = endHour;
    data['description'] = description;
    data['country'] = country;
    data['state'] = state;
    data['provider'] = provider;
    data['category'] = category;
    return data;
  }
}

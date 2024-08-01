class SubmitReviewResponse {
  String? uid;
  String? user;
  String? order;
  int? rating;
  String? comment;
  String? createdAt;

  SubmitReviewResponse(
      {this.uid,
      this.user,
      this.order,
      this.rating,
      this.comment,
      this.createdAt});

  SubmitReviewResponse.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    user = json['user'];
    order = json['order'];
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['user'] = user;
    data['order'] = order;
    data['rating'] = rating;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    return data;
  }
}

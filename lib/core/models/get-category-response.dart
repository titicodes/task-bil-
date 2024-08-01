import 'package:taskitly/core/models/all_selected_categories_list.dart';

class GetCategoryResponse {
  int? count;
  String? next;
  String? previous;
  List<Category>? results;

  GetCategoryResponse({this.count, this.next, this.previous, this.results});

  GetCategoryResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'] as int?;
    next = json['next'] as String?;
    previous = json['previous'] as String?;
    if (json['results'] != null) {
      results = <Category>[];
      json['results'].forEach((v) {
        results!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

import 'all_selected_categories_list.dart';

class GetSkillsResponse {
  int? count;
  int? next;
  int? previous;
  List<Skill>? results;

  GetSkillsResponse({this.count, this.next, this.previous, this.results});

  GetSkillsResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'] as int?;
    next = json['next'] != null ? int.tryParse(json['next']) : null;
    previous = json['previous'] != null ? int.tryParse(json['previous']) : null;
    if (json['results'] != null) {
      results = <Skill>[];
      json['results'].forEach((v) {
        results!.add(Skill.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next?.toString();
    data['previous'] = previous?.toString();
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Skill {
  String? name;
  Category? category;

  Skill({this.name, this.category});

  Skill.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

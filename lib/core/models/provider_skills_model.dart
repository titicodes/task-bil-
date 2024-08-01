import 'all_selected_categories_list.dart';

class ProviderSkillsModel {
  final int? count;
  final String next;
  final String previous;
  final List<SkillResult> results;

  ProviderSkillsModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory ProviderSkillsModel.fromJson(Map<String, dynamic> json) {
    return ProviderSkillsModel(
      count: json['count'] ?? 0,
      next: json['next'] ?? "",
      previous: json['previous'] ?? "",
      results: (json['results'] as List<dynamic>)
          .map((result) => SkillResult.fromJson(result))
          .toList(),
    );
  }
}

class SkillResult {
  final String? name;
  final Category category;

  SkillResult({
    required this.name,
    required this.category,
  });

  factory SkillResult.fromJson(Map<String, dynamic> json) {
    return SkillResult(
      name: json['name'] ?? "",
      category: Category.fromJson(json['category']),
    );
  }
}

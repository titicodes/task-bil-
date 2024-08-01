class ServiceCategoriesList {
  int count;
  String next;
  String previous;
  List<ServiceCategory> results;

  ServiceCategoriesList({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory ServiceCategoriesList.fromJson(Map<String, dynamic> json) {
    return ServiceCategoriesList(
      //count: json['count'] is int ? json['count'] : int.tryParse(json['count'] ?? '') ?? 0,
      count: json['count'] ?? 0,
      next: json['next'] ?? "",
      previous: json['previous'] ?? "",
      results: (json['results'] as List<dynamic>?)
              ?.map((result) => ServiceCategory.fromJson(result))
              .toList() ??
          [],
    );
  }
}

class ServiceCategory {
  String uid;
  String name;
  String image;
  final serviceProviders;

  ServiceCategory({
    required this.uid,
    required this.name,
    required this.image,
    required this.serviceProviders,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      uid: json['uid'] ?? "",
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      serviceProviders: json['service_providers'] ?? "",
    );
  }
}

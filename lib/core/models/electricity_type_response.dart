class BillerPackage {
  final int id;
  final String name;
  final String slug;
  final int billerId;
  final int sequenceNumber;

  BillerPackage({
    required this.id,
    required this.name,
    required this.slug,
    required this.billerId,
    required this.sequenceNumber,
  });

  factory BillerPackage.fromJson(Map<String, dynamic> json) {
    return BillerPackage(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      billerId: json['billerId'] ?? 0,
      sequenceNumber: json['sequenceNumber'] ?? 0,
    );
  }
}

class BillerPackagesResponse {
  final List<BillerPackage> responseData;

  BillerPackagesResponse({
    required this.responseData,
  });

  factory BillerPackagesResponse.fromJson(Map<String, dynamic> json) {
    return BillerPackagesResponse(
      responseData: (json['data']['responseData'] as List)
          .map((package) => BillerPackage.fromJson(package))
          .toList(),
    );
  }
}

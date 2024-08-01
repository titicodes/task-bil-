class OrderStats {
  final double averageRating;
  final double completionRate;

  OrderStats({
    required this.averageRating,
    required this.completionRate,
  });

  factory OrderStats.fromJson(dynamic json) {
    return OrderStats(
      averageRating: json["average_rating"].toDouble(),
      completionRate: json["completion_rate"].toDouble(),
    );
  }
}
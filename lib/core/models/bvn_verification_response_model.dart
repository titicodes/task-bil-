import 'dart:convert';

import 'package:equatable/equatable.dart';

class BvnVerificationResponseModel extends Equatable {
  final bool? status;
  final String? datail;

  const BvnVerificationResponseModel({this.status, this.datail});

  factory BvnVerificationResponseModel.fromMap(Map<String, dynamic> data) {
    return BvnVerificationResponseModel(
      status: data['status'] as bool?,
      datail: data['datail'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'datail': datail,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BvnVerificationResponseModel].
  factory BvnVerificationResponseModel.fromJson(String data) {
    return BvnVerificationResponseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BvnVerificationResponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  BvnVerificationResponseModel copyWith({
    bool? status,
    String? datail,
  }) {
    return BvnVerificationResponseModel(
      status: status ?? this.status,
      datail: datail ?? this.datail,
    );
  }

  @override
  List<Object?> get props => [status, datail];
}

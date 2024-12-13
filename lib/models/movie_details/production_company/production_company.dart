import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'production_company.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompany extends Equatable {
  final int id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  const ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}

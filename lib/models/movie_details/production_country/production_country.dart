import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'production_country.g.dart';

@JsonSerializable()
class ProductionCountry extends Equatable {
  @JsonKey(name: 'iso_3166_1')
  final String iso3166_1;
  final String name;

  const ProductionCountry({
    required this.iso3166_1,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);

  @override
  List<Object?> get props => [iso3166_1, name];
}

import 'package:json_annotation/json_annotation.dart';
part 'cast.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String character;
  final String creditId;
  final int order;
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) =>
      _$CastFromJson(json);
  Map<String, dynamic> toJson() => _$CastToJson(this);
}
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'created_by.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatedBy extends Equatable {
  final int id;
  final String creditId;
  final String name;
  final String originalName;
  final int gender;
  final String? profilePath;

  const CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    required this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);
  Map<String, dynamic> toJson() => _$CreatedByToJson(this);

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        originalName,
        gender,
        profilePath,
      ];
}

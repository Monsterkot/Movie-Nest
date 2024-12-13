import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spoken_language.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguage extends Equatable {
  final String englishName;
  @JsonKey(name: 'iso_639_1')
  final String iso639_1;
  final String name;

  const SpokenLanguage({
    required this.englishName,
    required this.iso639_1,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => _$SpokenLanguageFromJson(json);
  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);

  @override
  List<Object?> get props => [englishName, iso639_1, name];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'cast/cast.dart';
import 'crew/crew.dart';
part 'movie_details_credits.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetailsCredits extends Equatable {
  final List<Cast> cast;
  final List<Crew> crew;
  const MovieDetailsCredits({
    required this.cast,
    required this.crew,
  });

  factory MovieDetailsCredits.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsCreditsFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsCreditsToJson(this);

  @override
  List<Object?> get props => [cast, crew];
}

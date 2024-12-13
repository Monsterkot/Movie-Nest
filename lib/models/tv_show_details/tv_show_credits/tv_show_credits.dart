import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'cast/cast.dart';
import 'crew/crew.dart';
part 'tv_show_credits.g.dart';

@JsonSerializable(explicitToJson: true)
class TvShowCredits extends Equatable {
  final List<Cast> cast;
  final List<Crew> crew;
  const TvShowCredits({
    required this.cast,
    required this.crew,
  });

  factory TvShowCredits.fromJson(Map<String, dynamic> json) => _$TvShowCreditsFromJson(json);
  Map<String, dynamic> toJson() => _$TvShowCreditsToJson(this);

  @override
  List<Object?> get props => [cast, crew];
}

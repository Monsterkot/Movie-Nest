import 'package:json_annotation/json_annotation.dart';
import 'cast/cast.dart';
import 'crew/crew.dart';
part 'tv_show_credits.g.dart';

@JsonSerializable(explicitToJson: true)
class TvShowCredits {
  final List<Cast> cast;
  final List<Crew> crew;
  TvShowCredits({
    required this.cast,
    required this.crew,
  });

  factory TvShowCredits.fromJson(Map<String, dynamic> json) =>
      _$TvShowCreditsFromJson(json);
  Map<String, dynamic> toJson() => _$TvShowCreditsToJson(this);
}
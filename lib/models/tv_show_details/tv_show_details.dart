import 'package:json_annotation/json_annotation.dart';
import 'package:movie_nest_app/models/genre/genre.dart';
import 'package:movie_nest_app/models/tv_show_details/created_by/created_by.dart';
import 'package:movie_nest_app/models/tv_show_details/tv_show_credits/tv_show_credits.dart';
import 'tv_show_videos/tv_show_videos.dart';
part 'tv_show_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvShowDetails {
  final String? backdropPath;
  final List<CreatedBy> createdBy;
  @JsonKey(fromJson: _parseDateFromString)
  final DateTime? firstAirDate;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalName;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final List<Genre> genres;
  final TvShowCredits credits;
  final TvShowVideos videos;

  TvShowDetails({
    required this.backdropPath,
    required this.createdBy,
    required this.firstAirDate,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.genres,
    required this.credits,
    required this.videos,
  });

  factory TvShowDetails.fromJson(Map<String, dynamic> json) => _$TvShowDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowDetailsToJson(this);

  static DateTime? _parseDateFromString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    return DateTime.tryParse(rawDate);
  }
}

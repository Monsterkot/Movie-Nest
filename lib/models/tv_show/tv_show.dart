import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_nest_app/models/trending_content/trending_item.dart';
part 'tv_show.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TvShow extends TrendingItem with EquatableMixin {
  final String? backdropPath;
  @JsonKey(fromJson: _parseDateFromString)
  final DateTime? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  const TvShow({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required super.mediaType,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) => _$TvShowFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowToJson(this);

  static DateTime? _parseDateFromString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    return DateTime.tryParse(rawDate);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
        mediaType,
      ];
}

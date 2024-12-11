import 'package:json_annotation/json_annotation.dart';
import 'package:movie_nest_app/models/movie/movie.dart';
import '../../constants/gender.dart';
import '../trending_content/trending_item.dart';
import '../tv_show/tv_show.dart';
part 'person_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PersonDetails {
  final bool adult;
  final List<String> alsoKnownAs;
  final String biography;
  @JsonKey(fromJson: _parseDateFromString)
  final DateTime? birthday;
  @JsonKey(fromJson: _parseDateFromString)
  final DateTime? deathday;
  @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson)
  final Gender gender;
  final String? homepage;
  final int id;
  final String imdbId;
  final String knownForDepartment;
  final String name;
  final String placeOfBirth;
  final double popularity;
  final String? profilePath;
  @JsonKey(fromJson: _combineCredits, toJson: _combineCreditsToJson)
  final List<TrendingItem> combinedCredits;

  PersonDetails({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
    required this.combinedCredits,
  });

  factory PersonDetails.fromJson(Map<String, dynamic> json) => _$PersonDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PersonDetailsToJson(this);

  static List<TrendingItem> _combineCredits(Map<String, dynamic> combinedCredits) {
    List<TrendingItem> items = [];

    // Обрабатываем cast
    List<dynamic> cast = combinedCredits['cast'] ?? [];
    for (var json in cast) {
      items.add(parseTrendingItem(json as Map<String, dynamic>));
    }

    // Обрабатываем crew
    List<dynamic> crew = combinedCredits['crew'] ?? [];
    for (var json in crew) {
      items.add(parseTrendingItem(json as Map<String, dynamic>));
    }

    return items;
  }

  static List<Map<String, dynamic>> _combineCreditsToJson(List<TrendingItem> items) {
    List<Map<String, dynamic>> jsonList = [];

    for (var item in items) {
      switch (item.mediaType) {
        case 'movie':
          final movie = item as Movie;
          jsonList.add(movie.toJson());
          break;
        case 'tv':
          final tvShow = item as TvShow;
          jsonList.add(tvShow.toJson());
          break;
        default:
          throw UnsupportedError('Unknown media type: ${item.mediaType}');
      }
    }

    return jsonList;
  }

  static TrendingItem parseTrendingItem(Map<String, dynamic> json) {
    // Определяем тип объекта по `media_type`
    final mediaType = json['media_type'] as String;
    switch (mediaType) {
      case 'movie':
        return Movie.fromJson(json);
      case 'tv':
        return TvShow.fromJson(json);
      default:
        throw UnsupportedError('Unknown media type: $mediaType');
    }
  }

  static DateTime? _parseDateFromString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    return DateTime.tryParse(rawDate);
  }

  static Gender _genderFromJson(int value) => Gender.fromValue(value);

  static int _genderToJson(Gender gender) => Gender.toValue(gender);
}

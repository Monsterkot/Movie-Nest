import 'package:json_annotation/json_annotation.dart';
import 'package:movie_nest_app/models/tv_show/tv_show.dart';

part 'popular_tv_show_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularTvShowResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<TvShow> tvShows;
  final int totalPages;
  final int totalResults;

  PopularTvShowResponse({
    required this.page,
    required this.tvShows,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularTvShowResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularTvShowResponseFromJson(json);
    
  Map<String, dynamic> toJson() => _$PopularTvShowResponseToJson(this);
}

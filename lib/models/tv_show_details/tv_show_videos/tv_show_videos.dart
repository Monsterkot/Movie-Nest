import 'package:json_annotation/json_annotation.dart';
import 'package:movie_nest_app/models/video/video.dart';
part 'tv_show_videos.g.dart';
@JsonSerializable(explicitToJson: true)
class TvShowVideos {
  final List<Video> results;
  TvShowVideos({
    required this.results,
  });

  factory TvShowVideos.fromJson(Map<String, dynamic> json) => _$TvShowVideosFromJson(json);
  Map<String, dynamic> toJson() => _$TvShowVideosToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
import '../../video/video.dart';

part 'movie_details_videos.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetailsVideos {
  final List<Video> results;
  MovieDetailsVideos({
    required this.results,
  });

  factory MovieDetailsVideos.fromJson(Map<String, dynamic> json) => _$MovieDetailsVideosFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsVideosToJson(this);
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../video/video.dart';

part 'movie_details_videos.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetailsVideos extends Equatable{
  final List<Video> results;
  
  const MovieDetailsVideos({
    required this.results,
  });

  factory MovieDetailsVideos.fromJson(Map<String, dynamic> json) => _$MovieDetailsVideosFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsVideosToJson(this);
  
  @override
  List<Object?> get props => [results];
}

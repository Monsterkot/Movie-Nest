// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_videos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShowVideos _$TvShowVideosFromJson(Map<String, dynamic> json) => TvShowVideos(
      results: (json['results'] as List<dynamic>)
          .map((e) => Video.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvShowVideosToJson(TvShowVideos instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_credits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShowCredits _$TvShowCreditsFromJson(Map<String, dynamic> json) =>
    TvShowCredits(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => Crew.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvShowCreditsToJson(TvShowCredits instance) =>
    <String, dynamic>{
      'cast': instance.cast.map((e) => e.toJson()).toList(),
      'crew': instance.crew.map((e) => e.toJson()).toList(),
    };

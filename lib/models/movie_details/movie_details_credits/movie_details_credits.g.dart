// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_credits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsCredits _$MovieDetailsCreditsFromJson(Map<String, dynamic> json) =>
    MovieDetailsCredits(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => Crew.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailsCreditsToJson(
        MovieDetailsCredits instance) =>
    <String, dynamic>{
      'cast': instance.cast.map((e) => e.toJson()).toList(),
      'crew': instance.crew.map((e) => e.toJson()).toList(),
    };

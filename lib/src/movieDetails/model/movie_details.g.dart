// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailResponse _$MovieDetailResponseFromJson(Map<String, dynamic> json) {
  return MovieDetailResponse(
    id: json['id'] as int,
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Results.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MovieDetailResponseToJson(
        MovieDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'results': instance.results,
    };

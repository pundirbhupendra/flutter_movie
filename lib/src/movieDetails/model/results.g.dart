// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return Results(
    id: json['id'] as String,
    iso6391: json['iso_639_1'] as String,
    iso31661: json['iso_3166_1'] as String,
    key: json['key'] as String,
    name: json['name'] as String,
    site: json['site'] as String,
    size: json['size'] as int,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'id': instance.id,
      'iso_639_1': instance.iso6391,
      'iso_3166_1': instance.iso31661,
      'key': instance.key,
      'name': instance.name,
      'site': instance.site,
      'size': instance.size,
      'type': instance.type,
    };

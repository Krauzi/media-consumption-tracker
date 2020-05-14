// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movies _$MoviesFromJson(Map<String, dynamic> json) {
  return Movies(
    search: (json['Search'] as List)
        ?.map((e) =>
            e == null ? null : Search.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalResults: json['totalResults'] as String,
    response: json['Response'] as String,
  );
}

Map<String, dynamic> _$MoviesToJson(Movies instance) => <String, dynamic>{
      'Search': instance.search,
      'totalResults': instance.totalResults,
      'Response': instance.response,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) {
  return Search(
    title: json['Title'] as String,
    year: json['Year'] as String,
    imdbID: json['imdbID'] as String,
    type: json['Type'] as String,
    poster: json['Poster'] as String,
  )..bookmark = json['bookmark'] as bool;
}

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'imdbID': instance.imdbID,
      'Type': instance.type,
      'Poster': instance.poster,
      'bookmark': instance.bookmark,
    };

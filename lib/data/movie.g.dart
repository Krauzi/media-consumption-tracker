// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    title: json['Title'] as String,
    year: json['Year'] as String,
    runtime: json['Runtime'] as String,
    genre: json['Genre'] as String,
    director: json['Director'] as String,
    actors: json['Actors'] as String,
    country: json['Country'] as String,
    poster: json['Poster'] as String,
    imdbRating: json['imdbRating'] as String,
    imdbID: json['imdbID'] as String,
    type: json['Type'] as String,
  )
    ..key = json['key'] as String
    ..finished = json['finished'] as bool
    ..time = json['time'] as int;
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'key': instance.key,
      'Title': instance.title,
      'Year': instance.year,
      'Runtime': instance.runtime,
      'Genre': instance.genre,
      'Director': instance.director,
      'Actors': instance.actors,
      'Poster': instance.poster,
      'Country': instance.country,
      'imdbRating': instance.imdbRating,
      'imdbID': instance.imdbID,
      'Type': instance.type,
      'finished': instance.finished,
      'time': instance.time,
    };

import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  String key;
  @JsonKey(name: 'Title')
  String title;
  @JsonKey(name: 'Year')
  String year;
  @JsonKey(name: 'Runtime')
  String runtime;
  @JsonKey(name: 'Genre')
  String genre;
  @JsonKey(name: 'Director')
  String director;
  @JsonKey(name: 'Actors')
  String actors;
  @JsonKey(name: 'Poster')
  String poster;
  @JsonKey(name: 'Country')
  String country;
  @JsonKey(name: 'imdbRating')
  String imdbRating;
  @JsonKey(name: 'Plot')
  String plot;
  @JsonKey(name: 'imdbID')
  String imdbID;
  @JsonKey(name: 'Type')
  String type;
  bool finished;
  int time;

  Movie({this.title, this.year, this.runtime, this.genre, this.director,
    this.actors, this.country, this.poster, this.imdbRating, this.plot, this.imdbID, this.type});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  Movie.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        title = snapshot.value["Title"],
        year = snapshot.value["Year"],
        runtime = snapshot.value["Runtime"],
        genre = snapshot.value["Genre"],
        director = snapshot.value["Director"],
        actors = snapshot.value["Actors"],
        poster = snapshot.value["Poster"],
        country = snapshot.value["Country"],
        imdbRating = snapshot.value["imdbRating"],
        plot = snapshot.value["Plot"],
        imdbID = snapshot.value["imdbID"],
        type = snapshot.value["Type"],
        finished = snapshot.value["finished"],
        time = snapshot.value["time"] * -1;
}
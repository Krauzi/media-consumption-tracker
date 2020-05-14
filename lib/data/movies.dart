import 'package:json_annotation/json_annotation.dart';
import 'package:mediaconsumptiontracker/data/search.dart';

part 'movies.g.dart';

@JsonSerializable()
class Movies {
  @JsonKey(name: 'Search')
  List<Search> search;
  @JsonKey(name: 'totalResults')
  String totalResults;
  @JsonKey(name: 'Response')
  String response;

  Movies({this.search, this.totalResults, this.response});

  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);
  Map<String, dynamic> toJson() => _$MoviesToJson(this);
}
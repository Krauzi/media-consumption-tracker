import 'package:json_annotation/json_annotation.dart';

part 'search.g.dart';

@JsonSerializable()
class Search {
  @JsonKey(name: 'Title')
  String title;
  @JsonKey(name: 'Year')
  String year;
  @JsonKey(name: 'imdbID')
  String imdbID;
  @JsonKey(name: 'Type')
  String type;
  @JsonKey(name: 'Poster')
  String poster;
  bool bookmark = false;

  Search({this.title, this.year, this.imdbID, this.type, this.poster});

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
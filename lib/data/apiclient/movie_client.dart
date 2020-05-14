import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../movie.dart';
import '../movies.dart';

part 'movie_client.g.dart';

final apiClient = MovieClient(Dio());

@RestApi(baseUrl: "http://www.omdbapi.com/")
abstract class MovieClient {
  factory MovieClient(Dio dio, {String baseUrl}) = _MovieClient;

  @GET("/")
  Future<Movie> getSingleMovie(
      @Query('i')
      String query,
      @Query('apikey')
      String apiKey
      );

  @GET("/")
  Future<Movies> getQueryMovies(
      @Query('s')
      String query,
      @Query('type')
      String type,
      @Query('y')
      String year,
      @Query('page')
      int page,
      @Query('apikey')
      String apiKey,);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MovieClient implements MovieClient {
  _MovieClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://www.omdbapi.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getSingleMovie(query, apiKey) async {
    ArgumentError.checkNotNull(query, 'query');
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'i': query, 'apikey': apiKey};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Movie.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getQueryMovies(query, type, year, page, apiKey) async {
    ArgumentError.checkNotNull(query, 'query');
    ArgumentError.checkNotNull(type, 'type');
    ArgumentError.checkNotNull(year, 'year');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      's': query,
      'type': type,
      'y': year,
      'page': page,
      'apikey': apiKey
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Movies.fromJson(_result.data);
    return Future.value(value);
  }
}

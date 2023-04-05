import 'package:dio/dio.dart';
import 'package:flutter_movies_app/data/network/entity/movie_entity.dart';
import 'package:flutter_movies_app/domain/exception/network_exception.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({
    required String baseUrl,
    required String apiKey,
    required String apiHost,
  }) {
    _dio = Dio()
      ..options.baseUrl = baseUrl
      ..options.headers = {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': apiHost,
      }
      ..interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
  }

  Future<UpcomingMovies> getUpcomingMovies({
    required int page,
    int? limit,
  }) async {
    final response = await _dio.get(
      'titles/x/upcoming',
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );

    if (response.statusCode != null && response.statusCode! >= 400) {
      throw NetworkException(
        statusCode: response.statusCode!,
        message: response.statusMessage,
      );
    } else if (response.statusCode != null) {
      return UpcomingMovies.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Unknown error');
    }
  }
}

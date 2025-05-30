import 'package:dio/dio.dart';
import 'package:movie_project/core/enum.dart';
import 'package:movie_project/core/logger.dart';

class BaseRepository {
  static final BaseRepository _instance = BaseRepository._internal();

  factory BaseRepository() {
    return _instance;
  }

  BaseRepository._internal();

  final _dio = Dio(
    BaseOptions(
      baseUrl: "https://imdb236.p.rapidapi.com",
      headers: {
        "x-rapidapi-key": "75a5fa1246msh626cd2965e7a641p19d8e5jsn62d4e0a61410",
      },
    ),
  );

  Future<Response?> executeRequest(
    RequestType requestType,
    String path, {
    Object? data,
  }) async {
    try {
      logger.d(_dio.options.baseUrl + path);
      Response? response = await switch (requestType) {
        RequestType.get => _dio.get(path),
        RequestType.post => _dio.post(path, data: data),
        RequestType.put => _dio.put(path, data: data),
        RequestType.delete => _dio.delete(path),
        RequestType.patch => _dio.patch(path, data: data),
      };
      logger.d(response.requestOptions.uri);
      logger.d(response);
      return response;
    } catch (e, st) {
      logger.d(e);
      logger.d(st);
      rethrow;
    }
  }
}

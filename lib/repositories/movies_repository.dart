import 'package:dio/dio.dart';
import 'package:movie_project/core/endpoints.dart';
import 'package:movie_project/exports.dart';
import 'package:movie_project/model/movie_model/movie_model.dart';

class MovieRepository {
  final BaseRepository _baseRepository;
  static final MovieRepository _instance = MovieRepository._internal();
  factory MovieRepository() {
    return _instance;
  }
  MovieRepository._internal() : _baseRepository = BaseRepository();

  Future<List<MovieModel>?> getMovies() async {
    Response? response = await _baseRepository.executeRequest(
      RequestType.get,
      getAllMovies,
    );
    return (response?.data as List)
        .map((val) => MovieModel.fromJson(val))
        .toList();
  }
}

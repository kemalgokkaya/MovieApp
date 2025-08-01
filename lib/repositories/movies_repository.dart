import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_project/exports.dart';
import 'package:movie_project/model/movie_model/movie_model.dart';
import 'package:movie_project/repositories/base_repoistory.dart';

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

final moviesContollerProvider = Provider<MovieRepository>(
  (ref) => MovieRepository(),
);

import 'package:movie_project/model/movie_model/movie_model.dart';
import 'package:movie_project/repositories/database_helper.dart';

class SqflliteController {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertMovie(MovieModel movie) async {
    return await dbHelper.insertMovie(movie.toMap());
  }

  Future<int> deleteMovie(int id) async {
    return await dbHelper.deleteMovie(id);
  }

  Future<List<MovieModel>> readMovie() async {
    final result = await dbHelper.getMovies();
    return result.map((map) => MovieModel.fromMap(map)).toList();
  }
}

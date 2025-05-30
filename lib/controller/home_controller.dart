import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_project/model/movie_model/movie_model.dart';
import 'package:movie_project/repositories/repositories.dart';

class HomeController extends StateNotifier<List<MovieModel>?> {
  final Ref ref;

  HomeController(this.ref) : super(null);
  final MovieRepository _movieRepository = MovieRepository();

  Future getMovie() async {
    List<MovieModel>? response = await _movieRepository.getMovies();
    state = response;
    return state;
  }
}

final moviesContollerProvider =
    StateNotifierProvider<HomeController, List<MovieModel>?>((ref) {
      return HomeController(ref);
    });

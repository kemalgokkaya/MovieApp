import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_project/model/movie_model/movie_model.dart';
import 'package:movie_project/repositories/repositories.dart';

class HomeController extends StateNotifier<List<MovieModel>?> {
  final Ref ref;

  HomeController(super.state, this.ref);
  final MovieRepository _movieRepository = MovieRepository();

  Future getMovie() async {
    List<MovieModel>? response = await _movieRepository.getMovies();
    state = response;
    ref.read(isLoadingProvider.notifier).state = false;
    return state;
  }
}

final moviesContollerProvider =
    StateNotifierProvider<HomeController, List<MovieModel>?>((ref) {
      return HomeController(null, ref);
    });
final isLoadingProvider = StateProvider((ref) => true);

final randomMovieProvider = Provider<MovieModel?>((ref) {
  final movieList = ref.watch(moviesContollerProvider);
  if (movieList == null || movieList.isEmpty) return null;

  movieList.shuffle();
  return movieList.first;
});

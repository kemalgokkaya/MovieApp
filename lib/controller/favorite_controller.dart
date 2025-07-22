import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/movie_model/movie_model.dart';

class FavoriteMoviesNotifier extends StateNotifier<List<MovieModel>> {
  FavoriteMoviesNotifier() : super([]);

  void toggleFavorite(MovieModel movie) {
    if (state.contains(movie)) {
      state = state.where((m) => m != movie).toList();
    } else {
      state = [...state, movie];
    }
  }

  bool isFavorite(MovieModel movie) {
    return state.contains(movie);
  }
}

final favoriteMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, List<MovieModel>>(
      (ref) => FavoriteMoviesNotifier(),
    );

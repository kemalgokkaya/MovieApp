import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_project/model/movie_model/movie_model.dart';
import 'package:movie_project/repositories/repositories.dart';

// Performance optimized controller with caching
class HomeController extends StateNotifier<AsyncValue<List<MovieModel>>> {
  final Ref ref;
  final MovieRepository _movieRepository = MovieRepository();

  // Cache for movies to avoid unnecessary API calls
  static List<MovieModel>? _cachedMovies;
  static DateTime? _lastFetchTime;
  static const Duration _cacheValidDuration = Duration(minutes: 5);

  HomeController(super.state, this.ref);

  Future<void> getMovie() async {
    // Check if we have valid cached data
    if (_cachedMovies != null && _lastFetchTime != null) {
      final timeSinceLastFetch = DateTime.now().difference(_lastFetchTime!);
      if (timeSinceLastFetch < _cacheValidDuration) {
        state = AsyncValue.data(_cachedMovies!);
        return;
      }
    }

    try {
      state = const AsyncValue.loading();

      final response = await _movieRepository.getMovies();

      if (response != null && response.isNotEmpty) {
        // Cache the successful response
        _cachedMovies = response;
        _lastFetchTime = DateTime.now();

        state = AsyncValue.data(response);
      } else {
        state = AsyncValue.error('No movies available', StackTrace.current);
      }
    } catch (error, stackTrace) {
      // If API fails but we have cached data, use it
      if (_cachedMovies != null) {
        state = AsyncValue.data(_cachedMovies!);
      } else {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }

  // Clear cache when needed
  void clearCache() {
    _cachedMovies = null;
    _lastFetchTime = null;
  }

  // Refresh data and clear cache
  Future<void> refreshMovies() async {
    clearCache();
    await getMovie();
  }

  // Get cached movies if available
  List<MovieModel>? get cachedMovies => _cachedMovies;
}

// Optimized providers
final moviesContollerProvider =
    StateNotifierProvider<HomeController, AsyncValue<List<MovieModel>>>((ref) {
      return HomeController(const AsyncValue.loading(), ref);
    });

// Optimized random movie provider with caching
final randomMovieProvider = Provider<MovieModel?>((ref) {
  final movieListAsync = ref.watch(moviesContollerProvider);

  return movieListAsync.when(
    data: (movieList) {
      if (movieList.isEmpty) return null;
      // Use a deterministic approach for better performance
      final now = DateTime.now();
      final index = now.millisecond % movieList.length;
      return movieList[index];
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

// Provider for movie count
final movieCountProvider = Provider<int>((ref) {
  final movieListAsync = ref.watch(moviesContollerProvider);
  return movieListAsync.when(
    data: (movieList) => movieList.length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

// Provider for checking if movies are loaded
final moviesLoadedProvider = Provider<bool>((ref) {
  final movieListAsync = ref.watch(moviesContollerProvider);
  return movieListAsync.hasValue && movieListAsync.value!.isNotEmpty;
});

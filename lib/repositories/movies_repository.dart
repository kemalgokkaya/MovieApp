import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_project/exports.dart';
import 'package:movie_project/model/movie_model/movie_model.dart';
import 'package:movie_project/repositories/base_repoistory.dart';

// Performance optimized repository with caching
class MovieRepository {
  final BaseRepository _baseRepository;
  static final MovieRepository _instance = MovieRepository._internal();

  // Cache for API responses
  static List<MovieModel>? _cachedMovies;
  static DateTime? _lastFetchTime;
  static const Duration _cacheValidDuration = Duration(minutes: 10);

  factory MovieRepository() {
    return _instance;
  }

  MovieRepository._internal() : _baseRepository = BaseRepository();

  Future<List<MovieModel>?> getMovies() async {
    // Check cache first
    if (_cachedMovies != null && _lastFetchTime != null) {
      final timeSinceLastFetch = DateTime.now().difference(_lastFetchTime!);
      if (timeSinceLastFetch < _cacheValidDuration) {
        print("Movies loaded from cache: ${_cachedMovies!.length} movies");
        return _cachedMovies;
      }
    }

    try {
      print("Fetching movies from API...");
      final response = await _baseRepository.executeRequest(
        RequestType.get,
        getAllMovies,
      );

      if (response?.data != null) {
        final movies =
            (response!.data as List)
                .map((val) => MovieModel.fromJson(val))
                .toList();

        // Cache the successful response
        _cachedMovies = movies;
        _lastFetchTime = DateTime.now();

        print("Movies fetched successfully: ${movies.length} movies");
        return movies;
      } else {
        print("No data received from API");
        return _cachedMovies; // Return cached data if available
      }
    } catch (e) {
      print("Error fetching movies: $e");
      // Return cached data if available, otherwise rethrow
      if (_cachedMovies != null) {
        print("Returning cached movies due to API error");
        return _cachedMovies;
      }
      rethrow;
    }
  }

  // Clear cache
  void clearCache() {
    _cachedMovies = null;
    _lastFetchTime = null;
    print("Movie cache cleared");
  }

  // Get cached movies if available
  List<MovieModel>? get cachedMovies => _cachedMovies;

  // Check if cache is valid
  bool get isCacheValid {
    if (_lastFetchTime == null) return false;
    final timeSinceLastFetch = DateTime.now().difference(_lastFetchTime!);
    return timeSinceLastFetch < _cacheValidDuration;
  }

  // Force refresh (clear cache and fetch new data)
  Future<List<MovieModel>?> refreshMovies() async {
    clearCache();
    return await getMovies();
  }

  // Get movies with pagination support
  Future<List<MovieModel>?> getMoviesWithPagination({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // For now, we'll use the same endpoint but could be modified for pagination
      final movies = await getMovies();
      if (movies == null) return null;

      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;

      if (startIndex >= movies.length) return [];

      return movies.sublist(
        startIndex,
        endIndex > movies.length ? movies.length : endIndex,
      );
    } catch (e) {
      print("Error fetching movies with pagination: $e");
      rethrow;
    }
  }

  // Search movies by title
  Future<List<MovieModel>?> searchMovies(String query) async {
    try {
      final allMovies = await getMovies();
      if (allMovies == null) return null;

      final lowercaseQuery = query.toLowerCase();
      return allMovies.where((movie) {
        final title = movie.primaryTitle?.toLowerCase() ?? '';
        final description = movie.description?.toLowerCase() ?? '';
        final genres = movie.genres?.toString().toLowerCase() ?? '';

        return title.contains(lowercaseQuery) ||
            description.contains(lowercaseQuery) ||
            genres.contains(lowercaseQuery);
      }).toList();
    } catch (e) {
      print("Error searching movies: $e");
      rethrow;
    }
  }

  // Get movies by genre
  Future<List<MovieModel>?> getMoviesByGenre(String genre) async {
    try {
      final allMovies = await getMovies();
      if (allMovies == null) return null;

      final lowercaseGenre = genre.toLowerCase();
      return allMovies.where((movie) {
        final genres = movie.genres?.toString().toLowerCase() ?? '';
        return genres.contains(lowercaseGenre);
      }).toList();
    } catch (e) {
      print("Error filtering movies by genre: $e");
      rethrow;
    }
  }
}

// Optimized provider
final moviesRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepository(),
);

// Provider for cached movies
final cachedMoviesProvider = Provider<List<MovieModel>?>((ref) {
  final repository = ref.watch(moviesRepositoryProvider);
  return repository.cachedMovies;
});

// Provider for cache validity
final isCacheValidProvider = Provider<bool>((ref) {
  final repository = ref.watch(moviesRepositoryProvider);
  return repository.isCacheValid;
});

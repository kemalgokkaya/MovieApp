import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/movie_model/movie_model.dart';

// Performance optimized favorite controller
class FavoriteMoviesNotifier extends StateNotifier<List<MovieModel>> {
  FavoriteMoviesNotifier() : super([]);

  // Cache for Firebase operations
  static final Map<String, List<MovieModel>> _firebaseCache = {};
  static DateTime? _lastFirebaseSync;
  static const Duration _cacheValidDuration = Duration(minutes: 2);

  void toggleFavorite(MovieModel movie) {
    if (state.contains(movie)) {
      state = state.where((m) => m.id != movie.id).toList();
    } else {
      state = [...state, movie];
    }
  }

  bool isFavorite(MovieModel movie) {
    return state.any((m) => m.id == movie.id);
  }

  // Optimized Firebase save with caching
  Future<void> saveToFirebase(MovieModel movie, String uid) async {
    try {
      // Check cache first
      if (_isCacheValid(uid)) {
        final cachedFavorites = _firebaseCache[uid] ?? [];
        if (cachedFavorites.any((m) => m.id == movie.id)) {
          print("Movie already in Firebase cache for $uid");
          return;
        }
      }

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("favorites")
          .doc("${movie.id}")
          .set({
            "id": movie.id,
            "title": movie.primaryTitle,
            "description": movie.description,
            "genres": movie.genres,
            "image": movie.primaryImage,
            "addedAt": FieldValue.serverTimestamp(),
          });

      // Update cache
      _updateCache(uid, movie, true);
      print("$uid kullanıcısının favorisi başarıyla eklendi");
    } catch (e) {
      print("Favori ekleme hatası: $e");
      rethrow;
    }
  }

  // Optimized Firebase delete with caching
  Future<void> deleteFavoriteFromFirebase(MovieModel movie, String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("favorites")
          .doc("${movie.id}")
          .delete();

      // Update cache
      _updateCache(uid, movie, false);

      // Local state'i güncelle
      state = state.where((m) => m.id != movie.id).toList();

      print("$uid kullanıcısının favorisi başarıyla silindi");
    } catch (e) {
      print("Favori silme hatası: $e");
      rethrow;
    }
  }

  // Batch operations for better performance
  Future<void> saveMultipleToFirebase(
    List<MovieModel> movies,
    String uid,
  ) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      for (final movie in movies) {
        final docRef = FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("favorites")
            .doc("${movie.id}");

        batch.set(docRef, {
          "id": movie.id,
          "title": movie.primaryTitle,
          "description": movie.description,
          "genres": movie.genres,
          "image": movie.primaryImage,
          "addedAt": FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
      print("${movies.length} favori film başarıyla eklendi");
    } catch (e) {
      print("Toplu favori ekleme hatası: $e");
      rethrow;
    }
  }

  // Optimized Firebase load with caching
  Future<void> loadFavoritesFromFirebase(String uid) async {
    try {
      // Check cache first
      if (_isCacheValid(uid) && _firebaseCache.containsKey(uid)) {
        state = _firebaseCache[uid]!;
        print("Favoriler cache'den yüklendi: ${state.length} film");
        return;
      }

      final snapshot =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .collection("favorites")
              .get();

      final favorites =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return MovieModel(
              id: data['id'] ?? '',
              primaryTitle: data['title'] ?? '',
              description: data['description'] ?? '',
              genres: data['genres'] ?? '',
              primaryImage: data['image'] ?? '',
            );
          }).toList();

      // Update cache
      _firebaseCache[uid] = favorites;
      _lastFirebaseSync = DateTime.now();

      state = favorites;
      print("Favoriler başarıyla yüklendi: ${favorites.length} film");
    } catch (e) {
      print("Favorileri yükleme hatası: $e");
      rethrow;
    }
  }

  // Clear all favorites
  Future<void> clearAllFavorites(String uid) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .collection("favorites")
              .get();

      final batch = FirebaseFirestore.instance.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      // Clear cache and state
      _firebaseCache.remove(uid);
      state = [];

      print("Tüm favoriler başarıyla silindi");
    } catch (e) {
      print("Favorileri temizleme hatası: $e");
      rethrow;
    }
  }

  // Cache management methods
  bool _isCacheValid(String uid) {
    if (_lastFirebaseSync == null) return false;
    final timeSinceLastSync = DateTime.now().difference(_lastFirebaseSync!);
    return timeSinceLastSync < _cacheValidDuration;
  }

  void _updateCache(String uid, MovieModel movie, bool isAdding) {
    final cachedFavorites = _firebaseCache[uid] ?? [];

    if (isAdding) {
      if (!cachedFavorites.any((m) => m.id == movie.id)) {
        cachedFavorites.add(movie);
      }
    } else {
      cachedFavorites.removeWhere((m) => m.id == movie.id);
    }

    _firebaseCache[uid] = cachedFavorites;
    _lastFirebaseSync = DateTime.now();
  }

  // Clear cache for a specific user
  void clearCache(String uid) {
    _firebaseCache.remove(uid);
  }

  // Clear all cache
  void clearAllCache() {
    _firebaseCache.clear();
    _lastFirebaseSync = null;
  }

  // Get cached favorites for a user
  List<MovieModel>? getCachedFavorites(String uid) {
    if (_isCacheValid(uid)) {
      return _firebaseCache[uid];
    }
    return null;
  }
}

// Optimized providers
final favoriteMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, List<MovieModel>>(
      (ref) => FavoriteMoviesNotifier(),
    );

// Provider for favorite count
final favoriteCountProvider = Provider<int>((ref) {
  return ref.watch(favoriteMoviesProvider).length;
});

// Provider for checking if a movie is favorited
final isMovieFavoritedProvider = Provider.family<bool, MovieModel>((
  ref,
  movie,
) {
  final favorites = ref.watch(favoriteMoviesProvider);
  return favorites.any((m) => m.id == movie.id);
});

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/movie_model/movie_model.dart';
import 'package:flutter/material.dart';

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
          debugPrint("Movie already in Firebase cache for $uid");
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
      debugPrint("$uid kullanıcısının favorisi başarıyla eklendi");
    } catch (e) {
      debugPrint("Favori ekleme hatası: $e");
      rethrow;
    }
  }

  Future<void> deleteFavoriteFromFirebase(MovieModel movie, String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("favorites")
          .doc("${movie.id}")
          .delete();

      _updateCache(uid, movie, false);

      state = state.where((m) => m.id != movie.id).toList();

      debugPrint("$uid kullanıcısının favorisi başarıyla silindi");
    } catch (e) {
      debugPrint("Favori silme hatası: $e");
      rethrow;
    }
  }

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
      debugPrint("${movies.length} favori film başarıyla eklendi");
    } catch (e) {
      debugPrint("Toplu favori ekleme hatası: $e");
      rethrow;
    }
  }

  Future<void> loadFavoritesFromFirebase(String uid) async {
    try {
      if (_isCacheValid(uid) && _firebaseCache.containsKey(uid)) {
        state = _firebaseCache[uid]!;
        debugPrint("Favoriler cache'den yüklendi: ${state.length} film");
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

      _firebaseCache[uid] = favorites;
      _lastFirebaseSync = DateTime.now();

      state = favorites;
      debugPrint("Favoriler başarıyla yüklendi: ${favorites.length} film");
    } catch (e) {
      debugPrint("Favorileri yükleme hatası: $e");
      rethrow;
    }
  }

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

      _firebaseCache.remove(uid);
      state = [];

      debugPrint("Tüm favoriler başarıyla silindi");
    } catch (e) {
      debugPrint("Favorileri temizleme hatası: $e");
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

  List<MovieModel>? getCachedFavorites(String uid) {
    if (_isCacheValid(uid)) {
      return _firebaseCache[uid];
    }
    return null;
  }
}

final favoriteMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, List<MovieModel>>(
      (ref) => FavoriteMoviesNotifier(),
    );

final favoriteCountProvider = Provider<int>((ref) {
  return ref.watch(favoriteMoviesProvider).length;
});

final isMovieFavoritedProvider = Provider.family<bool, MovieModel>((
  ref,
  movie,
) {
  final favorites = ref.watch(favoriteMoviesProvider);
  return favorites.any((m) => m.id == movie.id);
});

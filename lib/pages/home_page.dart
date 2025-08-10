import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_project/controller/controller.dart';
import 'package:movie_project/controller/favorite_controller.dart';
import 'package:movie_project/core/router/app_router.gr.dart';
import 'package:movie_project/model/movie_model/movie_model.dart';

// Performance optimized providers
final currentUserProvider = Provider<User?>(
  (ref) => FirebaseAuth.instance.currentUser,
);
final userUidProvider = Provider<String>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.uid ?? '';
});

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Keep state when navigating

  @override
  void initState() {
    super.initState();
    // Use Future.microtask for better performance
    Future.microtask(() {
      ref.read(moviesContollerProvider.notifier).getMovie();
    });
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.pushRoute(const FavoriteRoute());
        break;
      case 1:
        context.pushRoute(const RecommendationRoute());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    final movies = ref.watch(moviesContollerProvider);
    final favoriteList = ref.watch(favoriteMoviesProvider);
    final currentUser = ref.watch(currentUserProvider);
    final uid = ref.watch(userUidProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: _buildGradientDecoration(context),
            child: SafeArea(
              child: Column(
                children: [
                  _buildCustomAppBar(context),
                  Expanded(
                    child: _buildContent(
                      context,
                      movies,
                      favoriteList,
                      currentUser,
                      uid,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Navigation Bar positioned at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 20, // 20px from bottom
            child: _buildBottomNavigation(context),
          ),
        ],
      ),
    );
  }

  // Extracted methods for better performance and readability
  BoxDecoration _buildGradientDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).colorScheme.primary.withAlpha(26),
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.surface,
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          _buildAppBarIcon(context),
          const SizedBox(width: 16),
          Expanded(child: _buildAppBarTitle(context)),
          _buildThemeToggleButton(context),
        ],
      ),
    );
  }

  Widget _buildAppBarIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withAlpha(179),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlpha(77),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.movie_creation, color: Colors.white, size: 24),
    );
  }

  Widget _buildAppBarTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Series Explorer",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          "Discover amazing films",
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.surface.withAlpha(179),
          ),
        ),
      ],
    );
  }

  Widget _buildThemeToggleButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(27),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          Theme.of(context).brightness == Brightness.dark
              ? Icons.light_mode
              : Icons.dark_mode,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AsyncValue<List<MovieModel>> moviesAsync,
    List<MovieModel> favoriteList,
    User? currentUser,
    String uid,
  ) {
    return moviesAsync.when(
      data:
          (movies) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(context, movies.length),
                Expanded(
                  child: _buildMoviesGrid(
                    context,
                    movies,
                    favoriteList,
                    currentUser,
                    uid,
                  ),
                ),
              ],
            ),
          ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error: $error',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(moviesContollerProvider.notifier).getMovie();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, int movieCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withAlpha(128),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "Trending Movies",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          const Spacer(),
          Text(
            "$movieCount movies",
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.surface.withAlpha(153),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoviesGrid(
    BuildContext context,
    List<MovieModel> movies,
    List<MovieModel> favoriteList,
    User? currentUser,
    String uid,
  ) {
    if (movies.isEmpty) {
      return const Center(child: Text('No movies available'));
    }

    return GridView.builder(
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(
          movie: movie,
          isFavorited: favoriteList.contains(movie),
          currentUser: currentUser,
          uid: uid,
          onFavoriteToggle:
              () => _handleFavoriteToggle(movie, currentUser, uid),
        );
      },
    );
  }

  void _handleFavoriteToggle(
    MovieModel movie,
    User? currentUser,
    String uid,
  ) async {
    await ref
        .read(moviesContollerProvider.notifier)
        .handleFavoriteToggle(movie, currentUser, uid, _showSnackBar);
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: _onItemTapped,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, size: 24),
              activeIcon: Icon(Icons.favorite, size: 24),
              label: 'Favoriler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined, size: 24),
              activeIcon: Icon(Icons.movie_creation, size: 24),
              label: 'Öneri',
            ),
          ],
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final bool isFavorited;
  final User? currentUser;
  final String uid;
  final VoidCallback onFavoriteToggle;

  const MovieCard({
    super.key,
    required this.movie,
    required this.isFavorited,
    required this.currentUser,
    required this.uid,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMovieDetail(context),
      child: Hero(
        tag: movie.primaryImage ?? 'movie-${movie.id}',
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(26),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                _buildMovieImage(),
                _buildGradientOverlay(),
                _buildFavoriteButton(),
                _buildMovieInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMovieImage() {
    return Positioned.fill(
      child:
          movie.primaryImage != null
              ? CachedNetworkImage(
                imageUrl: movie.primaryImage!,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildPlaceholder(),
                errorWidget: (context, url, error) => _buildErrorWidget(),
                memCacheWidth: 300,
                memCacheHeight: 450,
              )
              : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade300, Colors.grey.shade400],
        ),
      ),
      child: const Icon(Icons.movie, size: 50, color: Colors.white),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade300, Colors.grey.shade400],
        ),
      ),
      child: const Icon(Icons.broken_image, size: 50, color: Colors.white),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withAlpha(77),
              Colors.black.withAlpha(204),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      top: 12,
      right: 12,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(128),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withAlpha(77), width: 1),
        ),
        child: IconButton(
          icon: Icon(
            isFavorited ? Icons.favorite : Icons.favorite_border,
            color: isFavorited ? Colors.red : Colors.white,
            size: 20,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }

  Widget _buildMovieInfo() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.primaryTitle ?? "Unknown",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  "4.5",
                  style: TextStyle(
                    color: Colors.white.withAlpha(208),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMovieDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _MovieDetailSheet(movie: movie),
    );
  }
}

class _MovieDetailSheet extends StatelessWidget {
  final MovieModel movie;

  const _MovieDetailSheet({required this.movie});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      expand: false,
      builder:
          (context, scrollController) => ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Container(
              decoration: BoxDecoration(
                image:
                    movie.primaryImage != null
                        ? DecorationImage(
                          image: CachedNetworkImageProvider(
                            movie.primaryImage!,
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withAlpha(208),
                            BlendMode.darken,
                          ),
                        )
                        : null,
                color: Colors.black,
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCloseButton(context),
                    const SizedBox(height: 20),
                    _buildMovieTitle(),
                    const SizedBox(height: 16),
                    _buildRatingInfo(),
                    const SizedBox(height: 24),
                    _buildMoviePoster(),
                    const SizedBox(height: 24),
                    if (movie.description != null) ...[
                      _buildDescription(),
                      const SizedBox(height: 24),
                    ],
                    if (movie.interests != null &&
                        movie.interests!.isNotEmpty) ...[
                      _buildGenres(context),
                    ],
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(127),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withAlpha(77), width: 1),
        ),
        child: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Widget _buildMovieTitle() {
    return Text(
      movie.primaryTitle ?? "Untitled",
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildRatingInfo() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                "4.5",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(38),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withAlpha(77), width: 1),
          ),
          child: const Text(
            "2024",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildMoviePoster() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(77),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:
              movie.primaryImage != null
                  ? CachedNetworkImage(
                    imageUrl: movie.primaryImage!,
                    height: 300,
                    width: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildPosterPlaceholder(),
                    errorWidget:
                        (context, url, error) => _buildPosterPlaceholder(),
                  )
                  : _buildPosterPlaceholder(),
        ),
      ),
    );
  }

  Widget _buildPosterPlaceholder() {
    return Container(
      height: 300,
      width: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade600, Colors.grey.shade800],
        ),
      ),
      child: const Icon(Icons.movie, size: 80, color: Colors.white),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Synopsis",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movie.description!,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildGenres(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Genres",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              movie.interests!
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(179),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(77),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}

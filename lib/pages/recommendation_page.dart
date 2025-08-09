import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_project/controller/home_controller.dart';
import 'package:movie_project/model/movie_model/movie_model.dart';

@RoutePage()
class RecommendationPage extends ConsumerStatefulWidget {
  const RecommendationPage({super.key});

  @override
  ConsumerState<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends ConsumerState<RecommendationPage> {
  @override
  void initState() {
    super.initState();
    // Movies yüklendikten sonra öneri al
    Future.microtask(() {
      ref.read(moviesContollerProvider.notifier).getMovie();
    });
  }

  void refreshRecommendation() {
    // Movies'i yeniden yükle ve yeni öneri al
    ref.read(moviesContollerProvider.notifier).refreshMovies();
  }

  // Extracted methods for better performance and readability
  BoxDecoration _buildGradientDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).colorScheme.primary.withOpacity(0.1),
          Theme.of(context).colorScheme.background,
          Theme.of(context).colorScheme.background,
        ],
      ),
    );
  }

  Widget _buildNoRecommendationContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Theme.of(context).colorScheme.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.movie,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No recommendation available',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try refreshing to get a new suggestion',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(
                context,
              ).colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: refreshRecommendation,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Theme.of(context).colorScheme.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Finding your perfect movie...",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(
                context,
              ).colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorContent(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.withOpacity(0.1),
                  Colors.red.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red.shade400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(
                context,
              ).colorScheme.onBackground.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(moviesContollerProvider.notifier).getMovie();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final moviesAsync = ref.watch(moviesContollerProvider);
    final recommendedMovie = ref.watch(randomMovieProvider);

    return Scaffold(
      body: Container(
        decoration: _buildGradientDecoration(context),
        child: SafeArea(
          child: moviesAsync.when(
            data: (movies) {
              if (recommendedMovie == null) {
                return _buildNoRecommendationContent();
              }
              return _buildRecommendationContent(recommendedMovie);
            },
            loading: () => _buildLoadingContent(),
            error: (error, stack) => _buildErrorContent(error),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationContent(MovieModel movie) {
    return Column(
      children: [
        _buildCustomAppBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildMovieCard(movie),
                const SizedBox(height: 24),
                _buildMovieInfo(movie),
                const SizedBox(height: 24),
                _buildActionButtons(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Geri tuşu
          GestureDetector(
            onTap: () => context.router.pop(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Ana ikon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Başlık
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Movie Recommendation",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  "Your perfect match",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.onBackground.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieCard(MovieModel movie) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: Stack(
            children: [
              _buildMovieImage(movie),
              _buildGradientOverlay(),
              _buildMovieBadge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieImage(MovieModel movie) {
    return Positioned.fill(
      child:
          movie.primaryImage != null
              ? CachedNetworkImage(
                imageUrl: movie.primaryImage!,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildPlaceholder(),
                errorWidget: (context, url, error) => _buildErrorWidget(),
                memCacheWidth: 400,
                memCacheHeight: 600,
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
      child: const Icon(Icons.movie, size: 80, color: Colors.white),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade300, Colors.grey.shade400],
        ),
      ),
      child: const Icon(Icons.broken_image, size: 80, color: Colors.white),
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
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieBadge() {
    return Positioned(
      top: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              "RECOMMENDED",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieInfo(MovieModel movie) {
    return Column(
      children: [
        Text(
          movie.primaryTitle ?? 'Unknown Title',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        if (movie.releaseDate != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              "Release Year: ${movie.releaseDate}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        if (movie.description != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              movie.description!,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(
                  context,
                ).colorScheme.onBackground.withOpacity(0.8),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: refreshRecommendation,
              icon: const Icon(Icons.refresh),
              label: const Text(
                "Suggest Another",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: Theme.of(
                  context,
                ).colorScheme.primary.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

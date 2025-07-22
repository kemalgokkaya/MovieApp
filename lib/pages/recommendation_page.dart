import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_project/controller/home_controller.dart'; // Doğru path'e göre ayarla
import 'package:movie_project/model/movie_model/movie_model.dart';

@RoutePage()
class RecommendationPage extends ConsumerStatefulWidget {
  const RecommendationPage({super.key});

  @override
  ConsumerState<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends ConsumerState<RecommendationPage> {
  late MovieModel? recommendedMovie;

  @override
  void initState() {
    super.initState();
    recommendedMovie = ref.read(randomMovieProvider);
  }

  void refreshRecommendation() {
    // Provider'ı yeniden tetikle
    setState(() {
      recommendedMovie = ref.refresh(randomMovieProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (recommendedMovie == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'No recommendation available.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("🎬 Movie Recommendation"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  recommendedMovie?.primaryImage ?? '',
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 48),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              recommendedMovie?.primaryTitle ?? 'Unknown Title',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (recommendedMovie?.releaseDate != null)
              Text(
                "Release Year: ${recommendedMovie!.releaseDate}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: refreshRecommendation,
        label: const Text("Suggest Another"),
        icon: const Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_project/controller/controller.dart';
import 'package:movie_project/controller/theme_controller.dart';
import 'package:movie_project/model/movie_model/movie_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((val) {
      ref.read(moviesContollerProvider.notifier).getMovie();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<MovieModel>? movies = ref.watch(moviesContollerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("What Should i Watch"),

        actions: [
          IconButton(
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
            icon: Icon(Icons.light_mode),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: movies?.length ?? 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 2 / 3,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          MovieModel? newMovies = movies?[index];
          final imageUrl = newMovies?.primaryImage;
          final title = newMovies?.primaryTitle;

          return Column(
            children: [
              AspectRatio(
                aspectRatio: 2 / 3,
                child: Hero(
                  tag: imageUrl ?? "No Image $index",
                  child: InkWell(
                    child:
                        imageUrl != null
                            ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                            )
                            : const Icon(Icons.image_not_supported),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Container(
                              color: Colors.black,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "$title",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Hero(
                                    tag: imageUrl ?? "No Image $index",
                                    child: Image.network(imageUrl ?? ""),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        Text(
                                          "${newMovies?.description}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  14.0,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.tv,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "${newMovies?.type}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  14.0,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "${newMovies?.startYear}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  14.0,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "${newMovies?.averageRating}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  14.0,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "${newMovies?.filmingLocations}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  14.0,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.movie,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "${newMovies?.trailer}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

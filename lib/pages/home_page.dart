import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_project/controller/controller.dart';
import 'package:movie_project/controller/theme_controller.dart';
import 'package:movie_project/core/router/app_router.gr.dart';
import 'package:movie_project/main.dart';
import 'package:movie_project/model/movie_model/movie_model.dart';

@RoutePage()
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
      drawer: NavigationDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GridView.builder(
            itemCount: movies?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 2,
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
                      child: Stack(
                        children: [
                          InkWell(
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
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext context) {
                                  return DraggableScrollableSheet(
                                    expand: false,
                                    initialChildSize: 0.95,
                                    minChildSize: 0.5,
                                    maxChildSize: 1.0,
                                    builder: (context, scrollController) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        child: SingleChildScrollView(
                                          controller: scrollController,
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.of(
                                                          context,
                                                        ).pop();
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      ),
                                                    ),
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

                                              Container(
                                                child:
                                                    imageUrl == null
                                                        ? Placeholder()
                                                        : Hero(
                                                          tag: imageUrl,
                                                          child: Image.network(
                                                            imageUrl,
                                                          ),
                                                        ),
                                              ),
                                              SizedBox(height: 25),
                                              SizedBox(
                                                height: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "${newMovies?.description}",
                                                      style: TextStyle(
                                                        color:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .secondary,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            newMovies?.interests
                                                                    ?.join(
                                                                      ", ",
                                                                    ) ??
                                                                "",
                                                            style: TextStyle(
                                                              color:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .colorScheme
                                                                      .secondary,
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
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            height: MediaQuery.of(context).size.height / 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home),
                IconButton(
                  onPressed: () {
                    appRouter.push(FavoriteRoute());
                  },
                  icon: Icon(Icons.favorite),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(children: [buildHeader(context), buidlMenuItems(context)]),
    ),
  );
}

Widget buildHeader(BuildContext context) => Container(
  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
);
Widget buidlMenuItems(BuildContext context) => Column(
  children: [
    ListTile(
      leading: Icon(Icons.settings),
      title: Text("Settings"),
      onTap: () {
        appRouter.push(SettingsRoute());
      },
    ),
  ],
);

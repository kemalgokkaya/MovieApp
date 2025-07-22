import 'package:auto_route/auto_route.dart';
import 'package:movie_project/core/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(initial: true, page: HomeRoute.page),
    AutoRoute(page: FavoriteRoute.page),
    AutoRoute(page: RecommendationRoute.page),
    AutoRoute(page: SignUpRoute.page),
  ];
}

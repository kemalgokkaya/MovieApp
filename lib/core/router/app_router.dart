import 'package:auto_route/auto_route.dart';
import 'package:movie_project/core/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SignInRoute.page, initial: true, path: "/"),
    AutoRoute(page: HomeRoute.page),
  ];
}

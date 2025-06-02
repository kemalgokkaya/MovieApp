// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:movie_project/pages/favorite_page.dart' as _i1;
import 'package:movie_project/pages/home_page.dart' as _i2;
import 'package:movie_project/pages/settings_page.dart' as _i3;

/// generated route for
/// [_i1.FavoritePage]
class FavoriteRoute extends _i4.PageRouteInfo<void> {
  const FavoriteRoute({List<_i4.PageRouteInfo>? children})
    : super(FavoriteRoute.name, initialChildren: children);

  static const String name = 'FavoriteRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.FavoritePage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.SettingsPage]
class SettingsRoute extends _i4.PageRouteInfo<void> {
  const SettingsRoute({List<_i4.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SettingsPage();
    },
  );
}

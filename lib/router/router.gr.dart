// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:movie_nest_app/views/account_page/account_page.dart' as _i1;
import 'package:movie_nest_app/views/actor_details_page/actor_details_page.dart'
    as _i2;
import 'package:movie_nest_app/views/auth_page/auth_page.dart' as _i3;
import 'package:movie_nest_app/views/error_page/error_page.dart' as _i4;
import 'package:movie_nest_app/views/favorites_page/favorites_page.dart' as _i5;
import 'package:movie_nest_app/views/home_page/main_home_page.dart' as _i6;
import 'package:movie_nest_app/views/movie_details_page/movie_details_page.dart'
    as _i7;
import 'package:movie_nest_app/views/tv_show_details_page/tv_show_details_page.dart'
    as _i8;
import 'package:movie_nest_app/views/youtube_player/youtube_player.dart' as _i9;

/// generated route for
/// [_i1.AccountPage]
class AccountRoute extends _i10.PageRouteInfo<void> {
  const AccountRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountPage();
    },
  );
}

/// generated route for
/// [_i2.ActorDetailsScreen]
class ActorDetailsRoute extends _i10.PageRouteInfo<ActorDetailsRouteArgs> {
  ActorDetailsRoute({
    _i11.Key? key,
    required int id,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ActorDetailsRoute.name,
          args: ActorDetailsRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'ActorDetailsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ActorDetailsRouteArgs>();
      return _i2.ActorDetailsScreen(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class ActorDetailsRouteArgs {
  const ActorDetailsRouteArgs({
    this.key,
    required this.id,
  });

  final _i11.Key? key;

  final int id;

  @override
  String toString() {
    return 'ActorDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i3.AuthPage]
class AuthRoute extends _i10.PageRouteInfo<void> {
  const AuthRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.AuthPage();
    },
  );
}

/// generated route for
/// [_i4.ErrorPage]
class ErrorRoute extends _i10.PageRouteInfo<void> {
  const ErrorRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ErrorRoute.name,
          initialChildren: children,
        );

  static const String name = 'ErrorRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.ErrorPage();
    },
  );
}

/// generated route for
/// [_i5.FavoritesPage]
class FavoritesRoute extends _i10.PageRouteInfo<void> {
  const FavoritesRoute({List<_i10.PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.FavoritesPage();
    },
  );
}

/// generated route for
/// [_i6.MainHomePage]
class MainHomeRoute extends _i10.PageRouteInfo<void> {
  const MainHomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MainHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainHomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.MainHomePage();
    },
  );
}

/// generated route for
/// [_i7.MovieDetailsScreen]
class MovieDetailsRoute extends _i10.PageRouteInfo<MovieDetailsRouteArgs> {
  MovieDetailsRoute({
    _i11.Key? key,
    required int movieId,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          MovieDetailsRoute.name,
          args: MovieDetailsRouteArgs(
            key: key,
            movieId: movieId,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieDetailsRouteArgs>();
      return _i7.MovieDetailsScreen(
        key: args.key,
        movieId: args.movieId,
      );
    },
  );
}

class MovieDetailsRouteArgs {
  const MovieDetailsRouteArgs({
    this.key,
    required this.movieId,
  });

  final _i11.Key? key;

  final int movieId;

  @override
  String toString() {
    return 'MovieDetailsRouteArgs{key: $key, movieId: $movieId}';
  }
}

/// generated route for
/// [_i8.TvShowDetailsScreen]
class TvShowDetailsRoute extends _i10.PageRouteInfo<TvShowDetailsRouteArgs> {
  TvShowDetailsRoute({
    _i11.Key? key,
    required int tvShowId,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          TvShowDetailsRoute.name,
          args: TvShowDetailsRouteArgs(
            key: key,
            tvShowId: tvShowId,
          ),
          initialChildren: children,
        );

  static const String name = 'TvShowDetailsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TvShowDetailsRouteArgs>();
      return _i8.TvShowDetailsScreen(
        key: args.key,
        tvShowId: args.tvShowId,
      );
    },
  );
}

class TvShowDetailsRouteArgs {
  const TvShowDetailsRouteArgs({
    this.key,
    required this.tvShowId,
  });

  final _i11.Key? key;

  final int tvShowId;

  @override
  String toString() {
    return 'TvShowDetailsRouteArgs{key: $key, tvShowId: $tvShowId}';
  }
}

/// generated route for
/// [_i9.YouTubePlayerWidget]
class YouTubePlayerRoute extends _i10.PageRouteInfo<YouTubePlayerRouteArgs> {
  YouTubePlayerRoute({
    _i11.Key? key,
    required String youtubeKey,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          YouTubePlayerRoute.name,
          args: YouTubePlayerRouteArgs(
            key: key,
            youtubeKey: youtubeKey,
          ),
          initialChildren: children,
        );

  static const String name = 'YouTubePlayerRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<YouTubePlayerRouteArgs>();
      return _i9.YouTubePlayerWidget(
        key: args.key,
        youtubeKey: args.youtubeKey,
      );
    },
  );
}

class YouTubePlayerRouteArgs {
  const YouTubePlayerRouteArgs({
    this.key,
    required this.youtubeKey,
  });

  final _i11.Key? key;

  final String youtubeKey;

  @override
  String toString() {
    return 'YouTubePlayerRouteArgs{key: $key, youtubeKey: $youtubeKey}';
  }
}

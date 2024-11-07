// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:movie_nest_app/views/account_page/account_page.dart' as _i1;
import 'package:movie_nest_app/views/actor_info_page/actor_info_page.dart'
    as _i2;
import 'package:movie_nest_app/views/auth_page/auth_page.dart' as _i3;
import 'package:movie_nest_app/views/error_page/error_page.dart' as _i4;
import 'package:movie_nest_app/views/home_page/home_page.dart' as _i5;
import 'package:movie_nest_app/views/movie_details_page/movie_details_page.dart'
    as _i6;
import 'package:movie_nest_app/views/tv_show_details/tv_show_details_page.dart'
    as _i7;

/// generated route for
/// [_i1.AccountPage]
class AccountRoute extends _i8.PageRouteInfo<void> {
  const AccountRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountPage();
    },
  );
}

/// generated route for
/// [_i2.ActorInfoScreen]
class ActorInfoRoute extends _i8.PageRouteInfo<void> {
  const ActorInfoRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ActorInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActorInfoRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.ActorInfoScreen();
    },
  );
}

/// generated route for
/// [_i3.AuthPage]
class AuthRoute extends _i8.PageRouteInfo<void> {
  const AuthRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.AuthPage();
    },
  );
}

/// generated route for
/// [_i4.ErrorPage]
class ErrorRoute extends _i8.PageRouteInfo<void> {
  const ErrorRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ErrorRoute.name,
          initialChildren: children,
        );

  static const String name = 'ErrorRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.ErrorPage();
    },
  );
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeScreen();
    },
  );
}

/// generated route for
/// [_i6.MovieDetailsScreen]
class MovieDetailsRoute extends _i8.PageRouteInfo<MovieDetailsRouteArgs> {
  MovieDetailsRoute({
    _i9.Key? key,
    required int movieId,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          MovieDetailsRoute.name,
          args: MovieDetailsRouteArgs(
            key: key,
            movieId: movieId,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieDetailsRouteArgs>();
      return _i6.MovieDetailsScreen(
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

  final _i9.Key? key;

  final int movieId;

  @override
  String toString() {
    return 'MovieDetailsRouteArgs{key: $key, movieId: $movieId}';
  }
}

/// generated route for
/// [_i7.TvShowDetailsScreen]
class TvShowDetailsRoute extends _i8.PageRouteInfo<TvShowDetailsRouteArgs> {
  TvShowDetailsRoute({
    _i9.Key? key,
    required int tvShowId,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          TvShowDetailsRoute.name,
          args: TvShowDetailsRouteArgs(
            key: key,
            tvShowId: tvShowId,
          ),
          initialChildren: children,
        );

  static const String name = 'TvShowDetailsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TvShowDetailsRouteArgs>();
      return _i7.TvShowDetailsScreen(
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

  final _i9.Key? key;

  final int tvShowId;

  @override
  String toString() {
    return 'TvShowDetailsRouteArgs{key: $key, tvShowId: $tvShowId}';
  }
}

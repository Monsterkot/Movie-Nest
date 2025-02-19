part of 'tv_show_bloc.dart';

class TvShowState {}

class TvShowInitial extends TvShowState {}

class TvShowLoadSuccess extends TvShowState {
  final List<TvShow> tvShows;

  TvShowLoadSuccess({required this.tvShows});
}

class TvShowsByQueryLoadSuccess extends TvShowState {
  final List<TvShow> tvShows;

  TvShowsByQueryLoadSuccess({required this.tvShows});
}

class TvShowLoadFailure extends TvShowState {
}

class TvShowLoading extends TvShowState {}

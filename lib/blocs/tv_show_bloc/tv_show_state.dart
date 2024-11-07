part of 'tv_show_bloc.dart';

class TvShowState {}

class TvShowInitial extends TvShowState {}

class TvShowLoadSuccess extends TvShowState {
  final List<TvShow> tvShows;

  TvShowLoadSuccess({required this.tvShows});
}

class TvShowLoadFailure extends TvShowState {
  final String message;

  TvShowLoadFailure({required this.message});
}

class TvShowLoading extends TvShowState {}

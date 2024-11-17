part of 'tv_show_bloc.dart';

class TvShowEvent {}

class LoadTvShows extends TvShowEvent {}

class SearchTvShows extends TvShowEvent {
  final String query;

  SearchTvShows({required this.query});
}

class ClearSearchQuery extends TvShowEvent{}

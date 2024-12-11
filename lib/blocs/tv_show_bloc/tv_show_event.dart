part of 'tv_show_bloc.dart';

class TvShowEvent {}

class LoadTvShows extends TvShowEvent {}

class SearchTvShows extends TvShowEvent {
  final String query;

  SearchTvShows({required this.query});
}

class LoadTvShowLists extends TvShowEvent {
  final String filter;

  LoadTvShowLists({required this.filter});
}

class ClearSearchQuery extends TvShowEvent {}
